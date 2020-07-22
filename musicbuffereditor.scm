(load "setup.scm")

;; This actor changes a musicbuffer (a musicbuffer can be several samples
;; or the whole music file)

(define (make-music-buffer-editor musicbuffer)
	(let ((*musicbuffer musicbuffer)
	      )

	  ;; for dynamic binding
	  (define (apply-function functor args) ;; NOTE that args is not optional
	    (((functor 'do) args)))

	  (define (apply-function-on-buffer functor)
	    (((functor 'do) *musicbuffer)))

	  ;; double dispatch
	  (define (apply-function-on-buffer2 functor)
	    (((*musicbuffer 'apply) functor)))

	(define (dispatch msg)
		(cond ((eq? msg 'apply-function) apply-function)
		      ((eq? msg 'apply-function-on-buffer) apply-function-on-buffer)
		      ((eq? msg 'apply-function-on-buffer2) apply-function-on-buffer2)
		      (else (display "make-music-buffer-editor : message not understood : ")(display msg)(newline))))

	dispatch))
