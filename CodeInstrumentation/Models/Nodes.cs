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
        public List<Edges> Edges { get; set; }
        public Nodes()
        {
            this.Edges = new List<Edges>();
        }
        public Nodes(int Number, int LineNumber, int Type, string Label)
        {
            this.Number = Number;
            this.LineNumber = LineNumber;
            this.Label = Label;
            this.Type = Type;
            this.Edges = new List<Edges>();
        }
    }
}