package p1

trait T1 {
  implicit class C(s: Any) {
    def extMethodWithInferredType = O1.o1
  }
}
