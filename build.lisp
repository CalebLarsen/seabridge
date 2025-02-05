(compile-file "src/print.lisp" :system-p t)

(c:build-static-library "lisp-out/print_lisp"
                        :lisp-files '("src/print.o")
                        :init-name "init_print")
(quit)
