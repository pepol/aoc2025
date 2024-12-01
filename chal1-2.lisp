(ql:quickload "cl-ppcre")

(defvar locations-first nil)
(defvar locations-second nil)
(defvar results nil)

(let ((in (open "input.txt")))
  (when in
    (setf locations-first nil
          locations-second nil)
    (loop for line = (read-line in nil)
          while line do
            (let ((numbers (parse-line line)))
              (push (car numbers) locations-first)
              (push (cdr numbers) locations-second)))
    (close in)
    (setf results
          (map 'list (lambda (x) (* x (count x locations-second))) locations-first))
    (format t "Results: [~a]~%" results)
    (format t "~a~%" (reduce #'+ results))))

(defun parse-line (line)
  (let ((items (cl-ppcre:split "\\s+" line)))
    (cons (parse-integer (nth 0 items)) (parse-integer (nth 1 items)))))

(defun difference (a b)
  (abs (- a b)))
