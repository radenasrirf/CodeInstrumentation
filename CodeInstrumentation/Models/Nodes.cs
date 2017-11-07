using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeInstrumentation.Models
{
    public class Nodes
    {
        public int Number { get; set; }
        public int LineNumber { get; set; }
        public int Type { get; set; }
        public string Label { get; set; }
        public bool isVisited { get; set; }
        public bool? EdgeType { get; set; }
        public List<Nodes> Children { get; set; }
        public Nodes()
        {
            this.Children = new List<Nodes>();
        }
        public Nodes(int Number, int LineNumber, int Type, string Label)
        {
            this.Number = Number;
            this.LineNumber = LineNumber;
            this.Label = Label;
            this.Type = Type;
            this.Children = new List<Nodes>();
        }
    }
}