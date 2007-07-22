(setq eval-expression-print-length nil)
(setq objects '(whiskey-bottle bucket frog chain))

(setq map '((living-room (you are in the living room
                of a wizards house - there is a wizard
                snoring loudly on the couch -)
                (west door garden)
                (upstairs stairway attic))
              (garden (you are in a beautiful garden -
                there is a well in front of you -) 
                (east door living-room))
              (attic (you are in the attic of the
                wizards house - there is a giant
                welding torch in the corner -)
                (downstairs stairway living-room)))) 

(setq object-locations '((whiskey-bottle living-room)
                           (bucket living-room)
                           (chain garden)
                           (frog garden)))

(setq location 'living-room) 

(defun describe-location (location map)
    (second (assoc location map)))

(describe-location 'living-room map)

(defun describe-path (path)
  `(there is a ,(second path) going ,(first path) from here.)) 

(describe-path '(west door garden))

(defun describe-paths (location map)
  (apply #'append (mapcar #'describe-path (cddr (assoc location map)))))

(describe-paths 'living-room map)

(defun is-at (obj loc obj-loc)
  (eq (second (assoc obj obj-loc)) loc))

(is-at 'whiskey-bottle 'living-room object-locations)

(defun describe-floor (loc objs obj-loc)
  (apply #'append (mapcar (lambda (x) 
                            `(you see a ,x on the floor.))
                          (remove-if-not (lambda (x)
                                           (is-at x loc obj-loc))
                                         objs)))) 

(describe-floor 'living-room objects object-locations)



(defun look ()
  (append (describe-location location map)
          (describe-paths location map)
          (describe-floor location objects object-locations))) 

(look)


(defun walk-direction (direction)
  (let ((next (assoc direction (cddr (assoc location map)))))
    (cond (next (setf location (third next)) (look))
      (t '(you cant go that way.))))) 

;; try walking around...

(walk-direction 'west)
(walk-direction 'east)
(walk-direction 'upstairs)
(walk-direction 'downstairs)
(look) 