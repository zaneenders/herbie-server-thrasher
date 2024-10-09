let det44 = """
        (FPCore  (x y z t a b c i j k y0 y1 y2 y3 y4 y5)
        :alt 
        (! :herbie-platform default
        (if (< y4 -7.206256231996481e+60)
        (-
            (-
            (* (- (* b a) (* i c)) (- (* y x) (* t z)))
            (-
            (* (- (* j x) (* k z)) (- (* y0 b) (* i y1)))
            (* (- (* j t) (* k y)) (- (* y4 b) (* y5 i)))))
            (-
            (/ (- (* y2 t) (* y3 y)) (/ 1 (- (* y4 c) (* y5 a))))
            (* (- (* y2 k) (* y3 j)) (- (* y4 y1) (* y5 y0)))))
        (if (< y4 -3.364603505246317e-66)
            (+
            (-
            (- (- (* (* t c) (* i z)) (* (* a t) (* b z))) (* (* y c) (* i x)))
            (* (- (* b y0) (* i y1)) (- (* j x) (* k z))))
            (-
            (* (- (* y0 c) (* a y1)) (- (* x y2) (* z y3)))
            (-
                (* (- (* t y2) (* y y3)) (- (* y4 c) (* a y5)))
                (* (- (* y1 y4) (* y5 y0)) (- (* k y2) (* j y3))))))
            (if (< y4 -1.2000065055686116e-105)
            (+
                (+
                (-
                (* (- (* j t) (* k y)) (- (* y4 b) (* y5 i)))
                (* (* y3 y) (- (* y5 a) (* y4 c))))
                (+
                (* (* y5 a) (* t y2))
                (* (- (* k y2) (* j y3)) (- (* y4 y1) (* y5 y0)))))
                (-
                (* (- (* x y2) (* z y3)) (- (* c y0) (* a y1)))
                (-
                (* (- (* b y0) (* i y1)) (- (* j x) (* k z)))
                (* (- (* y x) (* z t)) (- (* b a) (* i c))))))
            (if (< y4 6.718963124057495e-279)
                (+
                (-
                (-
                    (- (* (* k y) (* y5 i)) (* (* y b) (* y4 k)))
                    (* (* y5 t) (* i j)))
                (-
                    (* (- (* y2 t) (* y3 y)) (- (* y4 c) (* y5 a)))
                    (* (- (* y2 k) (* y3 j)) (- (* y4 y1) (* y5 y0)))))
                (-
                (* (- (* b a) (* i c)) (- (* y x) (* t z)))
                (-
                    (* (- (* j x) (* k z)) (- (* y0 b) (* i y1)))
                    (* (- (* y2 x) (* y3 z)) (- (* c y0) (* y1 a))))))
                (if (< y4 4.77962681403792e-222)
                (+
                    (+
                    (-
                    (* (- (* j t) (* k y)) (- (* y4 b) (* y5 i)))
                    (* (* y3 y) (- (* y5 a) (* y4 c))))
                    (+
                    (* (* y5 a) (* t y2))
                    (* (- (* k y2) (* j y3)) (- (* y4 y1) (* y5 y0)))))
                    (-
                    (* (- (* x y2) (* z y3)) (- (* c y0) (* a y1)))
                    (-
                    (* (- (* b y0) (* i y1)) (- (* j x) (* k z)))
                    (* (- (* y x) (* z t)) (- (* b a) (* i c))))))
                (if (< y4 2.2852241541266835e-175)
                    (+
                    (-
                    (-
                        (- (* (* k y) (* y5 i)) (* (* y b) (* y4 k)))
                        (* (* y5 t) (* i j)))
                    (-
                        (* (- (* y2 t) (* y3 y)) (- (* y4 c) (* y5 a)))
                        (* (- (* y2 k) (* y3 j)) (- (* y4 y1) (* y5 y0)))))
                    (-
                    (* (- (* b a) (* i c)) (- (* y x) (* t z)))
                    (-
                        (* (- (* j x) (* k z)) (- (* y0 b) (* i y1)))
                        (* (- (* y2 x) (* y3 z)) (- (* c y0) (* y1 a))))))
                    (+
                    (-
                    (+
                        (+
                        (-
                        (* (- (* x y) (* z t)) (- (* a b) (* c i)))
                        (-
                        (* k (* i (* z y1)))
                        (+ (* j (* i (* x y1))) (* y0 (* k (* z b))))))
                        (-
                        (* z (* y3 (* a y1)))
                        (+ (* y2 (* x (* a y1))) (* y0 (* z (* c y3))))))
                        (* (- (* t j) (* y k)) (- (* y4 b) (* y5 i))))
                    (* (- (* t y2) (* y y3)) (- (* y4 c) (* y5 a))))
                    (* (- (* k y2) (* j y3)) (- (* y4 y1) (* y5 y0)))))))))))
        (+
        (-
        (+
            (+
            (-
            (* (- (* x y) (* z t)) (- (* a b) (* c i)))
            (* (- (* x j) (* z k)) (- (* y0 b) (* y1 i))))
            (* (- (* x y2) (* z y3)) (- (* y0 c) (* y1 a))))
            (* (- (* t j) (* y k)) (- (* y4 b) (* y5 i))))
        (* (- (* t y2) (* y y3)) (- (* y4 c) (* y5 a))))
        (* (- (* k y2) (* j y3)) (- (* y4 y1) (* y5 y0)))))
    """
let easier = """
    (FPCore (p r q)
        (* (/ 1.0 2.0) (- (+ (fabs p) (fabs r)) (sqrt (+ (pow (- p r) 2.0) (* 4.0 (pow q 2.0)))))))
    """
let simple = """
    (FPCore (x) (- (sqrt (+ x 1))))
    """

enum Tutorial {
    static let cancel_like_terms = """
        (FPCore (x)
            :name "Cancel like terms"
            (- (+ 1 x) x))
        """
    static let commute_and_associate = """
        (FPCore (x y z)
            :name "Commute and associate"
            (- (+ (+ x y) z) (+ x (+ y z))))
        """
}

func jsonReady(_ fpcore: String) -> String {
    let quote_in = """
        \"
        """
    let quote_out = """
        \\\"
        """
    return fpcore.replacingOccurrences(of: "\n", with: "\\n")
        .replacingOccurrences(of: quote_in, with: quote_out)
}
