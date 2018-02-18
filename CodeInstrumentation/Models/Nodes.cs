using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeInstrumentation.Models
{
    public class Node
    {
        public int Number { get; set; }
        public int LineNumber { get; set; }
        public int ColumnNumber { get; set; }
        public int Type { get; set; }
        public string Label { get; set; }
        public List<Edge> Edges { get; set; }
        public Node()
        {
            this.Edges = new List<Edge>();
        }
        public Node(int Number, int LineNumber, int ColumnNumber, int Type, string Label)
        {
            this.Number = Number;
            this.LineNumber = LineNumber;
            this.ColumnNumber = ColumnNumber;
            this.Type = Type;
            this.Label = Label;
            this.Edges = new List<Edge>();
        }
        public void AddEdge(Edge edge)
        {
            Edges.Add(edge);
        }
        public void setVisit(Edge edge, bool isVisited)
        {
            edge.isVisited = isVisited;
        }
    }
}