// Programming Languages
// Lecture 09: Binary Methods with OOP: Double Dispatch

abstract class Exp {
    public abstract Value eval();
    public abstract String toString();
    public abstract boolean hasZero();
    public abstract Exp noNegConstants();
}

abstract class Value extends Exp {
    public abstract Value addValues(Value other);      // first dispatch
    public abstract Value addInt(Int other);           // second dispatch
    public abstract Value addString(MyString other);   // second dispatch
    public abstract Value addRational(Rational other); // second dispatch

    public abstract Value multValues(Value other);      // first dispatch
    public abstract Value multInt(Int other);           // second dispatch
    public abstract Value multRational(Rational other); // second dispatch
    public abstract Value multString(MyString other);   // second dispatch
}

class Int extends Value {
    protected int i;

    public Int(int i) {
        this.i = i;
    }

    @Override
    public Value eval() {
        return this;
    }

    @Override
    public String toString() {
        return "" + i;
    }

    @Override
    public boolean hasZero() {
        return i == 0;
    }

    @Override
    public Exp noNegConstants() {
        if (i < 0) {
            return new Int(-i);
        } else {
            return this;
        }
    }

    @Override
    public Value addValues(Value other) {
        return other.addInt(this);
    }

    @Override
    public Value addInt(Int other) {
        return new Int(i + other.i);
    }

    @Override
    public Value addString(MyString other) {
        return new MyString(other.s + i);
    }

    @Override
    public Value addRational(Rational other) {
        return new Rational(i * other.den + other.num, other.den);
    }

    @Override
    public Value multValues(Value other) {
        return other.multInt(this);
    }

    @Override
    public Value multInt(Int other) {
        return new Int(i * other.i);
    }

    @Override
    public Value multRational(Rational other) {
        return new Rational(i * other.num, other.den);
    }

    @Override
    public Value multString(MyString other) {
        throw new UnsupportedOperationException("Cannot multiply a string by an integer.");
    }
}

class MyString extends Value {
    protected String s;

    public MyString(String s) {
        this.s = s;
    }

    @Override
    public Value eval() {
        return this;
    }

    @Override
    public String toString() {
        return s;
    }

    @Override
    public boolean hasZero() {
        return false;
    }

    @Override
    public Exp noNegConstants() {
        return this;
    }

    @Override
    public Value addValues(Value other) {
        return other.addString(this);
    }

    @Override
    public Value addInt(Int other) {
        return new MyString("" + other.i + s);
    }

    @Override
    public Value addString(MyString other) {
        return new MyString(other.s + s);
    }

    @Override
    public Value addRational(Rational other) {
        return new MyString("" + other.num + "/" + other.den + s);
    }

    @Override
    public Value multValues(Value other) {
        return other.multString(this);
    }

    @Override
    public Value multInt(Int other) {
        throw new UnsupportedOperationException("Cannot multiply a string by an integer.");
    }

    @Override
    public Value multRational(Rational other) {
        throw new UnsupportedOperationException("Cannot multiply a string by a rational.");
    }

    @Override
    public Value multString(MyString other) {
        throw new UnsupportedOperationException("Cannot multiply two strings.");
    }
}

class Rational extends Value {
    protected int num;
    protected int den;

    public Rational(int num, int den) {
        this.num = num;
        this.den = den;
    }

    @Override
    public Value eval() {
        return this;
    }

    @Override
    public String toString() {
        return num + "/" + den;
    }

    @Override
    public boolean hasZero() {
        return num == 0;
    }

    @Override
    public Exp noNegConstants() {
        if (num < 0 && den < 0) {
            return new Rational(-num, -den);
        } else if (num < 0) {
            return new Negate(new Rational(-num, den));
        } else if (den < 0) {
            return new Negate(new Rational(num, -den));
        } else {
            return this;
        }
    }

    @Override
    public Value addValues(Value other) {
        return other.addRational(this);
    }

    @Override
    public Value addInt(Int other) {
        return other.addRational(this); // reuse computation of commutative operation
    }

    @Override
    public Value addString(MyString other) {
        return new MyString(other.s + num + "/" + den);
    }

    @Override
    public Value addRational(Rational other) {
        return new Rational(num * other.den + other.num * den, den * other.den);
    }

    @Override
    public Value multValues(Value other) {
        return other.multRational(this);
    }

    @Override
    public Value multInt(Int other) {
        return other.multRational(this);
    }

    @Override
    public Value multRational(Rational other) {
        return new Rational(num * other.num, den * other.den);
    }

    @Override
    public Value multString(MyString other) {
        throw new UnsupportedOperationException("Cannot multiply a string by a rational.");
    }
}

class Negate extends Exp {
    private Exp e;

    public Negate(Exp e) {
        this.e = e;
    }

    @Override
    public Value eval() {
        return new Int(-((Int)(e.eval())).i);
    }

    @Override
    public String toString() {
        return "-(" + e.toString() + ")";
    }

    @Override
    public boolean hasZero() {
        return e.hasZero();
    }

    @Override
    public Exp noNegConstants() {
        return new Negate(e.noNegConstants());
    }
}

class Add extends Exp {
    private Exp e1;
    private Exp e2;
    
    public Add(Exp e1, Exp e2) {
	    this.e1 = e1;
	    this.e2 = e2;
    }

    @Override
    public Value eval() {
	    return new Int(((Int)(e1.eval())).i + ((Int)(e2.eval())).i);
    }
    
    @Override
    public String toString() {
	    return "(" + e1.toString() + " + " + e2.toString() + ")";
    }
    
    @Override
    public boolean hasZero() {
	    return e1.hasZero() || e2.hasZero();
    }

    @Override
    public Exp noNegConstants() {
        return new Add(e1.noNegConstants(), e2.noNegConstants());
    }
}

class Mult extends Exp {
    private Exp e1;
    private Exp e2;
    
    public Mult(Exp e1, Exp e2) {
        this.e1 = e1;
        this.e2 = e2;
    }

    @Override
    public Value eval() {
        return new Int(((Int)(e1.eval())).i * ((Int)(e2.eval())).i);
    }
    
    @Override
    public String toString() {
        return "(" + e1.toString() + " * " + e2.toString() + ")";
    }
    
    @Override
    public boolean hasZero() {
        return e1.hasZero() || e2.hasZero();
    }

    @Override
    public Exp noNegConstants() {
        return new Mult(e1.noNegConstants(), e2.noNegConstants());
    }
}