Arrows Macros for Emacs
=======================

This is a port of
`CL-Arrows <https://github.com/nightfly19/cl-arrows>`__ to emacs lisp.
The only real changes were using lexical binding and changing the test
suite to ERT and adjusting the tests for the fact that emacs lisp
doesn’t have fractions.

Implements the ``->`` and ``->>`` threading macros in Clojure, as well
as ``-<>`` and ``-<>>`` from the
`swiss-arrows <https://github.com/rplevy/swiss-arrows>`__ library.

Documentation
-------------

| [macro]
| ``->`` initial-form *&rest* forms => results

Inserts INITIAL-FORM as first argument into the first of FORMS, the
result into the next, etc., before evaluation. FORMS are treated as list
designators.

| [macro]
| ``->>`` initial-form *&rest* forms => results

Like ``->``, but the forms are inserted as last argument instead of
first.

| [macro]
| ``-<>`` initial-form *&rest* forms => results

Like ``->``, but if a form in FORMS has one or more symbols named ``<>``
as top-level element, each such symbol is substituted by the primary
result of the form accumulated so far, instead of it being inserted as
first argument. Also known as diamond wand.

| [macro]
| ``-<>>`` initial-form *&rest* forms => results

Like ``-<>``, but if a form in FORMS has no symbols named ``<>`` as
top-level element, insertion is done like in ``->>``. Also known as
diamond spear.

Examples
--------

.. code:: common-lisp

   (-> 3
       /)  ; insert into designated list (/)
   => 1/3

   (-> 3
       (expt 2))  ; insert as first argument
   => 9

   (->> 3
        (expt 2))  ; insert as last argument
   => 8

   (let ((x 3))
     (-<> (incf x)     ; (let ((r (incf x)))
          (+ <> <>)))  ;   (+ r r))
   => 8

..
   Should find a replacement for this that works in Emacs Lisp:
   (-<>> (list 1 2 3)
         (remove-if #'oddp <> :count 1 :from-end t) ; substitute <>
         (reduce #'+)                               ; insert last
         /)                                         ; list designator
   => 1/3

Install
-------

.. code:: emacs-lisp

  (use-package arrows
    :straight (:host github :repo "tkurtbond/arrow-macros-for-emacs" :files ("arrows.el"))
    :ensure t)

  (require 'arrows)

..

Todo
----

• Future versions *might* include further ideas from rplevy’s
  `swiss-arrows <https://github.com/rplevy/swiss-arrows>`__.

• Look at https://github.com/eschulte/cl-arrowz - license?

• Look at https://github.com/hipeta/arrow-macros for ideas.

..
   Local Variables:
   compile-command: "pandoc -r rst -w ms --template=tkb -V widemargins --output=arrows.pdf README.rst"
   End:
