Formulate data definitions for the following structure type definitions:

(define-struct movie [title producer year])
; a movie has three parts:
; - title, which is a string (the title of the movie)
; - producer, a string (the producer of the movie)
; - year, a number (the date in which the movie was released)

(define-struct person [name hair eyes phone])
; a person has four parts:
; - name, a string representing the person's name
; - hair, perhaps t/f indicating whether or not they have hair
; - eyes, t/f does the person have eyes
; - phone, t/f does the person have a phone.

(define-struct pet [name number])
; a pet has two parts:
; - name, a string that represents what we call it
; - number, a number indicating the quantity of individuals

(define-struct CD [artist title price])
; a CD has three parts:
; - artist, a string representing the artist
; - title, a string representing the title of the work
; - price, a number that represents a price for the CD

(define-struct sweater [material size producer])
; a sweater has three parts:
; - material, a string for the material of the sweater
; - size, a string to denote the size of the garment
; - producer, a string describing the origin of the sweater

Make sensible assumptions as to what kind of values go into each field.
; trollface.gif
