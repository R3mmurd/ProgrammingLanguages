interface Animal {
    void eat();
    void travel();
}

class Bird implements Animal{
    @Override
    public void eat() {
        System.out.println("Bird eats");
    }

    @Override
    public void travel() {
        System.out.println("Bird flies");
    }
}

class Cat implements Animal {
    @Override
    public void eat() {
        System.out.println("Cat eats");
    }

    @Override
    public void travel() {
        System.out.println("Cat walks");
    }
}

final class Main {

    static void printAnimalBehavior(Animal a) {
        a.eat();
        a.travel();
    }
    public static void main(String[] args) {
        Bird b = new Bird();
        printAnimalBehavior(b);

        Cat c = new Cat();
        printAnimalBehavior(c);
    
    }
}