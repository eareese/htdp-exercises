; Provide a structure type definition and a data definition for representing points in time since midnight. A point in time consists of three numbers: hours, minutes, and seconds.

; Timepoint is (make-timepoint Number Number Number)
(define-struct timepoint [hours minutes seconds])
; Timepoint represents a point in time relative to midnight.
; a timepoint has 3 parts:
; - hours, number. hours since midnight at the timepoint  [0,23]
; - minutes, number. minutes past the hour since midnight [0,59]
; - seconds, number. seconds past the time since midnight [0,59]


; a time-thing is one of:
