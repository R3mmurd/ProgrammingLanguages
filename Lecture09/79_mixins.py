class Doubler:
    def double(self):
        return self + self
    

class Point2D(Doubler):
    def __init__(self, x, y):
        self.x = x
        self.y = y
        
    def __repr__(self):
        return f'({self.x}, {self.y})'
    
    def __add__(self, other):
        return Point2D(self.x + other.x, self.y + other.y)
    

class MyStr(str, Doubler):
    pass


p = Point2D(1, 2)
print(p)
print(p.double())

s = MyStr('abc')
print(s)
print(s.double())