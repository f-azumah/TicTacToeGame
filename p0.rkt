#lang racket

;;; Project 0 Tic-tac-toe with Racket
;;; 

(provide board?
         next-player
          valid-move?
          make-move
          winner?
          calculate-next-move)


; Returns the number of elements in l for which the predicate f
; evaluates to #t. For example:
;
;    (count (lambda (x) (> x 0)) '(-5 0 1 -3 3 4)) => 3
;    (count (lambda (x) (= x 0)) '(-5 0 1 -3 3 4)) => 1
(define (count f l)
  (cond [(empty? l) 0]
        [(f (car l)) (add1 (count f (cdr l)))]
        [else (count f (cdr l))]))


(define (count-items el lst acc)
  (if (empty? lst)
    acc
    (if (equal? (car lst) el)
        (count-items el (cdr lst) (+ 1 acc))
        (count-items el (cdr lst) acc))))

  
; Check whether a list is a valid board
(define (board? lst)
  (cond [(not (integer? (sqrt (length lst)))) #f]
        [(not (andmap (lambda (el) (or (equal? el  'X)
                                       (equal? el 'O)
                                       (equal? el 'E))) lst)) #f]
        [(not (<= (- (count-items 'X lst 0) (count-items 'O lst 0)) 1)) #f]
        [else (>= (count-items 'X lst 0) (count-items 'O lst 0))]))

;;; From the board, calculate who is making a move this turn
(define (next-player board)
  (if (board? board)
      (cond [(> (count-items 'X board 0) (count-items 'O board 0)) 'O]
            [else (= (count-items 'X board 0) (count-items 'O board 0)) 'X])
      (displayln "invalid")))

      
      
;;; If player ('X or 'O) want to make a move, check whether it's this
;;; player's turn and the position on the board is empty ('E)
(define (valid-move? board row col player)
  (define n (sqrt(length board)))
  (if (board? board)
     (if (integer? (and row col))
         (cond [(not (equal? player (next-player board))) #f]
               [(not (and (<= 0 row (- n 1))
                          (<= 0 col (- n 1)))) #f]
               [else (equal? (list-ref board (+ (* row n) col)) 'E)])
         #f)
     #f))

                     
  

;;; To make a move, replace the position at row col to player ('X or 'O)
(define (make-move board row col player)
  (define n (sqrt(length board)))
  (list-set (board (list-ref board (+ (* row n) col)) player)))
      
  
;;; To determine whether there is a winner?
(define (take l n)
    (if (equal? n 0)
        '()
        (cons (first l)(take (rest l) (- n 1)))))
  
(define (drop l n)
    (if (equal? n 0)
        l
        (drop (rest l) (- n 1))))

(define (winner? board)
  
  (define size (sqrt (length board)))
  
  (define (diagonal board)
    (define (get-ith l)
      (if (empty? l)
          '()
          (cons (list-ref board (+ (first l) (* (first l)size)))
                (get-ith (rest l)))))
    (get-ith (range size)))

  (define (reverse-diagonal board)
    (diagonal (reverse board)))
  
  (define (get-rows board)
    (map (lambda (row) (take (drop board (* row size)) size))
         (range size)))
  
  (define (get-cols board)
    (map (lambda (c)
           (map (lambda (row)
                  (list-ref board (+ c (* row size))))
                (range size)))
         (range size)))

  
  (define lsts (append (list (diagonal board))
                       (list (reverse-diagonal board))
                       (get-rows board)
                       (get-cols board)))
  
  (define (is-all-X? lsts)
    (ormap
     (lambda (l)
       (andmap (lambda (e) (equal? e 'X)) l))
     lsts))

  (define (is-all-O? lsts)
    (ormap
     (lambda (l) (andmap (lambda (e) (equal? e 'O)) l))
     lsts))

    
  (cond
    [(is-all-X? lsts) 'X]
    [(is-all-O? lsts) 'O]
    [else #f]))
       
  


