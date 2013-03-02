using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;

namespace xmllint
{
    class Program
    {

        static TextReader textReader = Console.In;

        static void Main(string[] args)
        {
            initialize(args);
            try
            {
                XmlWriterSettings settings = new XmlWriterSettings();
                settings.Indent = true;

                XmlDocument doc = new XmlDocument();
                doc.Load(textReader);

                XmlTextWriter writer = new XmlTextWriter(Console.Out);
                writer.Formatting = Formatting.Indented;
                writer.Indentation = 4;
                doc.WriteContentTo(writer);
            }
            catch (Exception e)
            {
                Console.WriteLine("Exception : " + e);
            }
        }

        private static void initialize(string[] args)
        {
            if (args.Length == 1)
            {
                String fileName = args[0];
                textReader = new StreamReader(fileName);
            }
        }
    }
}
