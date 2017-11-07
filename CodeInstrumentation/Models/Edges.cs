using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeInstrumentation.Models
{
    public class Edges
    {
        public Nodes From { get; set; }
        public Nodes To { get; set; }
        public bool? Type { get; set; }
    }
}