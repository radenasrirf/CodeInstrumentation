using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Matlab.Utils;
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
        Graph graph = new Graph();
        Nodes root = new Nodes();
        string dot = "";
        int i = 1;
        string[] token = { "If", "Case", "Assignment" };
        // bool true : open, false: close, null : node
        Stack<KeyValuePair<Nodes, bool?>> stackOfNodes = new Stack<KeyValuePair<Nodes, bool?>>();
        List<Nodes> Leafs = new List<Nodes>();
        List<Tuple<int, int>> InsturmentedRow = new List<Tuple<int, int>>();
        List<string> ListOfPath = new List<string>();
        string InputFilePath;
        string OutputXMLPath;
        string InstrumentedFilePath;
        public ActionResult Index()
        {
            InputFilePath = Path.Combine(Server.MapPath("~/Files"), "triangle.m");
            OutputXMLPath = Path.Combine(Server.MapPath("~/Files"), "output.xml");
            InstrumentedFilePath = Path.Combine(Server.MapPath("~/Files"), "triangle_instrumented.m");
            ParseCodeToXML();
            BuildGraph();
            BuildPath();
            Instrumentation();
            var getStartProcessQuery = new GetStartProcessQuery();
            var getProcessStartInfoQuery = new GetProcessStartInfoQuery();
            var registerLayoutPluginCommand = new RegisterLayoutPluginCommand(getProcessStartInfoQuery, getStartProcessQuery);

            // GraphGeneration can be injected via the IGraphGeneration interface

            var wrapper = new GraphGeneration(getStartProcessQuery,
                                              getProcessStartInfoQuery,
                                              registerLayoutPluginCommand);


            var bytes = wrapper.GenerateGraph("digraph{" + dot + "}", Enums.GraphReturnType.Jpg);

            var viewModel = string.Format("data:image/jpg;base64,{0}", Convert.ToBase64String(bytes));
            ViewBag.CFG = viewModel;
            ViewBag.Code = System.IO.File.ReadAllText(InputFilePath);
            ViewBag.InstrumentedCode = System.IO.File.ReadAllText(InstrumentedFilePath);
            ViewBag.Lines = System.IO.File.ReadAllLines(InstrumentedFilePath).Count() + 1;
            ViewBag.ListOfPath = ListOfPath;
            return View();
        }
        void ParseCodeToXML()
        {


            Result<UnitNode> result = MRecognizer.RecognizeFile(InputFilePath, true, null);

            if (result.Report.IsOk)
            {
                XDocument document = NodeToXmlBuilder.Build(result.Value);
                document.Save(OutputXMLPath);
            }
            else
            {
                foreach (Message m in result.Report)
                {
                    Console.WriteLine("[{0}] Line: [{1}] Column: [{2}] Text: [{3}]", m.Severity, m.Line, m.Column, m.Text);
                }
            }
        }
        void BuildGraph()
        {
            XDocument doc = XDocument.Load(OutputXMLPath);

            var xmlElement = doc.Root.Descendants("Function.Statements").Elements();
            var startNode = new Nodes(i++, 0);
            graph.AddNode(startNode);

            stackOfNodes.Push(new KeyValuePair<Nodes, bool?>(startNode, true));

            TraversedNodes(xmlElement);
            graph.AddNode(new Nodes(i, System.IO.File.ReadAllLines(InputFilePath).Count()));
            foreach (var leaf in Leafs)
            {
                graph.AddEdge(leaf, graph.Nodes.Where(x => x.Number == i).FirstOrDefault());
                dot += leaf.Number + "->" + i + ";";
            }
        }
        void BuildPath()
        {
            TraversedPath(graph.Nodes.FirstOrDefault(), graph.Nodes.FirstOrDefault().Number.ToString());
        }
        void TraversedPath(Nodes nodes, string parentPath)
        {
            if (nodes.Children.Count() > 0)
            {
                foreach (var item in nodes.Children)
                {
                    TraversedPath(item, parentPath + " - " + item.Number);
                    graph.visit(item);
                }
            }
            else
                ListOfPath.Add(parentPath);
        }
        private void TraversedNodes(IEnumerable<XElement> nodes)
        {
            if (nodes.Count() > 0)
            {
                foreach (var element in nodes)
                {
                    if (element.Name == "If")
                    {
                        InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
                        var caseElement = element.Elements()
                                    .Where(x => x.Name == "If.IfPart" || x.Name == "If.ElsePart");

                        var temp = stackOfNodes.First().Key;
                        stackOfNodes.Pop();
                        stackOfNodes.Push(new KeyValuePair<Nodes, bool?>(temp, true));

                        foreach (var childElement in caseElement)
                        {
                            var newNodes = new Nodes(i++, Convert.ToInt32(childElement.Elements().FirstOrDefault().Attribute("Line").Value));
                            graph.AddNode(newNodes);
                            graph.AddEdge(stackOfNodes.First().Key, newNodes);
                            dot += stackOfNodes.First().Key.Number + "->" + newNodes.Number + ";";
                            stackOfNodes.Push(new KeyValuePair<Nodes, bool?>(newNodes, false));
                            // if.ifpart / ifpart / ifpart statement / Elements()
                            var t = childElement.Elements().Elements().Select(y => y.Name.ToString());
                            TraversedNodes(childElement.Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements());
                        }
                        //var endNode = new Nodes(i++, Convert.ToInt32(element
                        //                    .Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value));
                        //graph.AddNode(endNode);
                        //Leafs.Add(endNode);
                        //while (stackOfNodes.FirstOrDefault().Value != true)
                        //{
                        //    dot += stackOfNodes.First().Key.Number + "->" + endNode.Number + ";";
                        //    stackOfNodes.Pop();
                        //}
                        if (stackOfNodes.FirstOrDefault().Value == true)
                            stackOfNodes.Pop();
                    }
                    else
                    {
                        switch (stackOfNodes.FirstOrDefault().Value)
                        {
                            case true:
                                var newNodes = new Nodes(i++, Convert.ToInt32(element.Attribute("Line").Value));
                                graph.AddNode(newNodes);
                                graph.AddEdge(stackOfNodes.First().Key, newNodes);
                                dot += stackOfNodes.First().Key.Number + "->" + newNodes.Number + ";";
                                stackOfNodes.Push(new KeyValuePair<Nodes, bool?>(newNodes, null));
                                break;
                            case null:
                                break;
                            default:
                                Leafs.Add(stackOfNodes.FirstOrDefault().Key);
                                stackOfNodes.Pop();
                                break;

                        }
                    }
                }
            }
            else
            {
                Leafs.Add(stackOfNodes.FirstOrDefault().Key);
                stackOfNodes.Pop();
            }
        }
        private void Instrumentation()
        {
            var lineNumber = 1;
            var startNumber = InsturmentedRow != null ? InsturmentedRow.FirstOrDefault().Item1 : lineNumber + 1;
            var i = 1;
            using (StreamWriter sw = System.IO.File.CreateText(InstrumentedFilePath))
            {
                foreach (string line in System.IO.File.ReadLines(InputFilePath))
                {
                    if (lineNumber == startNumber)
                        sw.WriteLine("traversedPath = [];");
                    var row = InsturmentedRow.Where(x => x.Item1 == lineNumber).FirstOrDefault();
                    if (row != null)
                    {
                        var temp = "";
                        for (int j = 1; j < row.Item2; j++)
                            temp += "\t";
                        sw.WriteLine(temp + "% instrument Branch # " + i);
                        sw.WriteLine(temp + "traversedPath = [traversedPath " + i++ + "];");
                    }
                    sw.WriteLine(line);
                    lineNumber++;
                }
            }
        }


        private void ProcesNode(XmlNode node, string parentPath)
        {
            if (!node.HasChildNodes || ((node.ChildNodes.Count == 1) && (node.FirstChild is System.Xml.XmlText)))
            {
                System.Diagnostics.Debug.WriteLine(parentPath + "/" + node.Name);
            }
            else
            {
                foreach (XmlNode child in node.ChildNodes)
                {
                    ProcesNode(child, parentPath + "/" + node.Name);
                }
            }
        }
        //private void LoadTreeFromXmlDocument(XmlDocument dom)
        //{
        //    try
        //    {
        //        // SECTION 2. Initialize the TreeView control.
        //        treeView1.Nodes.Clear();

        //        // SECTION 3. Populate the TreeView with the DOM nodes.
        //        foreach (XmlNode node in dom.DocumentElement.ChildNodes)
        //        {
        //            if (node.Name == "namespace" && node.ChildNodes.Count == 0 && string.IsNullOrEmpty(GetAttributeText(node, "name")))
        //                continue;
        //            AddNode(treeView1.Nodes, node);
        //        }

        //        treeView1.ExpandAll();
        //    }
        //    catch (Exception ex)
        //    {
        //        MessageBox.Show(ex.Message);
        //    }
        //}

        //static string GetAttributeText(XmlNode inXmlNode, string name)
        //{
        //    XmlAttribute attr = (inXmlNode.Attributes == null ? null : inXmlNode.Attributes[name]);
        //    return attr == null ? null : attr.Value;
        //}

        //private void AddNode(List<Nodes> nodes, XmlNode inXmlNode)
        //{
        //    if (inXmlNode.HasChildNodes)
        //    {
        //        string text = GetAttributeText(inXmlNode, "name");
        //        if (string.IsNullOrEmpty(text))
        //            text = inXmlNode.Name;
        //        TreeNode newNode = nodes.Add(text);
        //        XmlNodeList nodeList = inXmlNode.ChildNodes;
        //        for (int i = 0; i <= nodeList.Count - 1; i++)
        //        {
        //            XmlNode xNode = inXmlNode.ChildNodes[i];
        //            AddNode(newNode.Nodes, xNode);
        //        }
        //    }
        //    else
        //    {
        //        // If the node has an attribute "name", use that.  Otherwise display the entire text of the node.
        //        string text = GetAttributeText(inXmlNode, "name");
        //        if (string.IsNullOrEmpty(text))
        //            text = (inXmlNode.OuterXml).Trim();
        //        TreeNode newNode = nodes.Add(text);
        //    }
        //}
    }
}