class A:
    def even(self, x):
        print("in even A")
        return True if x == 0 else self.odd(x - 1)

    def odd(self, x):
        print("in odd A")
        return False if x == 0 else self.even(x - 1)
    

a1 = A().odd(7)
print(f"a1 is {a1}\n")


class B(A):
    def even(self, x):
        print("in even B")
        return x % 2 == 0


a2 = B().odd(7)
print(f"a2 is {a2}\n")


class C(A):
    def odd(self, x):
        print("in odd C")
        return False


a3 = C().odd(7)
print(f"a3 is {a3}\n")