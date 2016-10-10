#lang htdp/bsl

;; Exercise 129. Create BSL lists that represent

;; a list of celestial bodies, say, at least all the planets in our solar system;
;; a list of items for a meal, for example, steak, French fries, beans, bread, water, brie cheese, and ice cream; and
;; a list of colors.

;; Sketch box representations of these lists, similar to those in figure 43 and figure 44. Which of the sketches do you like better?

;; a list of celestial bodies, say, at least all the planets in our solar system;
(cons "Mercury"
      (cons "Venus"
            (cons "Earth"
                  (cons "Mars"
                        (cons "Jupiter"
                              (cons "Saturn"
                                    (cons "Uranus"
                                          (cons "Neptune"
                                                (cons "The other ones?")))))))))

;; a list of items for a meal, for example, steak, French fries, beans, bread, water, brie cheese, and ice cream;
(cons "steak"
      (cons "French fries"
            (cons "beans"
                  (cons "bread"
                        (cons "water"
                              (cons "brie cheese"
                                    cons "ice cream"))))))
;; a list of colors.
(cons "black"
      (cons "brown"
            (cons "orange"
                  (cons "red"
                        (cons "purple"
                              (cons "blue"
                                    (cons "green"
                                          (cons "yellow"
                                                (cons "white")))))))))
