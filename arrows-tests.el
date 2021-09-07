;;; Started out from
;;; https://github.com/nightfly19/cl-arrows/blob/master/test.lisp

(ert-deftest arrows--> ()
  (should (= (-> 3.0 /) 0.3333333333333333))
  (should (= (-> 3.0 (/)) 0.3333333333333333))
  (should (= (-> 3.0 (/ 2)) 1.5))
  (should (= (-> 3.0 (/ 2) /) 0.6666666666666666)))

(ert-deftest arrows-->> ()
  (should (= (->> 3.0 /) 0.3333333333333333))
  (should (= (->> 3.0 (/)) 0.3333333333333333))
  (should (= (->> 3.0 (/ 2)) 0.6666666666666666))
  (should (= (->> 3.0 (/ 2) /) 1.5)))

(ert-deftest arrows--<> ()
  (should (= (-<> 3.0 /) 0.3333333333333333))
  (should (= (-<> 3.0 (/)) 0.3333333333333333))
  (should (= (-<> 3.0 (/ 2)) 1.5))
  (should (= (-<> 3.0 (/ 2) /) 0.6666666666666666))
  (should (= (let ((x 3))
           (-<> (incf x)
                (+ <> <>)))
         8)))

(ert-deftest arrows--<>> ()
  (should (= (-<>> 3.0 /) 0.3333333333333333))
  (should (= (-<>> 3.0 (/)) 0.3333333333333333))
  (should (= (-<>> 3.0 (/ 2)) 0.6666666666666666))
  (should (= (-<>> 3.0 (/ 2) /) 1.5))
  ;; Because emacs lisp doesn't have fractions, this isn't useful.
  ;; Maybe use calc for fractions?
  ;; (should (= (-<>> (list 1 2 3)
  ;;              (remove-if #'oddp <> :count 1 :from-end t)
  ;;              (reduce #'+)
  ;;              /)
  ;;           1/3)
  )
