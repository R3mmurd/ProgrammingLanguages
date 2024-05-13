#include <iostream>
#include <string>

template <typename UserClass>
class Doubler
{
public:
    const UserClass& self() const noexcept
    {
        return static_cast<const UserClass&>(*this);
    }

    UserClass& self() noexcept
    {
        return static_cast<UserClass&>(*this);
    }

    UserClass double_value() const noexcept
    {
        return self() + self();
    }
};

class Point2D: public Doubler<Point2D>
{
public:
    Point2D(int _x, int _y) noexcept
        : x{_x}, y{_y}
    {
        // Empty
    }

    Point2D operator + (const Point2D& other) const noexcept
    {
        return Point2D{x + other.x, y + other.y};
    }

    friend std::ostream& operator << (std::ostream& os, const Point2D& p) noexcept
    {
        return os << "(" << p.x << ", " << p.y << ")";
    }

private:
    int x;
    int y;
};

int main()
{
    Point2D p1{1, 2};

    std::cout << p1 << std::endl;
    std::cout << p1.double_value() << std::endl;

    return EXIT_SUCCESS;   
}