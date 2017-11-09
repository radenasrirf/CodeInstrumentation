using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeInstrumentation.Models
{
    public class Edges
    {
        public Nodes To { get; set; }
        public bool? Type { get; set; }
        public Edges(Nodes To, bool? Type)
        {
            this.To = To;
            this.Type = Type;
        }
    }
}