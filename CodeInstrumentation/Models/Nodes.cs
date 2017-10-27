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
        public bool isVisited { get; set; }
        public List<Nodes> Children { get; set; }
        public Nodes()
        {
            this.Children = new List<Nodes>();
        }
        public Nodes(int Number, int LineNumber)
        {
            this.Number = Number;
            this.LineNumber = LineNumber;
            this.Children = new List<Nodes>();
        }
        public void AddChildren(Nodes to)
        {
            this.Children.Add(to);
        }
    }
}