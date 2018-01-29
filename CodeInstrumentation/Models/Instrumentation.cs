using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeInstrumentation.Models
{
    public class Instrumentation
    {
        public int LineNumber { get; set; }
        public int ColumnNumber { get; set; }
        public string Text { get; set; }
        public Instrumentation(int LineNumber, int ColumnNumber, string Text)
        {
            this.LineNumber = LineNumber;
            this.ColumnNumber = ColumnNumber;
            this.Text = Text;
        }
    }
}