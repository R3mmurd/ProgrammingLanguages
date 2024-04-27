#include <iostream>

class Animal
{
public:
    virtual void eat() const noexcept = 0;
    virtual void travel() const noexcept = 0;
};


class Bird: public Animal
{
public:
    void eat() const noexcept override
    {
        std::cout << "Bird eats" << std::endl;
    }

    void travel() const noexcept override
    {
        std::cout << "Bird flies" << std::endl;
    }
};

class Cat : public Animal
{
public:
    void eat() const noexcept override
    {
        std::cout << "Cat eats" << std::endl;
    }

    void travel() const noexcept override
    {
        std::cout << "Cat walks" << std::endl;
    }
};

void print_animal_behaviour(const Animal& a)
{
    a.eat();
    a.travel();
}

int main()
{
    Bird b;
    print_animal_behaviour(b);

    Cat c;
    print_animal_behaviour(c);    

    return EXIT_SUCCESS;
}