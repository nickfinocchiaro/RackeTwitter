#lang racket

(require "oauth-single-user.rkt"
  racket/gui/base)

(define twitter-oauth (new oauth-single-user%  
     [consumer-key '()]
     [consumer-secret '()]
     [access-token '()]
     [access-token-secret '()]))

(define (twitter-obj key secret-key token secret-token)
  (set! twitter-oauth (new oauth-single-user%  
     [consumer-key key]
     [consumer-secret secret-key]
     [access-token token]
     [access-token-secret secret-token])))


;Starting frame for RackeTwitter
(define frame (new frame% [label "RackeTwitter"]
                          [width 300]
                          [height 300]))

(define panel1 (new horizontal-panel% [parent frame]
                                      [alignment '(center bottom)]))


;Button to log in
(new button% [parent panel1]
             [label "Log in"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send dialog show #t))])

(new button% [parent panel1]
             [label "Cancel"]
             [callback (lambda (button event)
                         (send frame show #f))])



; Create a login window
(define dialog (instantiate dialog% ("Login")
                [width 500]))
 
; Add a text field to the dialog for login
(define user (new text-field% [parent dialog] [label "Username:"]))
(define pass (new text-field% [parent dialog] [label "Password: "]
                                 [style '(password single)]))
 
; Add a horizontal panel to the dialog, with centering for buttons
(define panel2 (new horizontal-panel% [parent dialog]
                                     [alignment '(center center)]))
 
; Add Cancel and Ok buttons to the horizontal panel
(new button% [parent panel2] [label "Cancel"]
                            [callback (lambda (button event)
                                        (send dialog show #f))])
(new button% [parent panel2] [label "Ok"]
                             [callback (lambda (button event)
                                         ( and (set! user_name (send user get-value)) (set! password (send pass get-value))
                                               (send dialog show #f) (send user set-value "") (send pass set-value "")))])



(when (system-position-ok-before-cancel?)
  (send panel2 change-children reverse))
 


;starts the first frame
(send frame show #t)