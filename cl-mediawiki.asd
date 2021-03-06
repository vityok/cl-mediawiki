;; -*- lisp -*-

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :net.acceleration.cl-mediawiki.system)
    (defpackage :net.acceleration.cl-mediawiki.system
        (:use :common-lisp :asdf))))

(in-package :net.acceleration.cl-mediawiki.system)

(defsystem :cl-mediawiki
  :description "A tool to help talk to mediawiki's api."
  :components ((:module :src
                        :serial T
                        :components ((:file "packages")
                                     (:file "util" )
                                     (:file "main" )
                                     (:file "query" )
                                     (:file "edit"))))
  ;; Additional Functionality will be loaded if cl-ppcre is in
  ;; the features list during compilation
  :depends-on (:cxml :drakma :alexandria))

(defsystem :cl-mediawiki-test
  :description "A tool to help talk to mediawiki's api."
  :components ((:module :tests
                        :serial T
                        :components ((:file "setup")
                                     (:file "query" )
                                     (:file "edit"))))
  ;; Additional Functionality will be loaded if cl-ppcre is in
  ;; the features list during compilation
  :depends-on (:cl-mediawiki :lisp-unit))

(defmethod asdf:perform ((o asdf:test-op) (c (eql (find-system :cl-mediawiki))))
  (asdf:oos 'asdf:load-op :cl-mediawiki-test)
  (funcall (intern "RUN-TESTS" :cl-mediawiki-test)
           :use-debugger nil))
