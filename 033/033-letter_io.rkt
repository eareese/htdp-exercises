#lang htdp/bsl
(require 2htdp/batch-io)

(define (letter fst lst sig-name)
  (string-append
   (opening fst)
   "\n\n"
   (body fst lst)
   "\n\n"
   (closing sig-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "We have discovered that all people with the last name " "\n" lst " have won our lottery. So, " fst ", " "\n"
   "hurry and pick up your prize."))

(define (closing sig-name)
  (string-append
   "Sincerely,"
   "\n\n"
   sig-name
   "\n"))

;; Run letter on three inputs of your choice.
(write-file 'stdout (letter "Matthew" "Fisler" "Felleisen"))
(write-file 'stdout (letter "Roseanne" "Barr" "Cher"))
(write-file 'stdout (letter "Cat" "Stevens" "Tyson"))

;; Here is a letter-writing batch program that reads names from three files and writes a letter to one:
(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

;; The function consumes four strings: the first three are the names of input files and the last one serves as output file. It uses the first three to read one string each from the three named files, hands these strings to letter, and eventually writes the result of this function call into the file named by out, the fourth argument to main.

;; Create appropriate files, launch main, and check whether it delivers the expected letter.
(main "fst.txt" "lst.txt" "sig.txt" "out.txt")

