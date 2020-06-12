#lang racket
(require "graph.rkt")
(define a (initialize_graph))
(add_node a 0)
(add_node a 1)
(add_node a 2)
(add_node a 3)
(add_node a 4)
(add_node a 5)
(add_node a 6)
(add_node a 7)
(add_node a 8)
(add_edge a 0 1 4)
(add_edge a 0 7 8)
(add_edge a 1 2 8)
(add_edge a 7 1 11)
(add_edge a 7 8 7)
(add_edge a 7 6 1)
(add_edge a 2 3 7)
(add_edge a 2 8 2)
(add_edge a 8 6 6)
(add_edge a 6 5 2)
(add_edge a 2 5 4)
(add_edge a 3 5 14)
(add_edge a 3 4 9)
(add_edge a 4 5 10)
(print_graph a)
(display (shortest_path a 0 2))