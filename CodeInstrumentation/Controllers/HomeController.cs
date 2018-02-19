using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Matlab.Recognizer;
using Matlab.Nodes;
using Matlab.Info;
using System.Xml.Linq;
using System.IO;
using System.Xml;
using CodeInstrumentation.Models;
using GraphVizWrapper;
using GraphVizWrapper.Commands;
using GraphVizWrapper.Queries;


namespace CodeInstrumentation.Controllers
{
    public class HomeController : Controller
    {
        public const int START = 1;
        public const int END = -1;
        public const int IF = 2;
        public const int LOOP = 3;
        public const int PROCESS = 5;
        public readonly string[] Shape = new string[] { "circle", "circle", "diamond height=0.6 width=1.2", "diamond height=0.6 width=1.2", "parallelogram  width=1.2" };

        public List<Node> Node { get; set; }
        List<Node> Nodes = new List<Node>();
        Node root = new Node();
        Node end = new Node();
        string dot = "";
        int i = 1;
        int branchNumber = 1;
        List<Instrumentation> instRow = new List<Instrumentation>();
        List<Instrumentation> instRowLoop = new List<Instrumentation>();
        Stack<Node> stackOfNode = new Stack<Node>();
        Stack<KeyValuePair<Node, bool?>> Leafs = new Stack<KeyValuePair<Node, bool?>>();
        List<string> AdjacencyList = new List<string>();
        //List<Instrumentation> InsturmentedRow = new List<Instrumentation>();
        List<string> ListOfPath = new List<string>();
        string InputFilePath;
        string OutputXMLPath;
        string InstrumentedFilePath;
        string InformationCFGFilePath;
        string DotFilePath;
        int EdgesCount = 0;
        public ActionResult Index()
        {
            OutputXMLPath = Path.Combine(Server.MapPath("~/Files"), "parsecode.xml");
            InstrumentedFilePath = Path.Combine(Server.MapPath("~/Files"), "instrumentedcode.m");
            InformationCFGFilePath = Path.Combine(Server.MapPath("~/Files"), "InformationCFGFilePath.m");
            var SourceCode = "";
            if (Request["SourceCode"] != null)
            {
                SourceCode = Request["SourceCode"].ToString();
                InputFilePath = Path.Combine(Server.MapPath("~/Files"), "sourcecode.m");
                using (StreamWriter sw = System.IO.File.CreateText(InputFilePath))
                {
                    sw.Write(SourceCode);
                }
                var parse = MatlabParser.ParseCodeToXML(InputFilePath, OutputXMLPath).ToString();
                if (parse == "Sukses")
                {
                    XDocument doc = XDocument.Load(OutputXMLPath);
                    BuildNodes(doc.Root.Descendants("Function.Statements").Elements());
                    BuildPath();
                    ViewBag.Keterangan = PrintCode();
                    Instrumentation(doc.Root.Descendants("Function"));
                    var getStartProcessQuery = new GetStartProcessQuery();
                    var getProcessStartInfoQuery = new GetProcessStartInfoQuery();
                    var registerLayoutPluginCommand = new RegisterLayoutPluginCommand(getProcessStartInfoQuery, getStartProcessQuery);

                    var wrapper = new GraphGeneration(getStartProcessQuery,
                                                      getProcessStartInfoQuery,
                                                      registerLayoutPluginCommand);

                    var dotNode = "";
                    //foreach (var node in Nodes)
                    //{
                    //    dotNode += node.Number + " [shape=" + Shape[node.Type] + " label = \"" + node.Label + "\"] ";
                    //}

                    var bytes = wrapper.GenerateGraph("digraph G { graph [label=\"\" nodesep=0.8] { " + dotNode + " } " + dot + "}", Enums.GraphReturnType.Jpg);
                    //var bytes = wrapper.GenerateGraph("digraph { 1 -> 2 [ label=\"True\"  fontsize=10 ]; 1 -> 3 [ label=\"False\"  fontsize=10 ]; 2 -> 4; 3 -> 4;}", Enums.GraphReturnType.Jpg);

                    var viewModel = string.Format("data:image/jpg;base64,{0}", Convert.ToBase64String(bytes));
                    ViewBag.CFG = viewModel;
                    ViewBag.Dot = ("digraph G { <br/>graph [label=\"\" nodesep=0.8]  <br/>" + dot + "}").Replace(";", ";<br/>");
                    ViewBag.InstrumentedCode = System.IO.File.ReadAllText(InstrumentedFilePath);
                    ViewBag.InformationCFG = System.IO.File.ReadAllText(InformationCFGFilePath);
                    ViewBag.LineResult = System.IO.File.ReadAllLines(InstrumentedFilePath).Count() + 1;
                    ViewBag.ListOfPath = ListOfPath;
                    BuildAdjacencyList();
                    ViewBag.AdjacencyList = AdjacencyList;
                    ViewBag.Parse = "true";
                }
                else
                    ViewBag.Parse = parse;
                ViewBag.Code = System.IO.File.ReadAllText(InputFilePath);
                ViewBag.Line = System.IO.File.ReadAllLines(InputFilePath).Count() + 1;
            }
            else
            {
                ViewBag.Code = "";
                ViewBag.Line = 25;
            }
            ViewBag.NodesCount = Nodes.Count();
            ViewBag.EdgesCount = EdgesCount;
            return View();
        }
        void BuildNodes(IEnumerable<XElement> xmlElement)
        {
            var node = new Node(i++, 1, 1, START, "Start");
            Nodes.Add(node);
            stackOfNode.Push(node);

            TraversedNode(xmlElement, null);


            if (stackOfNode.Peek().Type == END)
            {
                stackOfNode.Peek().LineNumber = System.IO.File.ReadAllLines(InputFilePath).Count();
                stackOfNode.Peek().ColumnNumber = 1;
            }
            if (Leafs.Count > 0)
            {
                var endNode = new Node(i, System.IO.File.ReadAllLines(InputFilePath).Count(), 1, END, "End");
                Nodes.Add(endNode);
                while (Leafs.Count() > 0)
                {
                    var leaf = Leafs.Peek();
                    leaf.Key.AddEdge(new Edge(endNode, leaf.Value));
                    EdgesCount++;
                    dot += leaf.Key.Number + "->" + endNode.Number + (leaf.Value != null ? " [ label=\"" + leaf.Value + "\"  fontsize=10 ]" : "") + ";";
                    Leafs.Pop();
                }
            }
        }
        void BuildPath()
        {
            end = stackOfNode.Peek();
            stackOfNode.Clear();
            stackOfNode.Push(Nodes.FirstOrDefault());
            var root = Nodes.FirstOrDefault();
            TraversedPath(root.Edges.FirstOrDefault().To, root.Edges.FirstOrDefault(), root.Number.ToString() + " " + root.Edges.FirstOrDefault().To.Number.ToString());
        }
        void TraversedPath(Node node, Edge edge, string parentPath)
        {
            node.setVisit(edge, true);
            if (node.Number != end.Number)
            {
                foreach (var item in node.Edges)
                {
                    if (item.isVisited == false)
                    {
                        TraversedPath(item.To, item, parentPath + " " + (item.Type != null ? "(" + item.Type.ToString().Substring(0, 1) + ")" : "") + " " + (item.To.Number == i ? "" : item.To.Number.ToString()));
                        item.isVisited = false;
                    }
                }
            }
            else
            {
                ListOfPath.Add(parentPath);
            }
        }

