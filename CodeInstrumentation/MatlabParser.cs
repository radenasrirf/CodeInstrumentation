using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Matlab.Utils;
using Matlab.Recognizer;
using Matlab.Nodes;
using Matlab.Info;
using System.Xml.Linq;
using System.IO;
using System.Xml;
using System.Threading.Tasks;

namespace CodeInstrumentation
{
    public class MatlabParser
    {
        public static Object ParseCodeToXML(string InputPath, string OutputPath)
        {
            Result<UnitNode> result = MRecognizer.RecognizeFile(InputPath, true, null);
            string message="";
            if (result.Report.IsOk)
            {
                XDocument document = NodeToXmlBuilder.Build(result.Value);
                document.Save(OutputPath);
                message ="Sukses";
            }
            else
            {
                message = "";
                foreach (Message m in result.Report)
                {
                    message += "[" + m.Severity + "] Line: [" + m.Line + "] Column: [" + m.Column + "] Text: [" + m.Text + "]</br>";
                }
            }
            return message;
        }
    }
}
