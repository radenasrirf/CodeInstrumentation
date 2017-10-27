﻿using System;
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
        public void AddEdge(Nodes from, Nodes to)
        {
            from.Children.Add(to);
        }
        public void visit(Nodes node)
        {
            node.isVisited = true;
        }
    }
}