/* 
    Programming Languages
    Lecture 06: Mutable references

    C++ code that implements almost the same thing
    in 43_mutable_references.sml
*/

#include <iostream>
#include <memory>

int main()
{
    auto x = std::make_shared<int>(42);
    auto y = std::make_shared<int>(42);
    auto z = x;

    *x = 43;

    auto w = *y + *z;

    std::cout << w << std::endl;

    return 0;
}