        public void BuildAdjacencyList()
        {
            var temp = "";
            foreach(var item in Nodes)
            {
                temp = item.Number.ToString();
                foreach(var item2 in item.Edges)
                {
                    temp += " -> " + item2.To.Number;
                }
                AdjacencyList.Add(temp);
            }
        }
        private void TraversedNode(IEnumerable<XElement> Node, bool? Edge)
        {
            if (Node.Count() > 0)
            {
                var el = 0;
                foreach (var element in Node)
                {
                    el++;
                    if (element.Name == "If")
                    {
                        var temp = stackOfNode.Peek();
                        if (temp.Type == PROCESS || temp.Type == END)
                        {
                            stackOfNode.Peek().LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
                            stackOfNode.Peek().ColumnNumber = Convert.ToInt32(element.Attribute("Column").Value);
                            stackOfNode.Peek().Type = IF;
                            stackOfNode.Peek().Label = temp.Number.ToString();
                        }
                        else
                        {
                            temp = new Node(i, Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value), IF, i++.ToString());
                            Nodes.Add(temp);
                            stackOfNode.Peek().AddEdge(new Edge(temp, Edge));
                            EdgesCount++;
                            dot += stackOfNode.Peek().Number + "->" + temp.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
                            stackOfNode.Push(temp);
                        }
                        var IfPart = element.Elements().Where(x => x.Name == "If.IfPart");
                        var ElseIfPart = element.Elements().Where(x => x.Name == "If.ElseIfParts");
                        var ElsePart = element.Elements().Where(x => x.Name == "If.ElsePart");
                        if (IfPart.Count() > 0)
                        {
                            var newNode = new Node(i++, Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Column").Value), PROCESS, "T");
                            Nodes.Add(newNode);
                            temp.AddEdge(new Edge(newNode, true));
                            EdgesCount++;
                            dot += temp.Number + "->" + newNode.Number + " [ label=\"" + true + "\"  fontsize=10 ];";
                            stackOfNode.Push(newNode);
                            TraversedNode(IfPart.Elements().Elements().Where(x => x.Name == "IfPart.Statements").Elements(), true);
                        }

                        foreach (var item in ElseIfPart.Elements())
                        {
                            var newNode = new Node(i++, Convert.ToInt32(item.Attribute("Line").Value), Convert.ToInt32(item.Attribute("Column").Value), PROCESS, "T");
                            Nodes.Add(newNode);
                            temp.AddEdge(new Edge(newNode, true));
                            EdgesCount++;
                            dot += temp.Number + "->" + newNode.Number + " [ label=\"" + true + "\"  fontsize=10 ];";
                            stackOfNode.Push(newNode);
                            TraversedNode(item.Elements().Where(x => x.Name == "ElseIfPart.Statements").Elements(), true);
                        }
                        if (ElsePart.Count() > 0)
                        {
                            var newNode = new Node(i++, Convert.ToInt32(ElsePart.Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(ElsePart.Elements().FirstOrDefault().Attribute("Column").Value), PROCESS, "F");
                            Nodes.Add(newNode);
                            temp.AddEdge(new Edge(newNode, false));
                            EdgesCount++;
                            dot += temp.Number + "->" + newNode.Number + " [ label=\"" + false + "\"  fontsize=10 ];";
                            stackOfNode.Push(newNode);

                            TraversedNode(ElsePart.Elements().Elements().Where(x => x.Name == "ElsePart.Statements").Elements(), false);

                            Node EndNode = new Node();
                            if (stackOfNode.Peek() == newNode && stackOfNode.Skip(1).FirstOrDefault().Type == END)
                            {
                                EndNode = stackOfNode.Skip(1).FirstOrDefault();
                                stackOfNode.Pop();
                                stackOfNode.Pop();
                                stackOfNode.Push(newNode);
                                stackOfNode.Push(EndNode);
                            }
                            else if (stackOfNode.Peek().Type != END)
                            {

                                EndNode = new Node(i++, Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Column").Value) - 3, END, branchNumber++.ToString());
                                 Nodes.Add(EndNode);
                                stackOfNode.Push(EndNode);
                            }
                        }
                        else
                        {
                            Node EndNode = new Node();
                            if (stackOfNode.Peek().Type != END)
                            {
                                EndNode = new Node(i++, Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Column").Value) - 3, END, branchNumber++.ToString());
                                Nodes.Add(EndNode);
                                stackOfNode.Push(EndNode);
                            }
                            else
                                EndNode = stackOfNode.Peek();

                            temp.AddEdge(new Edge(EndNode, null));
                            EdgesCount++;
                            dot += temp.Number + "->" + EndNode.Number + ";";
                        }
                        if (stackOfNode.Peek().Type == END)
                        { stackOfNode.Peek().LineNumber = Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value);
                            stackOfNode.Peek().ColumnNumber = Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Column").Value) - 3;
                         }
                    }
                    else if (element.Name == "Switch")
                    {
                        var temp = stackOfNode.Peek();
                        if (temp.Type == PROCESS || temp.Type == END)
                        {
                            stackOfNode.Peek().LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
                            stackOfNode.Peek().ColumnNumber = Convert.ToInt32(element.Attribute("Column").Value);
                            stackOfNode.Peek().Type = IF;
                            stackOfNode.Peek().Label = temp.Number.ToString();
                        }
                        else
                        {
                            temp = new Node(i, Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value), IF, i++.ToString());
                            Nodes.Add(temp);
                            stackOfNode.Peek().AddEdge(new Edge(temp, Edge));
                            EdgesCount++;
                            dot += stackOfNode.Peek().Number + "->" + temp.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
                            stackOfNode.Push(temp);
                        }
                        var casePart = element.Elements().Where(x => x.Name == "Switch.CaseParts").Elements();
                        List<Node> tempCase = new List<Node>();
                        foreach (var caseElement in casePart)
                        {
                            var newNode = new Node(i, Convert.ToInt32(caseElement.Attribute("Line").Value), Convert.ToInt32(caseElement.Attribute("Column").Value), PROCESS, i++.ToString());
                            Nodes.Add(newNode);
                            temp.AddEdge(new Edge(newNode, null));
                            EdgesCount++;
                            dot += temp.Number + "->" + newNode.Number + ";";
                            stackOfNode.Push(newNode);
                            tempCase.Add(newNode);
                            TraversedNode(caseElement.Elements().Where(x => x.Name == "Switch.Statements").Elements(), null);
                        }
                        var EndNode = new Node(i, Convert.ToInt32(element.Elements().Where(x => x.Name == "Switch.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(element.Elements().Where(x => x.Name == "Switch.Terminator").Elements().FirstOrDefault().Attribute("Column").Value) - 3, END, i++.ToString());
                        Nodes.Add(EndNode);
                        stackOfNode.Push(EndNode);
                    }
                    else if (element.Name == "For" || element.Name == "While")
                    {
                        var temp = stackOfNode.Peek();

                        if (temp.Type == PROCESS || temp.Type == END)
                        {
                            stackOfNode.Peek().LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
                            stackOfNode.Peek().ColumnNumber = Convert.ToInt32(element.Attribute("Column").Value);
                            stackOfNode.Peek().Type = LOOP;
                            stackOfNode.Peek().Label = temp.Number.ToString();
                        }
                        else
                        {
                            temp = new Node(i, Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value), LOOP, i++.ToString());
                            Nodes.Add(temp);
                            stackOfNode.Peek().AddEdge(new Edge(temp, Edge));
                            EdgesCount++;
                            dot += stackOfNode.Peek().Number + "->" + temp.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
                            stackOfNode.Push(temp);
                        }
                        TraversedNode(element.Elements().Where(x => x.Name.ToString().Contains("Statements")).Elements(), true);
                        stackOfNode.Peek().AddEdge(new Edge(temp, null));
                        EdgesCount++;
                        dot += stackOfNode.Peek().Number + "->" + temp.Number + " ;";
                        stackOfNode.Pop();

                        //stackOfNode.Peek().Type = PROCESS;
                        var EndNode = new Node(i, Convert.ToInt32(element.Elements().Where(x => x.Name.ToString().Contains("Terminator")).Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(element.Elements().Where(x => x.Name.ToString().Contains("Terminator")).Elements().FirstOrDefault().Attribute("Column").Value) - 3, END, i++.ToString());
                        Nodes.Add(EndNode);
                        instRowLoop.Add(new Instrumentation(EndNode.LineNumber, EndNode.ColumnNumber, "traversedPath = [traversedPath '" + stackOfNode.Peek().Number + " ' ];"));
                
                        stackOfNode.Peek().AddEdge(new Edge(EndNode, false));
                        EdgesCount++;
                        dot += stackOfNode.Peek().Number + "->" + EndNode.Number + " [ label=\"" + false + "\"  fontsize=10 ];";
                        stackOfNode.Pop();
                        stackOfNode.Push(EndNode);
                    }
                    else// if (element.Name == "Assignment")
                    {
                        if (stackOfNode.Count() > 0)
                        {
                            XElement n;
                             if (element.Name == "Assignment")
                                n = element.Descendants("Var").FirstOrDefault();
                             else 
                                n = element;
                            switch (stackOfNode.Peek().Type)
                            {
                                case START:
                                    var newNode = new Node(i++, Convert.ToInt32(n.Attribute("Line").Value), Convert.ToInt32(n.Attribute("Column").Value), PROCESS, "");
                                    Nodes.Add(newNode);
                                    stackOfNode.Peek().AddEdge(new Edge(newNode, Edge));
                                    EdgesCount++;
                                    dot += stackOfNode.Peek().Number + "->" + newNode.Number + ";";
                                    stackOfNode.Push(newNode);
                                    break;
                                case LOOP:
                                    newNode = new Node(i++, Convert.ToInt32(n.Attribute("Line").Value), Convert.ToInt32(n.Attribute("Column").Value), PROCESS, "");
                                    Nodes.Add(newNode);
                                    stackOfNode.Peek().AddEdge(new Edge(newNode, Edge));
                                    EdgesCount++;
                                    dot += stackOfNode.Peek().Number + "->" + newNode.Number + (Edge != null ? " [ label=\"" + Edge + "\"  fontsize=10 ]" : "") + ";";
                                    stackOfNode.Push(newNode);
                                    break;
                                default:
                                    if (el == 1)
                                    {
                                        var z = element.Elements().Elements().FirstOrDefault();
                                        stackOfNode.Peek().LineNumber = Convert.ToInt32(n.Attribute("Line").Value);
                                        stackOfNode.Peek().ColumnNumber = Convert.ToInt32(n.Attribute("Column").Value);
                                    }
                                    break;
                            }
                        }
                    }
                    if (stackOfNode.Count() > 0)
                    {
                        if (stackOfNode.Peek().Type == END)
                        {
                            var EndNode = stackOfNode.Peek();
                            stackOfNode.Pop();//pop yang endNode dulu
                            while (stackOfNode.Count() > 0 && stackOfNode.Peek().Type == PROCESS)
                            {
                                var leaf = stackOfNode.Peek();
                                stackOfNode.Pop();
                                leaf.AddEdge(new Edge(EndNode, null));
                                EdgesCount++;
                                dot += leaf.Number + "->" + EndNode.Number + ";";
                            }
                            while (Leafs.Count() > 0)
                            {
                                var leaf = Leafs.Peek();
                                leaf.Key.AddEdge(new Edge(EndNode, leaf.Value));
                                EdgesCount++;
                                dot += leaf.Key.Number + "->" + EndNode.Number + (leaf.Value != null ? " [ label=\"" + leaf.Value + "\"  fontsize=10 ]" : "") + ";";
                                Leafs.Pop();
                            }
                            if (stackOfNode.Count() > 0 && stackOfNode.Peek().Type == IF)
                            {
                                stackOfNode.Pop();//pop bukanya
                            }
                            stackOfNode.Push(EndNode);
                        }
                    }
                }

            }
            else
            {
                Leafs.Push(new KeyValuePair<Node, bool?>(stackOfNode.Peek(), null));
                stackOfNode.Pop();
            }
        }
        private void Instrumentation(IEnumerable<XElement> Node)
        {
            var startRow = Convert.ToInt32(Node.FirstOrDefault().Attribute("Line").Value);
            var startCol = Convert.ToInt32(Node.FirstOrDefault().Attribute("Column").Value);
            var functionOutputs = Node.Elements().Where(x => x.Name == "Function.Outputs").Elements();
            var temp = "";
            var lineNumber = 1;
            var i = 1;
            branchNumber = 1;
            foreach (var row in Nodes)
            {
                if (row.Edges.Where(y => y.Type != null).Count() > 0)
                    instRow.Add(new Instrumentation(row.LineNumber, row.ColumnNumber, "% instrument Branch # " + branchNumber++.ToString()));
                instRow.Add(new Instrumentation(row.LineNumber + (row.Type == END && row.Edges.Count() > 0 ? 1 : 0), row.ColumnNumber, "traversedPath = [traversedPath '" + row.Number + " ' ];"));
                foreach (var row2 in row.Edges.Where(y => y.Type != null))
                {
                    if (instRow.Where(x => x.LineNumber == row2.To.LineNumber + (row2.To.Type == END && row2.To.Edges.Count() > 0 ? 1 : 0) && x.ColumnNumber == row2.To.ColumnNumber && x.Text == "traversedPath = [traversedPath '(" + row2.Type.ToString().Substring(0, 1) + ") ' ];").Count() == 0)
                        instRow.Add(new Instrumentation(row2.To.LineNumber + (row2.To.Type == END && row2.To.Edges.Count() > 0 ? 1 : 0), row2.To.ColumnNumber, "traversedPath = [traversedPath '(" + row2.Type.ToString().Substring(0, 1) + ") ' ];"));
                }
            }
            StreamWriter sc = System.IO.File.CreateText(InformationCFGFilePath);
            using (StreamWriter sw = System.IO.File.CreateText(InstrumentedFilePath))
            {
                foreach (string line in System.IO.File.ReadLines(InputFilePath))
                {
                    if (lineNumber == startRow)
                    {
                        if (functionOutputs.Count() == 1)
                        {
                            temp = line.Insert((Convert.ToInt32(functionOutputs.FirstOrDefault().Attribute("Column").Value) + functionOutputs.FirstOrDefault().Descendants("Name.Ids").Elements().FirstOrDefault().Attribute("Text").Value.Length) - 1, "]");
                            temp = temp.Insert(startRow + 8, "[traversedPath,");
                        }
                        else
                            temp = line.Insert(Convert.ToInt32(functionOutputs.FirstOrDefault().Attribute("Column").Value) - 1, "traversedPath,");
                        sw.WriteLine(temp);
                        sw.WriteLine("traversedPath = [];");
                    }

                    var inst = instRow.Where(x => x.LineNumber == lineNumber);
                    foreach (var row in inst)
                    {
                        temp = "";
                        for (int j = 1; j < row.ColumnNumber; j++)
                            temp += "\t";
                        sw.WriteLine(temp + row.Text);
                    }

                    inst = instRowLoop.Where(x => x.LineNumber == lineNumber);
                    foreach (var row in inst)
                    {
                        temp = "";
                        for (int j = 1; j < row.ColumnNumber; j++)
                            temp += "\t";
                        sw.WriteLine(temp + row.Text);
                    }
                    if (lineNumber != startRow)
                        sw.WriteLine(line);
                    temp = "";
                    var node = Nodes.Where(x => x.LineNumber == lineNumber).FirstOrDefault();
                    if (node != null)
                        temp = " <b style='color:red'>Node " + node.Number + "</b>";
                    sc.WriteLine(line + temp);
                    lineNumber++;
                }

                foreach (var row in instRow.Where(x => x.LineNumber > System.IO.File.ReadAllLines(InputFilePath).Count()))
                {
                    temp = "";
                    for (int j = 1; j < row.ColumnNumber; j++)
                        temp += "\t";
                    sw.WriteLine(temp + row.Text);
                }
            }

            sc.Close();
        }
        private string PrintCode()
        {
            var lineNumber = 1;
            var result = "<ul>";
            var i = 1;
            foreach (string line in System.IO.File.ReadLines(InputFilePath))
            {
                var row = Nodes.Where(x => x.LineNumber == lineNumber).FirstOrDefault();
                if (row != null)
                {
                    result += "<li><b>Node " + row.Number + " : </b></li>";
                }
                result += line + "<br/>";
                lineNumber++;
            }
            result += "</ul>";
            return result;
        }

    }
}