(load "setup.scm")

;; A musicbuffer contains pieces of a music file, wrapped in a collection with
;; collectionelements (see the gondolin utilities package in setup.scm)

(define (make-music-buffer)
	(let ((*buffer-of-elements (make-collection))
	      )

	  (define (ref k)
	    ((*buffer-of-elements 'ref) k))

	  ;; object is raw data, which gets wrapped into a element
	  (define (add-element object)
	    ((*buffer-of-elements 'add-element) object))

	  ;; SFY
	  (define (apply-functor functor)
	    (((functor 'do) *buffer-of-elements)))

	(define (dispatch msg)
		(cond ((eq? msg 'add-element) add-element)
		      ((eq? msg 'ref) ref)
		      ((eq? msg 'apply-functor) apply-functor)
		      (else (display "make-music-buffer : message not understood : ")(display msg)(newline))))

	dispatch))
