(define-struct movie [title producer year])
(define-struct t-l
  (make-movie "Thelma & Louise" "Pathé Entertainment" "1991"))
(movie-title t-l)     ; "Thelma & Louise"
(movie-producer t-l)  ; "Pathé Entertainment"
(movie-year t-l)      ; "1991"
(movie? t-l)          ; #t

(define-struct person [name hair eyes phone])
(define-struct me (make-person "reese" #t #t #t))
(person-name me)   ; "reese"
(person-hair me)   ; #t
(person-eyes me)   ; #t
(person-phone me)  ; #t
(person? me)       ; #t

(define-struct pet [name number])
(define-struct a-cat (make-pet "raisins" 1))
(pet-name a-cat)   ; "raisins"
(pet-number a-cat) ; 1
(pet? a-cat)       ; #t

(define-struct CD [artist title price])
(define-struct my-first-cd (make-CD
  "Smash Mouth" "Astro Lounge" 19.99))
(CD-artist my-first-cd)  ; "Smash Mouth"
(CD-title my-first-cd)   ; "Astro Lounge"
(CD-price my-first-cd)   ; 19.99
(CD? my-first-cd)        ; #t

(define-struct sweater [material size producer])
(define-struct fancy-sw
  (make-sweater "wool" "small" "a tiny nordic island"))
(sweater-material fancy-sw) ; "wool"
(sweater-size fancy-sw)     ; "small"
(sweater-producer fancy-sw) ; "a tiny nordic island"
(sweater? fancy-sw)         ; #t
