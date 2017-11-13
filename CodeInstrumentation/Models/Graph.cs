using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CodeInstrumentation.Models
{
    public class Graph
    {
        public List<Nodes> Nodes { get; set; }

        public Graph()
        {
            Nodes = new List<Nodes>();
        }
        public void AddNode(Nodes node)
        {
            Nodes.Add(node);
        }
        public void AddEdge(Nodes from, Edges edge)
        {
            from.Edges.Add(edge);
        }
        public void ModifiedNode(Nodes from, Nodes to)
        {
            from = to;
        }
        public void setVisit(Edges edge, bool isVisited)
        {
            edge.isVisited = isVisited;
        }
    }
}