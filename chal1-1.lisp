(ql:quickload "cl-ppcre")

(defvar locations-first nil)
(defvar locations-second nil)

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
    (format t "[1] First: ~a Second: ~a~%" (length locations-first) (length locations-second))
    (setf locations-first (sort locations-first #'<)
          locations-second (sort locations-second #'<))
    (format t "[2] First: ~a Second: ~a~%" (length locations-first) (length locations-second))
    (format t "~a~%" (reduce #'+ (mapcar #'difference locations-first locations-second)))))

(defun parse-line (line)
  (let ((items (cl-ppcre:split "\\s+" line)))
    (cons (parse-integer (nth 0 items)) (parse-integer (nth 1 items)))))

(defun difference (a b)
  (abs (- a b)))
