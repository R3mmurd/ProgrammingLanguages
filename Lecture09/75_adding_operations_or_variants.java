// Programming Languages
// Lecture 09: Adding Operations or Variants

abstract class Exp {
    public abstract Value eval();
    public abstract String toString();
    public abstract boolean hasZero();
    public abstract Exp noNegConstants();
}

abstract class Value extends Exp {

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
            return new Negate(new Int(-i));
        } else {
            return this;
        }
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

final class Main {
    public static void main(String[] args) {
        // 5 + 10 * (-3)
        Exp e = new Add(new Int(5), new Mult(new Int(10), new Negate(new Int(3))));
        System.out.println("Does e have a zero? " + e.hasZero());
        System.out.println(e.toString() + " = " + e.eval().toString());

        // 5 + 10 * (-3)
        Exp e2 = new Add(new Int(5), new Mult(new Int(10), new Int(-3))).noNegConstants();
        System.out.println("Does e2 have a zero? " + e2.hasZero());
        System.out.println(e2.toString() + " = " + e2.eval().toString());
    }
}