(ffi:clines "#include <stdlib.h>")
(ffi:def-function ("free" c-free)
  ((ptr (* :char)))
  :returning :void)
(ffi:def-function ("malloc" c-malloc)
  ((size :unsigned-long))
  :returning :pointer-void)

(defun strlen (s)
  (strlen-n s 0))

(defun strlen-n (s n)
  (ffi:def-array-pointer ca :char)
  (if (ffi:null-char-p (ffi:deref-array s 'ca n))
      0
      (+ 1 (strlen-n s (+ n 1)))))

(defun strcpy (dst src n s_len)
  (ffi:def-array-pointer ca :char)
  (dotimes (i n i)
    (setf
      (ffi:deref-array dst 'ca (+ i s_len))
      (char src i)))
  (setf
      (ffi:deref-array dst 'ca (+ n s_len))
      (code-char 0)))

(defun memcpy (dst src n)
  (ffi:def-array-pointer ca :char)
  (dotimes (i n i)
    (setf
      (ffi:deref-array dst 'ca i)
      (ffi:deref-array src 'ca i))))

(defun day_lisp_10 (so_far)
  (let* ((today 
          (format nil "Ten close parens~%"))
        (out
          (c-malloc (+ (length today) (strlen so_far) 1))))
      (memcpy out so_far (strlen so_far))
      (strcpy out today 17 (strlen so_far))

      (c-free so_far)
      out))
