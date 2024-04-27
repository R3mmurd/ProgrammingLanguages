// Programming Languages
// Lecture 09: Adding Operations or Variants

#include <iostream>
#include <memory>
#include <string>

class Value;

class Exp
{
public:
    virtual std::shared_ptr<Value> eval() noexcept = 0;

    virtual std::string to_string() const noexcept = 0;

    virtual bool has_zero() const noexcept = 0;

    virtual std::shared_ptr<Exp> no_neg_constants() noexcept = 0;
};

class Value: public Exp
{

};

class Int: public Value
{
public:
    Int(int _i) noexcept
        : i{_i}
    {
        // Empty
    }

    std::shared_ptr<Value> eval() noexcept override
    {
        return std::make_shared<Int>(i);
    }

    std::string to_string() const noexcept override
    {
        return std::to_string(i);
    }

    bool has_zero() const noexcept override
    {
        return i == 0;
    }

    std::shared_ptr<Exp> no_neg_constants() noexcept override;

public:
    int i;
};

class Negate: public Exp
{
public:
    Negate(std::shared_ptr<Exp> _e) noexcept
        : e{_e}
    {
        // Empty
    }

    std::shared_ptr<Value> eval() noexcept override
    {
        return std::make_shared<Int>(-std::dynamic_pointer_cast<Int>(e->eval())->i);
    }

    std::string to_string() const noexcept override
    {
        return "-(" + e->to_string() + ")";
    }

    bool has_zero() const noexcept override
    {
        return e->has_zero();
    }

    std::shared_ptr<Exp> no_neg_constants() noexcept override
    {
        return std::make_shared<Negate>(e->no_neg_constants());
    }

private:
    std::shared_ptr<Exp> e;
};

std::shared_ptr<Exp> Int::no_neg_constants() noexcept
{
    if (i < 0)
    {
        return std::make_shared<Negate>(std::make_shared<Int>(-i));
    }
    else
    {
        return std::make_shared<Int>(i);
    }
}

class Add: public Exp
{
public:
    Add(std::shared_ptr<Exp> _e1, std::shared_ptr<Exp> _e2) noexcept
        : e1{_e1}, e2{_e2}
    {
        // Empty
    }

    std::shared_ptr<Value> eval() noexcept override
    {
        return std::make_shared<Int>(std::dynamic_pointer_cast<Int>(e1->eval())->i + std::dynamic_pointer_cast<Int>(e2->eval())->i);
    }

    std::string to_string() const noexcept override
    {
        return "(" + e1->to_string() + " + " + e2->to_string() + ")";
    }

    bool has_zero() const noexcept override
    {
        return e1->has_zero() || e2->has_zero();
    }

    std::shared_ptr<Exp> no_neg_constants() noexcept override
    {
        return std::make_shared<Add>(e1->no_neg_constants(), e2->no_neg_constants());
    }

private:
    std::shared_ptr<Exp> e1;
    std::shared_ptr<Exp> e2;
};

class Mult: public Exp
{
public:
    Mult(std::shared_ptr<Exp> _e1, std::shared_ptr<Exp> _e2) noexcept
        : e1{_e1}, e2{_e2}
    {
        // Empty
    }

    std::shared_ptr<Value> eval() noexcept override
    {
        return std::make_shared<Int>(std::dynamic_pointer_cast<Int>(e1->eval())->i * std::dynamic_pointer_cast<Int>(e2->eval())->i);
    }

    std::string to_string() const noexcept override
    {
        return "(" + e1->to_string() + " * " + e2->to_string() + ")";
    }

    bool has_zero() const noexcept override
    {
        return e1->has_zero() || e2->has_zero();
    }

    std::shared_ptr<Exp> no_neg_constants() noexcept override
    {
        return std::make_shared<Mult>(e1->no_neg_constants(), e2->no_neg_constants());
    }

private:
    std::shared_ptr<Exp> e1;
    std::shared_ptr<Exp> e2;
};

int main()
{
    // 5 + 10 * -3)
    auto e = std::make_shared<Add>(
        std::make_shared<Int>(5),
        std::make_shared<Mult>(
            std::make_shared<Int>(10),
            std::make_shared<Negate>(std::make_shared<Int>(3))
        )
    );

    std::cout << std::boolalpha;
    std::cout << "Does e have zero? " << e->has_zero() << "\n";
    std::cout << e->to_string() << " = " << e->eval()->to_string() << "\n";

    // 5 + 10 * (-3)
    auto e2 = std::make_shared<Add>(
        std::make_shared<Int>(5),
        std::make_shared<Mult>(
            std::make_shared<Int>(10),
            std::make_shared<Int>(-3)
        )
    )->no_neg_constants();

    std::cout << "Does e2 have zero? " << e2->has_zero() << "\n";
    std::cout << e2->to_string() << " = " << e2->eval()->to_string() << "\n";

    return EXIT_SUCCESS;
}