;;ANSI Common Lisp
;;Exercises from Chapter 1

1.	  

;;a) 
;;14
(+ (- 5 1) (+ 3 7))

	     
b) (list 1 (+ 2 3))
   (1 5)

c) (if (listp 1) (+ 1 2) (+ 3 4))
   7

d) (list(and (listp 3) t) (+ 1 2))
   (nil 3)

2.    

(cons 'a '(b c))
(cons 'a (cons 'b '(c)))
(cons 'a (cons 'b (cons 'c nil)))

3.    

(let ((a 0))
     (defun foo(a) (car (cdr (cdr (cdr a)))))
     (foo '(aa bb cc dd ee)))

4.

(let ((a 1))
  (defun foo (x y)
    (cond ((> x y) x) (t y)))
  (foo 22 122))

5.

a) any nil in list?

b) x found in list y? if so return position (zero based), else nil

(let ((a 1))
  (defun foo (x y)
    (if (null y)
	nil
      (if (eq (car y) x)
	  0
	(let ((z (foo x (cdr y))))
	  (and z (+ z 1))))))
  (foo 3 '(221 2 222 3 22)))

6.

a) (car (car (cdr '(a (b c) d))))
   b

b) (or 13 (/ 1 0))
   13

c) (x #'list 1 nil)

((lambda (x y z) (cons (car (funcall x y z)) nil)) #'list 1 nil)
((lambda (x y z) '(1)) #'list 1 nil)

7.

(let ((a 1))
  (defun foo2 (x)
    (if (null x)
	nil
	(or (listp (car x)) (foo2 (cdr x)))))
    (foo2 '(1 2 3 (4))))

8.

a) 

(let ((a 1))
  (defun foo (z)
    (defun foo2 (x y)
      (if (eq 0 x)
	  y
	  (foo2 (- x 1) (cons '* y))))
    (foo2 z nil))
  (foo 3))

b)

(let ((a 1))
  (defun foo (z)
    (if (null z)
	nil
	(if (eq (car z) 'a)
	    1
	    (let ((h (foo x (cdr y))))
	      (and z (+ z 1))))))


  (if (null x)
      nil
      (and 
       (+ (foo (cdr z)  (- x 1) (cons '* y))))
      (foo2 z nil))
  (foo 3))

(if (> 0 x)
    (cons '. y)
    (or (listp (car x)) (foo2 (cdr x)))))

(foo2 '(1 2 3 (4))))
