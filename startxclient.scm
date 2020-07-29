#!/bin/sh
exec scsh -lel heap-images/load.scm -lel cml/load.scm -lel scx/load.scm -o xlib -o rendezvous-channels -s "$0" "$@"
!#

;; define all catchable events

(define all-events-mask
  (event-mask
   key-press key-release button-press button-release enter-window leave-window
   pointer-motion pointer-motion-hint button-1-motion button-2-motion 
   button-3-motion button-4-motion button-5-motion button-motion keymap-state
   exposure visibility-change structure-notify resize-redirect
   substructure-notify substructure-redirect focus-change property-change
   colormap-change owner-grab-button))

;; main program

(define (startxclient)
  (let* ((dpy (open-display))
	 (black (black-pixel dpy))
	 (white (white-pixel dpy))
	 (win (create-simple-window dpy (default-root-window dpy) 0 0
				    300 200 0 black white)))

    (set-wm-name! dpy win (string-list->property '("Gondolin Sound Editor")))
    (map-window dpy win)

    (init-sync-x-events dpy)
    (call-with-event-channel
     dpy win all-events-mask
     (lambda (channel)
       (let loop ()
	 (let ((e (receive channel)))
	   ((expose-event? e)
	    (clear-window dpy win)
	    (draw-points dpy win gc point-count 0 0 
			 (/ width 2) (/ height 2))
	      (draw-image-string dpy win gc 10 10 "Click a button to exit"))

;; scheme event listener, last conditional
;;	   (display (any-event-type e)) (display " on window ")
;;	   (display (any-event-window e)) (newline)
	   (if (not (destroy-window-event? e))
	       (loop))))))))

(startxclient)