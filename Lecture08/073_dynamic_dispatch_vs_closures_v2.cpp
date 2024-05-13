#include <iostream>

class A
{
public:
    virtual bool even(int x) const // virtual keyword added to perform dynamic dispatch
    {
        std::cout << "Even in A\n";
        if (x == 0)
        {
            return true;
        }

        return odd(x - 1);
    }

    bool odd(int x) const
    {
        std::cout << "Odd in A\n";
        if (x == 0)
        {
            return false;
        }

        return even(x - 1);
    }
};

class B: public A
{
public:
    bool even(int x) const
    {
        std::cout << "Even in B\n";
        return x % 2 == 0;
    }
};

class C: public A
{
public:
    bool even(int x) const
    {
        std::cout << "Even in C\n";
        return false;
    }
};

int main()
{
    std::cout << std::boolalpha;

    bool a1 = A{}.odd(7);
    std::cout << "a1 is " << a1 << "\n\n";

    bool a2 = B{}.odd(7);
    std::cout << "a2 is " << a2 << "\n\n";

    bool a3 = C{}.odd(7);
    std::cout << "a3 is " << a3 << "\n\n";

    return EXIT_SUCCESS;
};