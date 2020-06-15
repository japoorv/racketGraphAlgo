#lang racket
(require racket/set)
(require data/heap)
(struct graph (node adj_list weights) #:mutable)

;; DATA STRUCTURE ;;
;;;;;;;;;;;;;;;;;;;;;
(provide initialize_graph)
(define (initialize_graph)
  (graph empty (make-hash) (make-hash))
  )
(provide add_node)
(define (add_node grph node_)
  (set-graph-node! grph (cons node_ (graph-node grph)))   
  )
(provide add_edge)
(define (add_edge grph u v w)
  (set-add! (hash-ref! (graph-adj_list grph) u (mutable-set)) v)
  (set-add! (hash-ref! (graph-adj_list grph) v (mutable-set)) u)
  (hash-set! (hash-ref! (graph-weights grph) u (make-hash)) v w)
  (hash-set! (hash-ref! (graph-weights grph) v (make-hash)) u w)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide displn)
(define (displn a)
  (display a)
  (display "\n")
  )
(define (get_weight grph u v)
  (hash-ref (hash-ref (graph-weights grph) u) v)
  )
(define (getVal hash key)
  (hash-ref hash key)
  )
(define (setVal hash key val)
  (hash-set! hash key val)
  )
(define (<=? x y)
  (<= (car x) (car y))
  )
(define (heap-empty? heap)
  (cond
    [(= 0 (heap-count heap)) #t] ;; hoping that heap-count is constant time
    [else #f]
    ))
;; DJIKSTRA'S ALGORITHM ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define inf "inf") ; define inf 'inf as a large value
(define (djikstra grph u v)
  (let ([isVisited (make-hash (map (lambda (x) (cons x 'notvisited)) (graph-node grph)))] 
        [distance (make-hash (map (lambda (x) (if (equal? x u) (cons x 0) (cons x inf))) (graph-node grph)))]
        [minHeap (make-heap <=?)]) 
    (heap-add! minHeap (cons (getVal distance u) u))
    (define (check)
      (cond
        [(heap-empty? minHeap) (void)]
        [else (let ([top (heap-min minHeap)])
                (heap-remove-min! minHeap)
                (cond
                  [(equal? 'visited (hash-ref isVisited (cdr top))) (check)]
                  [else
                   (setVal isVisited (cdr top) 'visited)
                   (set-for-each (hash-ref! (graph-adj_list grph) (cdr top) (mutable-set))
                                 (lambda (x) 
                                   (cond
                                     [(or (equal? (getVal distance x) "inf") (< (+ (getVal distance (cdr top)) (get_weight grph (cdr top) x)) (getVal distance x)))
                                      (setVal distance x (+ (getVal distance (cdr top)) (get_weight grph (cdr top) x)))(heap-add! minHeap (cons (getVal distance x) x))]
                                     ))
                                 ) (check)]) (void))])) (check) distance
    ) 
  ) 
(provide shortest_path)
(define (shortest_path grph src dst)
  (let ([distance (djikstra grph src dst)])
    ;;(display "All distances :")
    ;;(displn distance)
    distance
    )
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide print_graph) ; Utility for printing the graph : First the nodes are printed, then the adjacency List and finally the weights of the edges are returned 
(define (print_graph grph)
  (display "\nNodes: ")
  (display (graph-node grph))
  (display "\n")
  (display "Adjacency List: ")
  (display (graph-adj_list grph))
  (display "\nWeights: ")
  (displn (graph-weights grph)) 
  )  
