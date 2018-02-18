using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeInstrumentation.Models
{
    public class Edge
    {
        public Node To { get; set; }
        public bool? Type { get; set; }
        public bool isVisited { get; set; }
        public Edge(Node To, bool? Type)
        {
            this.isVisited = false;
            this.To = To;
            this.Type = Type;
        }
    }
}