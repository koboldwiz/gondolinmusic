;; (load "setup.scm")

;; The music file handle (wrapped later on in mp3 or ogg file handle)

(define (make-music-file filename)
	(let ((*filename filename)
	      (*filereadstream (make-file-read-stream))
	      (*musicbuffer (make-music-buffer))
	      )

	(define (open)
	  ((*filereadstream 'open) *filename)
	  )

	(define (load)
	  (open)
	  )

	(define (dispatch msg)
		(cond ((eq? msg 'load) load)
		      ((eq? msg 'get-buffer) get-buffer)
		      (else (display "make-music-buffer-editor : message not understood : ")(display msg)(newline))))

	dispatch))