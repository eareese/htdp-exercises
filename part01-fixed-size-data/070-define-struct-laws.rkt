(define-struct centry [name home office cell])

(centry-name
 (make-centry name0 home0 office0 cell0)
 name0)

(centry-home
 (make-centry name0 home0 office0 cell0)
 home0)

(centry-office
 (make-centry name0 home0 office0 cell0)
 office0)

(centry-cell
 (make-centry name0 home0 office0 cell0)
 cell0)



(define-struct phone [area number])

(phone-area
 (make-phone area0 number0)
 area0)

(phone-number
 (make-phone area0 number0)
 number0)



(phone-area
 (centry-office
  (make-centry
   "Shriram Fisler"
   (make-phone 207 "363-2421")
   (make-phone 101 "776-1099")
   (make-phone 208 "112-9981"))))

;; then,
;; (centry-office
;;  (make-centry name0 home0 office0 cell0)
;;  office0)

(phone-area
 (make-phone 101 "776-1099"))

;; then,
;; (phone-area
;;  (make-phone area0 number0)
;;  area0)


; 101


