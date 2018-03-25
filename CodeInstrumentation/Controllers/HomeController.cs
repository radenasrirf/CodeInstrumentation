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
        Matlab matlab = new Matlab();
        public ActionResult Index()
        {
            var watch = System.Diagnostics.Stopwatch.StartNew();
            matlab.OutputXMLPath = Path.Combine(Server.MapPath("~/Files"), "parsecode.xml");
            matlab.InstrumentedFilePath = Path.Combine(Server.MapPath("~/Files"), "instrumentedcode.m");
            matlab.InformationCFGFilePath = Path.Combine(Server.MapPath("~/Files"), "InformationCFGFilePath.m");
            var SourceCode = "";
            if (Request["SourceCode"] != null)
            {
                SourceCode = Request["SourceCode"].ToString();
                matlab.InputFilePath = Path.Combine(Server.MapPath("~/Files"), "sourcecode.m");
                using (StreamWriter sw = System.IO.File.CreateText(matlab.InputFilePath))
                {
                    sw.Write(SourceCode);
                }
                var parse = Matlab.ParseCodeToXML(matlab.InputFilePath, matlab.OutputXMLPath).ToString();
                if (parse == "Sukses")
                {
                    XDocument doc = XDocument.Load(matlab.OutputXMLPath);
                    matlab.BuildNodes(doc.Root.Descendants("Function.Statements").Elements());
                    matlab.BuildPath();
                    ViewBag.Keterangan = PrintCode();
                    matlab.Instrumentation(doc.Root.Descendants("Function"));
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

                    var bytes = wrapper.GenerateGraph("digraph G { graph [label=\"\" nodesep=0.8] { " + dotNode + " } " + matlab.dot + "}", Enums.GraphReturnType.Jpg);
                    //var bytes = wrapper.GenerateGraph("digraph { 1 -> 2 [ label=\"True\"  fontsize=10 ]; 1 -> 3 [ label=\"False\"  fontsize=10 ]; 2 -> 4; 3 -> 4;}", Enums.GraphReturnType.Jpg);

                    var viewModel = string.Format("data:image/jpg;base64,{0}", Convert.ToBase64String(bytes));
                    ViewBag.CFG = viewModel;
                    ViewBag.Dot = ("digraph G { <br/>graph [label=\"\" nodesep=0.8]  <br/>" + matlab.dot + "}").Replace(";", ";<br/>");
                    ViewBag.InstrumentedCode = System.IO.File.ReadAllText(matlab.InstrumentedFilePath);
                    ViewBag.InformationCFG = System.IO.File.ReadAllText(matlab.InformationCFGFilePath);
                    ViewBag.LineResult = System.IO.File.ReadAllLines(matlab.InstrumentedFilePath).Count() + 1;
                    ViewBag.ListOfPath = matlab.ListOfPath;
                    matlab.BuildAdjacencyList();
                    ViewBag.AdjacencyList = matlab.AdjacencyList;
                    ViewBag.Parse = "true";
                }
                else
                    ViewBag.Parse = parse;
                ViewBag.Code = System.IO.File.ReadAllText(matlab.InputFilePath);
                ViewBag.Line = System.IO.File.ReadAllLines(matlab.InputFilePath).Count() + 1;
            }
            else
            {
                ViewBag.Code = "";
                ViewBag.Line = 25;
            }
            ViewBag.NodesCount = matlab.Nodes.Count();
            ViewBag.EdgesCount = matlab.EdgesCount;

            watch.Stop();
            ViewBag.ExecTime = Math.Round(watch.Elapsed.TotalSeconds, 2);
            return View();
        }

        public string PrintCode()
        {
            var lineNumber = 1;
            var result = "<ul>";
            var i = 1;
            foreach (string line in System.IO.File.ReadLines(matlab.InputFilePath))
            {
                var row = matlab.Nodes.Where(x => x.LineNumber == lineNumber).FirstOrDefault();
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