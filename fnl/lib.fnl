;; Type checking
(fn nil? [elem] (= nil elem))
(fn number? [elem] (= :number (type elem)))
(fn boolean? [elem] (= :boolean (type elem)))
(fn string? [elem] (= :string (type elem)))
(fn function? [elem] (= :function (type elem)))
(fn table? [elem] (= :table (type elem)))

(fn empty? [seq]
  (or (nil? seq) (nil? (next seq))))

(fn non-empty? [seq]
  (not (empty? seq)))

(fn sequence? [elem]
  (and (table? elem) (or (empty? elem) (not= nil (. elem 1)))))

(sequence? [:a :b :c])
(sequence? {:a 1 :b 2 :c 3})

;; list access
(fn head [seq]
  (when (non-empty? seq)
    (. seq 1)))

(fn tail [seq]
  (when (non-empty? seq)
    (let [acc []]
      (for [i 2 (length seq)]
        (tset acc (+ (length acc) 1) (. seq i)))
      acc)))

(fn keys [tbl]
  (if (or (empty? tbl) (not (table? tbl))) [] (icollect [k _ (pairs tbl)] k)))

;; TODO Add =table and =itable

(fn =table [...])

(fn =itable [...])

(comment "use =table and =itable to check"
  (assert (= [] (keys nil) (keys []) (keys {})))
  (assert (= [:a :b :c] (keys {:a 1 :b 2 :c 3}))))

(fn fold-left [reduce-fn zero seq]
  (if (empty? seq)
      zero
      (fold-left reduce-fn (reduce-fn zero (head seq)) (tail seq))))

(assert (assert (= 6 (fold-left #(+ $1 $2) 0 [1 2 3])))
        (assert (= 125 (fold-left #(* $1 $2) 1 [5 5 5])))
        (assert (= false (fold-left #(and $1 (= (% $2 2) 0)) true [2 4 6 7]))))

;; fails
(comment "use =table and =itable to check"
  (assert (assert (= [2 3] (tail [1 2 3])))
          (assert (= nil (tail nil)) (tail []))))

(fn map [col])

(fn filter [col])

(fn min [seq]
  (fold-left #(if (<= $1 $2) $1 $2) (head seq) (tail seq)))

(fn max [seq]
  (fold-left #(if (> $1 $2) $1 $2) (head seq) (tail seq)))

(fn mkstring [delimiter ...]
  (local strings [...])
  (fold-left #(if delimiter
                  (.. $1 delimiter $2)
                  (.. $1 $2)) (or (head strings) "")
             (tail strings)))

(assert (assert (= 1 (min [5 19 4 1 94]))) (assert (= nil (min nil) (min []))))

(assert (assert (= "" (mkstring) (mkstring nil)))
        (assert (= :123 (mkstring nil 1 2 3) (mkstring "" 1 2 3)))
        (assert (= :a-b-c (mkstring "-" :a :b :c))))

(fn merge! [...])

(fn merge [...]
  "merge one or more tables")

(fn concat [...]
  "concatenate one or more sequences")
