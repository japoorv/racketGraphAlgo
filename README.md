# racketGraphAlgo
A Basic Graph Data Structure along with shortest path algorithm (Dijkstra) in Racket

1) The code is a basic Graph Data Structure along with implementation of Dijkstra's Algorithm in Racket. 
2) The Graph is represented as 
    * List of nodes 
            accessible via graph-node <graph_name>
    * HashMap of sets each HashMap corrosponding to a node and each entry in set representing an edge between the two nodes.
            accessible via graph-adj_list <graph_name>
    * HashMap of HashMap. Outer HashMap corrosponding to each node and the inner one for finding the weight of the edge[u][v]
      where u is the key of the outer HashMap and v that of inner. 
            accessible via graph-weights <graph_name>
3) The Shortest algo has been implemented using MinHeap hence the running time is optimal. 
4) The use of list for nodes, hashmaps for adjacency list and weights is promoted for the flexibility of naming of nodes.
    Use of above data structures enable the use of alphanumeric identifiers for nodes.
    
5) Some test cases have also been provided. Note the syntax of adding nodes, edges in the graph. The code could thus be reused
   without any change as long as the graph is modeled correctly (according to implementation as in testcases) and the syntax of insertion and querying is
   kept right.
**Benchmarks/analysis has some benchmarks. Refer Readme.md there **
