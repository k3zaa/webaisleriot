; AisleRiot - triple_peaks.scm
; Copyright (C) 2005 Richard Hoelscher <rah@rahga.com>
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define progressive-rounds #f)
(define multiplier-scoring #f)

(define (new-game)
  (initialize-playing-area)  
  (set-ace-low)
  (make-standard-deck)
  (shuffle-deck)

  (add-normal-slot DECK)
  (add-normal-slot '())
  (set! HORIZPOS 1)
  (add-extended-slot '() right)
  
  (add-carriage-return-slot)
  (add-blank-slot)
  (add-blank-slot)
  (add-normal-slot '())
  (add-blank-slot)
  (add-blank-slot)
  (add-normal-slot '())
  (add-blank-slot)
  (add-blank-slot)
  (add-normal-slot '())

  (add-carriage-return-slot)
  (set! VERTPOS (- VERTPOS (/ 2 3)))
  (set! HORIZPOS (+ HORIZPOS 0.5))
  (add-blank-slot)
  (add-normal-slot '())
  (add-normal-slot '())
  (add-blank-slot)
  (add-normal-slot '())
  (add-normal-slot '())
  (add-blank-slot)
  (add-normal-slot '())
  (add-normal-slot '())

  (add-carriage-return-slot)
  (set! VERTPOS (- VERTPOS (/ 2 3)))
  (add-blank-slot)
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())

  (add-carriage-return-slot)
  (set! VERTPOS (- VERTPOS (/ 2 3)))
  (set! HORIZPOS (+ HORIZPOS 0.5))
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())
  (add-normal-slot '())

  (deal-cards 0 '(3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
  (deal-cards-face-up 0 '(21 22 23 24 25 26 27 28 29 30 2))

  (give-status-message)

  (list 11 3))

(define (progressive-redeal)
  (flip-deck 1 2)
  (add-cards! 0 (get-cards 1))
  (remove-n-cards 1 (length (get-cards 1)))
  (shuffle-deck)
  (deal-cards 0 '(3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
  (deal-cards-face-up 0 '(21 22 23 24 25 26 27 28 29 30 2))
)

(define (give-status-message)
  (set-statusbar-message (get-stock-no-string)))

(define (get-stock-no-string)
  (string-append (_"Stock left:") " " 
		 (number->string (length (get-cards 0)))))

(define (button-pressed slot-id card-list)
  (available? slot-id))

(define (check-for-flips slot-id)
  (cond ((= slot-id 30)
         (if (empty-slot? 29)
             (flip-top-card 20)
             ))
        ((= slot-id 29)
         (begin
           (if (empty-slot? 30)
               (flip-top-card 20)
               )
           (if (empty-slot? 28)
               (flip-top-card 19)
               )))  
        ((= slot-id 28)
         (begin
           (if (empty-slot? 29)
               (flip-top-card 19)
               )
           (if (empty-slot? 27)
               (flip-top-card 18)
               )))
        ((= slot-id 27)
         (begin
           (if (empty-slot? 28)
               (flip-top-card 18)
               )
           (if (empty-slot? 26)
               (flip-top-card 17)
               )))
        ((= slot-id 26)
         (begin
           (if (empty-slot? 27)
               (flip-top-card 17)
               )
           (if (empty-slot? 25)
               (flip-top-card 16)
               )))
        ((= slot-id 25)
         (begin
           (if (empty-slot? 26)
               (flip-top-card 16)
               )
           (if (empty-slot? 24)
               (flip-top-card 15)
               )))
        ((= slot-id 24)
         (begin
           (if (empty-slot? 25)
               (flip-top-card 15)
               )
           (if (empty-slot? 23)
               (flip-top-card 14)
               )))
        ((= slot-id 23)
         (begin
           (if (empty-slot? 24)
               (flip-top-card 14)
               )
           (if (empty-slot? 22)
               (flip-top-card 13)
               )))
        ((= slot-id 22)
         (begin
           (if (empty-slot? 23)
               (flip-top-card 13)
               )
           (if (empty-slot? 21)
               (flip-top-card 12)
               )))
        ((= slot-id 21)
         (if (empty-slot? 22)
             (flip-top-card 12)
             ))

        ((= slot-id 20)
         (if (empty-slot? 19)
             (flip-top-card 11)
             ))
	((= slot-id 19)
         (begin
           (if (empty-slot? 20)
               (flip-top-card 11)
               )
           (if (empty-slot? 18)
               (flip-top-card 10)
               )))
        ((= slot-id 18)
         (if (empty-slot? 19)
             (flip-top-card 10)
             ))
        ((= slot-id 17)
         (if (empty-slot? 16)
             (flip-top-card 9)
             ))
        ((= slot-id 16)
         (begin
           (if (empty-slot? 17)
               (flip-top-card 9)
               )
           (if (empty-slot? 15)
               (flip-top-card 8)
               )))
        ((= slot-id 15)
         (if (empty-slot? 16)
             (flip-top-card 8)
             ))
        ((= slot-id 14)
         (if (empty-slot? 13)
             (flip-top-card 7)
             ))
        ((= slot-id 13)
         (begin
           (if (empty-slot? 14)
               (flip-top-card 7)
               )
           (if (empty-slot? 12)
               (flip-top-card 6)
               )))
        ((= slot-id 12)
         (if (empty-slot? 13)
             (flip-top-card 6)
             ))
        ((= slot-id 11)
         (if (empty-slot? 10)
             (flip-top-card 5)
             ))
        ((= slot-id 10)
         (if (empty-slot? 11)
             (flip-top-card 5)
             ))
        ((= slot-id 9)
         (if (empty-slot? 8)
             (flip-top-card 4)
             ))
        ((= slot-id 8)
         (if (empty-slot? 9)
             (flip-top-card 4)
             ))
        ((= slot-id 7)
         (if (empty-slot? 6)
             (flip-top-card 3)
             ))
        ((= slot-id 6)
         (if (empty-slot? 7)
             (flip-top-card 3)
             ))))

(define (available? slot-id)
  (and (not (empty-slot? slot-id))
       (> slot-id 2)
       (is-visible? (get-top-card slot-id))))

(define (movable? card)
  (and (not (empty-slot? 2))
       (or (eq? (modulo (+ 1 (get-value card)) 13)
                (modulo (get-value (get-top-card 2)) 13))
	   (eq? (modulo (get-value card) 13) 
		(modulo (+ 1 (get-value (get-top-card 2))) 13)))))

(define (droppable? start-slot card-list end-slot)
  (and (not (= start-slot end-slot))
       (= end-slot 2)
       (movable? (car card-list))))

(define (tally-score start-slot)
  (begin
    (if multiplier-scoring
	(add-to-score! (integer-expt 2 (- (length (get-cards 2)) 2)))
	(add-to-score! (- (length (get-cards 2)) 1)))
    (check-bonus start-slot)
    (check-for-flips start-slot)))

(define (check-bonus slot-id)
  (and (< slot-id 6)
       (if (game-won)
           (if multiplier-scoring
               (add-to-score! 50)
               (add-to-score! 30))
           (if multiplier-scoring
               (add-to-score! 25)
               (add-to-score! 15))))
  (and (game-won) 
       progressive-rounds
       (progressive-redeal)))

(define (button-released start-slot card-list end-slot)
  (and (= end-slot 2)
       (movable? (car card-list))
       (move-n-cards! start-slot end-slot card-list)
       (tally-score start-slot)))

(define (do-deal-next-cards)
  (and (flip-deck 1 2)
       (deal-cards-face-up 0 '(2))
       (if (not multiplier-scoring)
           (set-score! (max (- (get-score) 5) 0)))))

(define (button-clicked slot-id)
  (if (= slot-id 0)
      (and (not (empty-slot? 0))
           (do-deal-next-cards))
      (and (> slot-id 2)
           (available? slot-id)
           (movable? (get-top-card slot-id))
           (deal-cards slot-id '(2))
           (tally-score slot-id))))

(define (dealable?)
  (not (empty-slot? 0)))

(define (button-double-clicked slot-id)
    (button-clicked slot-id))

(define (game-continuable)
  (give-status-message)
  (and (not (game-won))
       (get-hint)))

(define (game-won)
  (and (empty-slot? 3)
       (empty-slot? 4)
       (empty-slot? 5)))

(define (check-move slot-id)
  (and (< slot-id 31)
       (or (check-move (+ 1 slot-id))
	   (and (available? slot-id)
		(movable? (get-top-card slot-id))
		(list 1
		      (get-name (get-top-card slot-id))
		      (get-name (get-top-card 2)))))))

(define (dealable?)
  (and (not (empty-slot? 0))
       (list 0 (_"Deal a card"))))

(define (get-hint)
  (or (check-move 3)  
      (dealable?)))

(define (get-options)
  (list (list (_"Progressive Rounds") progressive-rounds) 
        (list (_"Multiplier Scoring") multiplier-scoring)))

(define (apply-options options)
  (set! progressive-rounds (cadar options))
  (set! multiplier-scoring (cadadr options)))

(define (timeout) 
  #f)

(set-features droppable-feature dealable-feature)

(set-lambda new-game button-pressed button-released button-clicked button-double-clicked game-continuable game-won get-hint get-options apply-options timeout droppable? dealable?)
