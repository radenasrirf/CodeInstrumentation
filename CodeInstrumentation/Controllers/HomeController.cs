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
        public const int START = 1;
        public const int END = -1;
        public const int IF = 2;
        public const int LOOP = 3;
        public const int PROCESS = 5;
        public readonly string[] Shape = new string[] { "circle", "circle", "diamond height=0.6 width=1.2", "diamond height=0.6 width=1.2", "parallelogram  width=1.2" };

        Graph graph = new Graph();
        Nodes root = new Nodes();
        string dot = "";
        int i = 1;
        int branchNumber = 1;
        string[] token = { "If", "Case", "Assignment" };
        // bool true : open, false: close, null : node
        Stack<Nodes> stackOfNodes = new Stack<Nodes>();
        Stack<KeyValuePair<Nodes, bool?>> Leafs = new Stack<KeyValuePair<Nodes, bool?>>();
        List<Tuple<int, int, string>> InsturmentedRow = new List<Tuple<int, int, string>>();
        List<string> ListOfPath = new List<string>();
        string InputFilePath;
        string OutputXMLPath;
        string InstrumentedFilePath;
        string InformationCFGFilePath;
        int EdgeCount = 0;
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
                var parse = ParseCodeToXML();
                if (parse == "")
                {
                    XDocument doc = XDocument.Load(OutputXMLPath);
                    BuildGraph(doc.Root.Descendants("Function.Statements").Elements());
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
                    //foreach (var node in graph.Nodes)
                    //{
                    //    dotNode += node.Number + " [shape=" + Shape[node.Type] + " label = \"" + node.Label + "\"] ";
                    //}

                    var bytes = wrapper.GenerateGraph("digraph G { graph [label=\"\" nodesep=0.8] { " + dotNode + " } " + dot + "}", Enums.GraphReturnType.Jpg);

                    var viewModel = string.Format("data:image/jpg;base64,{0}", Convert.ToBase64String(bytes));
                    ViewBag.CFG = viewModel;
                    ViewBag.InstrumentedCode = System.IO.File.ReadAllText(InstrumentedFilePath);
                    ViewBag.InformationCFG = System.IO.File.ReadAllText(InformationCFGFilePath);
                    ViewBag.LineResult = System.IO.File.ReadAllLines(InstrumentedFilePath).Count() + 1;
                    ViewBag.ListOfPath = ListOfPath;
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
            return View();
        }
        string ParseCodeToXML()
        {
            Result<UnitNode> result = MRecognizer.RecognizeFile(InputFilePath, true, null);
            if (result.Report.IsOk)
            {
                XDocument document = NodeToXmlBuilder.Build(result.Value);
                document.Save(OutputXMLPath);
                return "";
            }
            else
            {
                var message = "";
                foreach (Message m in result.Report)
                {
                    message += "[" + m.Severity + "] Line: [" + m.Line + "] Column: [" + m.Column + "] Text: [" + m.Text + "]</br>";
                }
                return message;
            }
        }
        void BuildGraph(IEnumerable<XElement> xmlElement)
        {
            var startNode = new Nodes(i++, 1, START, "Start");
            graph.AddNode(startNode);
            stackOfNodes.Push(startNode);

            TraversedNodes(xmlElement, null);

            if (Leafs.Count > 0)
            {
                var endNode = new Nodes(i++, System.IO.File.ReadAllLines(InputFilePath).Count(), END, "End");
                graph.AddNode(endNode);
                while (Leafs.Count() > 0)
                {
                    var leaf = Leafs.Peek();
                    graph.AddEdge(leaf.Key, new Edges(endNode, leaf.Value));
                    EdgeCount++;
                    dot += leaf.Key.Number + "-> " + endNode.Number + " [ label=\"" + leaf.Value + "\" fontsize=10  ];";
                    Leafs.Pop();
                }
            }
        }
        void BuildPath()
        {
            stackOfNodes.Clear();
            stackOfNodes.Push(graph.Nodes.FirstOrDefault());
            var root = graph.Nodes.FirstOrDefault();
            TraversedPath(root.Edges.FirstOrDefault().To, root.Edges.FirstOrDefault(), root.Number.ToString() + " " + root.Edges.FirstOrDefault().To.Number.ToString());
        }
        void TraversedPath(Nodes node, Edges edge, string parentPath)
        {
            graph.setVisit(edge, true);
            if (node.Number != i - 1)
            {
                foreach (var item in node.Edges)
                {
                    if (item.isVisited == false)
                    {
                        TraversedPath(item.To, item, parentPath + " " + (item.Type != null ? item.Type.ToString().Substring(0, 1) : "") + " " + (item.To.Number == i ? "" : item.To.Number.ToString()));
                        item.isVisited = false;
                    }
                }
            }
            else
            {
                ListOfPath.Add(parentPath);
            }
        }
        //private void TraversedNodes(IEnumerable<XElement> nodes, bool? Edge,ref Nodes CurrentNode)
        //{
        //    if (nodes.Count() > 0)
        //    {
        //        var el = 0;
        //        foreach (var element in nodes)
        //        {
        //            el++;
        //            if (element.Name == "If")
        //            {
        //                var temp = CurrentNode;
        //                if (temp.Type == PROCESS || temp.Type == END)
        //                {
        //                    temp.LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
        //                    temp.Type = IF;
        //                    temp.Label = temp.Number + "(B" + branchNumber++ + ")";
        //                    graph.ModifiedNode(CurrentNode, temp);
        //                }
        //                else
        //                {
        //                    temp = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), IF, i++.ToString());
        //                    graph.AddNode(temp);
        //                    graph.AddEdge(CurrentNode, new Edges(temp, Edge));
        //                    dot += CurrentNode.Number + "->" + temp.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
        //                }
        //                var IfPart = element.Elements().Where(x => x.Name == "If.IfPart");
        //                var ElsePart = element.Elements().Where(x => x.Name == "If.ElsePart");

        //                InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));

        //                //if (ElsePart.Count() == 0)
        //                //{
        //                //    graph.AddEdge(stackOfNodes.Peek(), new Edges(temp, false));
        //                //    dot += stackOfNodes.Peek().Number + "->" + temp.Number + " [ label=\"false\" fontsize=10 ];";
        //                //}
        //                if (IfPart.Count() > 0)
        //                {
        //                    var newNodes = new Nodes(i, Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Line").Value), PROCESS, i++.ToString());
        //                    graph.AddNode(newNodes);
        //                    graph.AddEdge(temp, new Edges(newNodes, true));
        //                    dot += temp.Number + "->" + newNodes.Number + " [ label=\"" + true + "\"  fontsize=10 ];";
        //                    TraversedNodes(IfPart.Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements(), true,ref newNodes);
        //                }
        //                if (ElsePart.Count() > 0)
        //                {
        //                    var newNodes = new Nodes(i, Convert.ToInt32(ElsePart.Elements().FirstOrDefault().Attribute("Line").Value), PROCESS, i++.ToString());
        //                    graph.AddNode(newNodes);
        //                    graph.AddEdge(temp, new Edges(newNodes, false));
        //                    dot += temp.Number + "->" + newNodes.Number + " [ label=\"" + false + "\"  fontsize=10 ];";
        //                    TraversedNodes(ElsePart.Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements(), false,ref newNodes);
        //                    var EndNodes = new Nodes(i, Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), END, i++.ToString());
        //                    graph.AddNode(EndNodes);
        //                    CurrentNode = EndNodes;
        //                }
        //                else
        //                {
        //                    Leafs.Push(new KeyValuePair<Nodes, bool?>(temp, false));
        //                    var EndNodes = new Nodes(i, Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), END, i++.ToString());
        //                    graph.AddNode(EndNodes);
        //                    CurrentNode = EndNodes;
        //                }
        //            }
        //            else if (element.Name == "Swicth")
        //            {
        //            }
        //            else if (element.Name == "While")
        //            {
        //                var temp = CurrentNode;
        //                temp.LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
        //                temp.Type = WHILE;
        //                temp.Label = temp.Number + "(B" + branchNumber++ + ")";
        //                graph.ModifiedNode(CurrentNode, temp);

        //                InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
        //                TraversedNodes(element.Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements(), true,ref temp);
        //                Leafs.Push(new KeyValuePair<Nodes, bool?>(CurrentNode, false));
        //                var EndNodes = new Nodes(i, Convert.ToInt32(element.Elements().Where(x => x.Name == "While.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), END, i++.ToString());
        //                graph.AddEdge(EndNodes, new Edges(CurrentNode, null));
        //                dot += temp.Number + "->" + CurrentNode.Number + " ;";
        //                graph.AddNode(EndNodes);
        //                CurrentNode = EndNodes;
        //            }
        //            else
        //            {

        //                switch (CurrentNode.Type)
        //                {
        //                    case START:
        //                        var newNodes = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), PROCESS, i++.ToString());
        //                        graph.AddNode(newNodes);
        //                        graph.AddEdge(CurrentNode, new Edges(newNodes, Edge));
        //                        dot += CurrentNode.Number + "->" + newNodes.Number + ";";
        //                        CurrentNode = newNodes;
        //                        break;
        //                    case END:
        //                        break;
        //                    default:
        //                        if (el == nodes.Count())
        //                        {
        //                            var temp = CurrentNode;
        //                            temp.LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
        //                            graph.ModifiedNode(CurrentNode, temp);
        //                            Leafs.Push(new KeyValuePair<Nodes, bool?>(temp, null));
        //                        }
        //                        break;
        //                }
        //            }

        //            if (CurrentNode.Type == END)
        //            {
        //                while (Leafs.Count() > 0)
        //                {
        //                    var leaf = Leafs.Peek();
        //                    if (leaf.Key.Number != CurrentNode.Number)
        //                    {
        //                        graph.AddEdge(leaf.Key, new Edges(CurrentNode, leaf.Value));
        //                        dot += leaf.Key.Number + "-> " + CurrentNode.Number + " [ label=\"" + leaf.Value + "\" fontsize=10  ];";

        //                    }
        //                    Leafs.Pop();
        //                }
        //            }
        //        }
        //        //Nodes endNode = new Nodes();
        //        //else
        //        //{
        //        //    endNode = new Nodes(i, System.IO.File.ReadAllLines(InputFilePath).Count(), END, i++.ToString());
        //        //    graph.AddNode(endNode);
        //        //}

        //    }
        //    else
        //    {
        //        Leafs.Push(new KeyValuePair<Nodes, bool?>(CurrentNode, null));
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
                        var temp = stackOfNodes.Peek();
                        if (temp.Type == PROCESS || temp.Type == END)
                        {
                            temp.LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
                            temp.Type = IF;
                            temp.Label = temp.Number + "(B" + branchNumber++ + ")";
                            graph.ModifiedNode(stackOfNodes.Peek(), temp);
                        }
                        else
                        {
                            temp = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), IF, i++.ToString());
                            graph.AddNode(temp);
                            graph.AddEdge(stackOfNodes.Peek(), new Edges(temp, Edge));
                            EdgeCount++;
                            dot += stackOfNodes.Peek().Number + "->" + temp.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
                            stackOfNodes.Push(temp);
                        }
                        var IfPart = element.Elements().Where(x => x.Name == "If.IfPart");
                        var ElsePart = element.Elements().Where(x => x.Name == "If.ElsePart");

                        InsturmentedRow.Add(new Tuple<int, int, string>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value), temp.Label));

                        if (IfPart.Count() > 0)
                        {
                            InsturmentedRow.Add(new Tuple<int, int, string>(Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Column").Value), "T"));
                            InsturmentedRow.Add(new Tuple<int, int, string>(Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Column").Value), i.ToString()));
                            var newNodes = new Nodes(i, Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Line").Value), PROCESS, i++.ToString());
                            graph.AddNode(newNodes);
                            graph.AddEdge(temp, new Edges(newNodes, true));
                            EdgeCount++;
                            dot += temp.Number + "->" + newNodes.Number + " [ label=\"" + true + "\"  fontsize=10 ];";
                            stackOfNodes.Push(newNodes);
                            TraversedNodes(IfPart.Elements().Elements().Where(x => x.Name == "IfPart.Statements").Elements(), true);
                        }
                        if (ElsePart.Count() > 0)
                        {
                            InsturmentedRow.Add(new Tuple<int, int, string>(Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Column").Value), "F"));
                            InsturmentedRow.Add(new Tuple<int, int, string>(Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Line").Value), Convert.ToInt32(IfPart.Elements().FirstOrDefault().Attribute("Column").Value), i.ToString()));
                            var newNodes = new Nodes(i, Convert.ToInt32(ElsePart.Elements().FirstOrDefault().Attribute("Line").Value), PROCESS, i++.ToString());
                            graph.AddNode(newNodes);
                            graph.AddEdge(temp, new Edges(newNodes, false));
                            EdgeCount++;
                            dot += temp.Number + "->" + newNodes.Number + " [ label=\"" + false + "\"  fontsize=10 ];";
                            stackOfNodes.Push(newNodes);

                            TraversedNodes(ElsePart.Elements().Elements().Where(x => x.Name == "ElsePart.Statements").Elements(), false);

                            Nodes EndNodes = new Nodes();
                            if (stackOfNodes.Peek() == newNodes && stackOfNodes.Skip(1).FirstOrDefault().Type == END)
                            {
                                EndNodes = stackOfNodes.Skip(1).FirstOrDefault();
                                stackOfNodes.Pop();
                                stackOfNodes.Pop();
                                stackOfNodes.Push(newNodes);
                                stackOfNodes.Push(EndNodes);
                            }
                            else if (stackOfNodes.Peek().Type != END)
                            {

                                EndNodes = new Nodes(i, Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), END, i++.ToString());
                                graph.AddNode(EndNodes);
                                stackOfNodes.Push(EndNodes);
                            }
                        }
                        else
                        {
                            Nodes EndNodes = new Nodes();
                            if (stackOfNodes.Peek().Type != END)
                            {
                                EndNodes = new Nodes(i, Convert.ToInt32(element.Elements().Where(x => x.Name == "If.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), END, i++.ToString());
                                graph.AddNode(EndNodes);
                                stackOfNodes.Push(EndNodes);
                            }
                            else
                                EndNodes = stackOfNodes.Peek();
                            graph.AddEdge(temp, new Edges(EndNodes, false));
                            EdgeCount++;
                            dot += temp.Number + "->" + EndNodes.Number + " [ label=\"" + false + "\"  fontsize=10 ];";
                        }
                    }
                    else if (element.Name == "Switch")
                    {
                        var temp = stackOfNodes.Peek();
                        if (temp.Type == PROCESS || temp.Type == END)
                        {
                            temp.LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
                            temp.Type = IF;
                            temp.Label = temp.Number + "(B" + branchNumber++ + ")";
                            graph.ModifiedNode(stackOfNodes.Peek(), temp);
                        }
                        else
                        {
                            temp = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), IF, i++.ToString());
                            graph.AddNode(temp);
                            graph.AddEdge(stackOfNodes.Peek(), new Edges(temp, Edge));
                            EdgeCount++;
                            dot += stackOfNodes.Peek().Number + "->" + temp.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
                            stackOfNodes.Push(temp);
                        }
                        var casePart = element.Elements().Where(x => x.Name == "Switch.CaseParts").Elements();
                        foreach (var caseElement in casePart)
                        {
                            var newNodes = new Nodes(i, Convert.ToInt32(caseElement.Attribute("Line").Value), PROCESS, i++.ToString());
                            graph.AddNode(newNodes);
                            graph.AddEdge(temp, new Edges(newNodes, null));
                            EdgeCount++;
                            dot += temp.Number + "->" + newNodes.Number + " [ label=\"" + null + "\"  fontsize=10 ];";
                            stackOfNodes.Push(newNodes);
                            TraversedNodes(caseElement.Elements().Where(x => x.Name == "Switch.Statements").Elements(), null);
                        }
                        var EndNodes = new Nodes(i, Convert.ToInt32(element.Elements().Where(x => x.Name == "Switch.Terminator").Elements().FirstOrDefault().Attribute("Line").Value), END, i++.ToString());
                        graph.AddNode(EndNodes);
                        stackOfNodes.Push(EndNodes);
                    }
                    else if (element.Name == "For" || element.Name == "While")
                    {
                        var temp = stackOfNodes.Peek();

                        if (temp.Type == PROCESS || temp.Type == END)
                        {
                            temp.LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
                            temp.Type = LOOP;
                            temp.Label = temp.Number + "(B" + branchNumber++ + ")";
                            graph.ModifiedNode(stackOfNodes.Peek(), temp);
                        }
                        else
                        {
                            temp = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), LOOP, i++.ToString());
                            graph.AddNode(temp);
                            graph.AddEdge(stackOfNodes.Peek(), new Edges(temp, Edge));
                            EdgeCount++;
                            dot += stackOfNodes.Peek().Number + "->" + temp.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
                            stackOfNodes.Push(temp);
                        }

                        InsturmentedRow.Add(new Tuple<int, int, string>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value), temp.Label));
                        TraversedNodes(element.Elements().Where(x => x.Name.ToString().Contains("Statements")).Elements(), true);
                        graph.AddEdge(stackOfNodes.Peek(), new Edges(temp, null));
                        EdgeCount++;
                        dot += stackOfNodes.Peek().Number + "->" + temp.Number + " ;";
                        stackOfNodes.Pop();

                        temp = stackOfNodes.Peek();
                        temp.Type = PROCESS;
                        graph.ModifiedNode(stackOfNodes.Peek(), temp);
                        var EndNodes = new Nodes(i, Convert.ToInt32(element.Elements().Where(x => x.Name.ToString().Contains("Terminator")).Elements().FirstOrDefault().Attribute("Line").Value), END, i++.ToString());
                        graph.AddNode(EndNodes);

                        graph.AddEdge(temp, new Edges(EndNodes, false));
                        EdgeCount++;
                        dot += stackOfNodes.Peek().Number + "->" + EndNodes.Number + " [ label=\"" + false + "\"  fontsize=10 ];";
                        stackOfNodes.Pop();
                        stackOfNodes.Push(EndNodes);
                    }
                    else
                    {
                        if (stackOfNodes.Count() > 0)
                        {
                            switch (stackOfNodes.Peek().Type)
                            {
                                case START:
                                    var newNodes = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), PROCESS, i++.ToString());
                                    graph.AddNode(newNodes);
                                    graph.AddEdge(stackOfNodes.Peek(), new Edges(newNodes, Edge));
                                    EdgeCount++;
                                    dot += stackOfNodes.Peek().Number + "->" + newNodes.Number + ";";
                                    stackOfNodes.Push(newNodes);
                                    break;
                                case LOOP:
                                    newNodes = new Nodes(i, Convert.ToInt32(element.Attribute("Line").Value), PROCESS, i++.ToString());
                                    graph.AddNode(newNodes);
                                    graph.AddEdge(stackOfNodes.Peek(), new Edges(newNodes, Edge));
                                    EdgeCount++;
                                    dot += stackOfNodes.Peek().Number + "->" + newNodes.Number + " [ label=\"" + Edge + "\"  fontsize=10 ];";
                                    stackOfNodes.Push(newNodes);
                                    break;
                                case END:
                                    break;
                                default:
                                    if (el == nodes.Count())
                                    {
                                        var temp = stackOfNodes.Peek();
                                        temp.LineNumber = Convert.ToInt32(element.Attribute("Line").Value);
                                        graph.ModifiedNode(stackOfNodes.Peek(), temp);
                                    }
                                    break;
                            }
                        }
                    }
                    if (stackOfNodes.Count() > 0)
                    {
                        if (stackOfNodes.Peek().Type == END)
                        {
                            var EndNodes = stackOfNodes.Peek();
                            stackOfNodes.Pop();//pop yang endnodes dulu
                            while (stackOfNodes.Count() > 0 && stackOfNodes.Peek().Type == PROCESS)
                            {
                                var leaf = stackOfNodes.Peek();
                                stackOfNodes.Pop();
                                graph.AddEdge(leaf, new Edges(EndNodes, null));
                                EdgeCount++;
                                dot += leaf.Number + "-> " + EndNodes.Number + " [ fontsize=10  ];";
                            }
                            if (stackOfNodes.Count() > 0 && stackOfNodes.Peek().Type == IF)
                            {
                                stackOfNodes.Pop();//pop bukanya
                            }
                            stackOfNodes.Push(EndNodes);
                        }
                    }
                }

            }
            else
            {
                Leafs.Push(new KeyValuePair<Nodes, bool?>(stackOfNodes.Peek(), null));
                stackOfNodes.Pop();
            }
        }
        //private void TraversedNodes(IEnumerable<XElement> nodes, bool? Edge)
        //{
        //    if (nodes.Count() > 0)
        //    {
        //        var el = 0;
        //        foreach (var element in nodes)
        //        {
        //            el++;
        //            if (element.Name == "If")
        //            {
        //                var IfPart = element.Elements().Where(x => x.Name == "If.IfPart").Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements();
        //                var ElsePart = element.Elements().Where(x => x.Name == "If.ElsePart").Elements().Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements();
        //                var newNodes = new Nodes(branchNumber.ToString(), Convert.ToInt32(element.Attribute("Line").Value), DECISSION, "B" + branchNumber++);
        //                graph.AddNode(newNodes);
        //                graph.AddEdge(stackOfNodes.Peek(), new Edges(newNodes, Edge));
        //                dot += stackOfNodes.Peek().Number + "->" + newNodes.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";

        //                if (ElsePart.Count() == 0)
        //                {
        //                    graph.AddEdge(stackOfNodes.Peek(), new Edges(newNodes, false));
        //                    dot += stackOfNodes.Peek().Number + "->" + newNodes.Number + " [ label=\"false\" fontsize=10 ];";
        //                }

        //                stackOfNodes.Push(newNodes);
        //                InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
        //                // if.ifpart / ifpart / ifpart statement / Elements()


        //                if (IfPart.Count() > 0)
        //                {
        //                    TraversedNodes(IfPart, true);
        //                }
        //                if (ElsePart.Count() > 0)
        //                {
        //                    TraversedNodes(ElsePart, false);
        //                }
        //                        if (el == nodes.Count())
        //                            stackOfNodes.Pop();
        //            }
        //            if (element.Name == "While")
        //            {
        //                var newNodes = new Nodes(branchNumber.ToString(), Convert.ToInt32(element.Attribute("Line").Value), WHILE, "B" + branchNumber++);
        //                graph.AddNode(newNodes);
        //                graph.AddEdge(stackOfNodes.Peek(), new Edges(newNodes, Edge));
        //                dot += stackOfNodes.Peek().Number + "->" + newNodes.Number + " " + (Edge != null ? "[ label=\"" + Edge + "\" fontsize=10 ]" : "") + ";";
        //                stackOfNodes.Push(newNodes);
        //                Leafs.Add(new KeyValuePair<Nodes, bool?>(newNodes, false));
        //                InsturmentedRow.Add(new Tuple<int, int>(Convert.ToInt32(element.Attribute("Line").Value), Convert.ToInt32(element.Attribute("Column").Value)));
        //                TraversedNodes(element.Elements().Where(y => y.Name.ToString().Contains("Statements")).Elements(), true);
        //                graph.AddEdge(stackOfNodes.Peek(), new Edges(newNodes, false));
        //                dot += stackOfNodes.Peek().Number + "->" + newNodes.Number + " " + (Edge != null ? "[ label=\"" + false + "\" fontsize=10 ]" : "") + ";";
        //                stackOfNodes.Pop();
        //            }
        //            else
        //            {
        //                switch (stackOfNodes.Peek().Type)
        //                {
        //                    case START:
        //                    case DECISSION:
        //                        break;
        //                    default:
        //                        if (el == nodes.Count())
        //                        {
        //                            Leafs.Add(new KeyValuePair<Nodes, bool?>(stackOfNodes.Peek(), Edge));
        //                        }
        //                        break;
        //                }
        //            }
        //        }
        //    }
        //    else
        //    {
        //    }
        //}
        private void Instrumentation(IEnumerable<XElement> nodes)
        {
            var startRow = Convert.ToInt32(nodes.FirstOrDefault().Attribute("Line").Value);
            var startCol = Convert.ToInt32(nodes.FirstOrDefault().Attribute("Column").Value);
            var functionOutputs = nodes.Elements().Where(x => x.Name == "Function.Outputs").Elements();
            var temp = "";
            var lineNumber = 1;
            var startNumber = InsturmentedRow.Count() > 0 ? InsturmentedRow.FirstOrDefault().Item1 : lineNumber + 1;
            var i = 1;
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
                    }
                    else
                    {
                        if (lineNumber == startNumber)
                            sw.WriteLine("traversedPath = [];");
                        var row = InsturmentedRow.Where(x => x.Item1 == lineNumber).FirstOrDefault();
                        if (row != null)
                        {
                            temp = "";
                            for (int j = 1; j < row.Item2; j++)
                                temp += "\t";
                            sw.WriteLine(temp + "% instrument Branch # " + i);
                            sw.WriteLine(temp + "traversedPath = [traversedPath " + i++ + "];");
                        }
                        sw.WriteLine(line);
                    }
                    temp = "";
                    var node = graph.Nodes.Where(x => x.LineNumber == lineNumber).FirstOrDefault();
                    if (node != null)
                        temp = " <b>Node " + node.Number + "</b>";
                    sc.WriteLine(line + temp);
                    lineNumber++;
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
                var row = graph.Nodes.Where(x => x.LineNumber == lineNumber).FirstOrDefault();
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
    }
}