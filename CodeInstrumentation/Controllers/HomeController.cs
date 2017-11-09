﻿using System;
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
        public const int START = 0;
        public const int END = 1;
        public const int DECISSION = 2;
        public const int WHILE = 3;
        public const int PROCESS = 4;
        public readonly string[] Shape = new string[] { "oval", "oval", "diamond height=0.6 width=1.2", "diamond height=0.6 width=1.2", "parallelogram  width=1.2" };

        Graph graph = new Graph();
        Nodes root = new Nodes();
        string dot = "";
        // int i = 1;
        int branchNumber = 1;
        string[] token = { "If", "Case", "Assignment" };
        // bool true : open, false: close, null : node
        Stack<Nodes> stackOfNodes = new Stack<Nodes>();
        List<KeyValuePair<Nodes, bool?>> Leafs = new List<KeyValuePair<Nodes, bool?>>();
        List<Tuple<int, int>> InsturmentedRow = new List<Tuple<int, int>>();
        List<string> ListOfPath = new List<string>();
        string InputFilePath;
        string OutputXMLPath;
        string InstrumentedFilePath;
        public ActionResult Index()
        {
            InputFilePath = Path.Combine(Server.MapPath("~/Files"), "minimaxi.m");
            OutputXMLPath = Path.Combine(Server.MapPath("~/Files"), "minimaxi.xml");
            InstrumentedFilePath = Path.Combine(Server.MapPath("~/Files"), "minimaxi_instrumented.m");
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

            var dotNode = "";
            foreach (var node in graph.Nodes)
            {
                dotNode += node.Number + " [shape=" + Shape[node.Type] + " label = \"" + node.Label + "\"] ";
            }

            var bytes = wrapper.GenerateGraph("digraph G { graph [label=\"\" nodesep=0.8] { " + dotNode + " } " + dot + "}", Enums.GraphReturnType.Jpg);

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
            var startNode = new Nodes("s", 0, START, "Start");
            graph.AddNode(startNode);
            stackOfNodes.Push(startNode);

            TraversedNodes(xmlElement, null);

            var endNode = new Nodes("f", System.IO.File.ReadAllLines(InputFilePath).Count(), END, "End");
            graph.AddNode(endNode);
            foreach (var leaf in Leafs)
            {
                graph.AddEdge(leaf.Key, new Edges(endNode, leaf.Value));
                dot += leaf.Key.Number + "-> f [ label=\"" + leaf.Value + "\" fontsize=10  ];";
            }
        }
        void BuildPath()
        {
            stackOfNodes.Clear();
            graph.visit(graph.Nodes.FirstOrDefault());
            stackOfNodes.Push(graph.Nodes.FirstOrDefault());
            TraversedPath(graph.Nodes.Where(x => x.Number != "s").FirstOrDefault(), graph.Nodes.Where(x => x.Number != "s").FirstOrDefault().Number.ToString());
        }
        void TraversedPath(Nodes nodes, string parentPath)
        {
            if (nodes == graph.Nodes.Where(x => x.Number != "f").FirstOrDefault())
            {
                foreach (var item in nodes.Edges)
                {
                    if (item.To.isVisited == false)
                        TraversedPath(item.To, parentPath + " " + (item.Type == true ? 0 : 1) + " " + (item.To.Number == "f" ? "" : item.To.Number));
                }
                graph.visit(nodes);
            }
            else
            {
                ListOfPath.Add(parentPath);
            }
        }
        //private void TraversedNodes(IEnumerable<XElement> nodes)
        //{
        //    if (nodes.Count() > 0)
        //    {
        //        foreach (var element in nodes)
        //        {
        //            if (element.Name == "If")
        //            {
        //                InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
        //                var caseElement = element.Elements()
        //                            .Where(x => x.Name == "If.IfPart" || x.Name == "If.ElsePart");

        //                var temp = stackOfNodes.First().Key;
        //                stackOfNodes.Pop();
        //                stackOfNodes.Push(new KeyValuePair<Nodes, bool?>(temp, true));

        //                foreach (var childElement in caseElement)
        //                {
        //                    var newNodes = new Nodes(i, Convert.ToInt32(childElement.Elements().FirstOrDefault().Attribute("Line").Value), PROCESS, i++.ToString());
        //                    graph.AddNode(newNodes);
        //                    graph.AddEdge(stackOfNodes.First().Key, newNodes);
        //                    dot += stackOfNodes.First().Key.Number + "->" + newNodes.Number + ";";
        //                    stackOfNodes.Push(new KeyValuePair<Nodes, bool?>(newNodes, false));
        //                    // if.ifpart / ifpart / ifpart statement / Elements()
        //                    var t = childElement.Elements().Elements().Select(y => y.Name.ToString());
        //                    TraversedNodes(childElement.Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements());
        //                }
        //                if (stackOfNodes.FirstOrDefault().Value == true)
        //                    stackOfNodes.Pop();
        //            }
        //            else
        //            {
        //                switch (stackOfNodes.FirstOrDefault().Value)
        //                {
        //                    case true:
        //                        var newNodes = new Nodes(i++, Convert.ToInt32(element.Attribute("Line").Value));
        //                        graph.AddNode(newNodes);
        //                        graph.AddEdge(stackOfNodes.First().Key, newNodes);
        //                        dot += stackOfNodes.First().Key.Number + "->" + newNodes.Number + ";";
        //                        stackOfNodes.Push(new KeyValuePair<Nodes, bool?>(newNodes, null));
        //                        break;
        //                    case null:
        //                        break;
        //                    default:
        //                        Leafs.Add(stackOfNodes.FirstOrDefault().Key);
        //                        stackOfNodes.Pop();
        //                        break;

        //                }
        //            }
        //        }
        //    }
        //    else
        //    {
        //        Leafs.Add(stackOfNodes.FirstOrDefault().Key);
        //        stackOfNodes.Pop();
        //    }
        //}
        //private void TraversedNodes(IEnumerable<XElement> nodes)
        //{
        //    if (nodes.Count() > 0)
        //    {
        //        var el = 0;
        //        foreach (var element in nodes)
        //        {
        //            el++;
        //            if (element.Name == "If")
        //            {
        //                var temp = stackOfNodes.First();
        //                temp.Type = DECISSION;
        //                temp.Label = temp.Number + "(B" + branchNumber++ + ")";
        //                graph.ModifiedNode(stackOfNodes.First(),temp);

        //                InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
        //                foreach (var childElement in element.Elements().Where(x => x.Name == "If.IfPart"))
        //                {
        //                    var newNodes = new Nodes(i, Convert.ToInt32(childElement.Elements().FirstOrDefault().Attribute("Line").Value), PROCESS, i++.ToString());
        //                    graph.AddNode(newNodes);
        //                    graph.AddEdge(stackOfNodes.First(), newNodes, true);
        //                    dot += stackOfNodes.First().Number + "->" + newNodes.Number + " [ label=\"" + true + "\" ];";
        //                    stackOfNodes.Push(newNodes);
        //                    // if.ifpart / ifpart / ifpart statement / Elements()
        //                    var t = childElement.Elements().Elements().Select(y => y.Name.ToString());
        //                    TraversedNodes(childElement.Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements());
        //                }
        //                foreach (var childElement in element.Elements().Where(x => x.Name == "If.ElsePart"))
        //                {
        //                    var newNodes = new Nodes(i, Convert.ToInt32(childElement.Elements().FirstOrDefault().Attribute("Line").Value), PROCESS, i++.ToString());
        //                    graph.AddNode(newNodes);
        //                    graph.AddEdge(stackOfNodes.First(), newNodes, false);
        //                    dot += stackOfNodes.First().Number + "->" + newNodes.Number + " [ label=\"" + false + "\" ];";
        //                    stackOfNodes.Push(newNodes);
        //                    // if.ElsePart / ElsePart / ElsePart statement / Elements()
        //                    var t = childElement.Elements().Elements().Select(y => y.Name.ToString());
        //                    TraversedNodes(childElement.Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements());
        //                }
        //                stackOfNodes.Pop();
        //            }
        //            else
        //            {
        //                switch (stackOfNodes.FirstOrDefault().Type)
        //                {
        //                    case START:
        //                        var newNodes = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), PROCESS, i++.ToString());
        //                        graph.AddNode(newNodes);
        //                        graph.AddEdge(stackOfNodes.First(), newNodes, null);
        //                        dot += stackOfNodes.First().Number + "->" + newNodes.Number + ";";
        //                        stackOfNodes.Push(newNodes);
        //                        break;
        //                    default:
        //                            if (el == nodes.Count())
        //                            {
        //                                Leafs.Add(stackOfNodes.FirstOrDefault());
        //                                stackOfNodes.Pop();
        //                            }
        //                            break;
        //                }
        //            }
        //        }
        //    }
        //    else
        //    {
        //        Leafs.Add(stackOfNodes.FirstOrDefault());
        //        stackOfNodes.Pop();
        //    }
        //}
        private void TraversedNodes(IEnumerable<XElement> nodes, bool? Edge)
        {
            if (nodes.Count() > 0)
            {
                var el = 0;
                foreach (var element in nodes)
                {
                    el++;
                    if (element.Name == "If")
                    {
                        var IfPart = element.Elements().Where(x => x.Name == "If.IfPart").Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements();
                        var ElsePart = element.Elements().Where(x => x.Name == "If.ElsePart").Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements();
                        var newNodes = new Nodes(branchNumber.ToString(), Convert.ToInt32(element.Attribute("Line").Value), DECISSION, "B" + branchNumber++);
                        graph.AddNode(newNodes);
                        graph.AddEdge(stackOfNodes.First(), new Edges(newNodes, Edge));
                        dot += stackOfNodes.First().Number + "->" + newNodes.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";

                        if (ElsePart.Count() == 0)
                        {
                            graph.AddEdge(stackOfNodes.First(), new Edges(newNodes, false));
                            dot += stackOfNodes.First().Number + "->" + newNodes.Number + " [ label=\"false\" fontsize=10 ];";
                        }

                        stackOfNodes.Push(newNodes);
                        InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
                        // if.ifpart / ifpart / ifpart statement / Elements()


                        if (IfPart.Count() > 0)
                        {
                            TraversedNodes(IfPart, true);
                        }
                        if (ElsePart.Count() > 0)
                        {
                            TraversedNodes(ElsePart, false);
                        }
                                if (el == nodes.Count())
                                    stackOfNodes.Pop();
                    }
                    if (element.Name == "While")
                    {
                        var newNodes = new Nodes(branchNumber.ToString(), Convert.ToInt32(element.Attribute("Line").Value), WHILE, "B" + branchNumber++);
                        graph.AddNode(newNodes);
                        graph.AddEdge(stackOfNodes.First(), new Edges(newNodes, Edge));
                        dot += stackOfNodes.First().Number + "->" + newNodes.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
                        stackOfNodes.Push(newNodes);
                        Leafs.Add(new KeyValuePair<Nodes, bool?>(newNodes, false));
                        InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
                        TraversedNodes(element.Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements(), true);
                        graph.AddEdge(stackOfNodes.First(), new Edges(newNodes, false));
                        dot += stackOfNodes.First().Number + "->" + newNodes.Number + " " + (Edge != null ? "[ label=\"" + false + "\" fontsize=10 ]" : "") + ";";
                        stackOfNodes.Pop();
                    }
                    else
                    {
                        switch (stackOfNodes.FirstOrDefault().Type)
                        {
                            case START:
                            case DECISSION:
                                break;
                            default:
                                if (el == nodes.Count())
                                {
                                    Leafs.Add(new KeyValuePair<Nodes, bool?>(stackOfNodes.FirstOrDefault(), Edge));
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
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