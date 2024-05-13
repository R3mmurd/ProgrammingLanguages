// Programming Languages
// Lecture 09: OOP vs Functional Decomposition

abstract class Exp {
    public abstract Value eval();
    public abstract String toString();
    public abstract boolean hasZero();
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
}

final class Main {
    public static void main(String[] args) {
        // 5 + 10 + (-3)
        Exp e = new Add(new Int(5), new Add(new Int(10), new Negate(new Int(3))));
        System.out.println("Does e have a zero? " + e.hasZero());
        System.out.println(e.toString() + " = " + e.eval().toString());
    }
}
