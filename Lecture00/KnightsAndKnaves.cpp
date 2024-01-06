#include <iostream>

#include <Logic.hpp>

int main()
{
    auto a_knight = Variable::create("A is a Knight");
    auto a_knave = Variable::create("A is a Knave");

    auto b_knight = Variable::create("B is a Knight");
    auto b_knave = Variable::create("B is a Knave");

    auto c_knight = Variable::create("C is a Knight");
    auto c_knave = Variable::create("C is a Knave");

    // Puzzle 1
    // A says "I am both a knight and a knave"
    auto knowledge1 = And::create({
        // A can be a Knight or a Knave but not both
        And::create({Or::create({a_knight, a_knave}), Not::create(And::create({a_knight, a_knave}))}),

        // A says "I am both a knight and a knave."
        Biconditional::create(a_knight, And::create({a_knight, a_knave}))
    });

    // Puzzle 2
    // A says "We are the same kind."
    // B says "We are of different kinds."
    auto knowledge2 = And::create({
        // A can be a Knight or a Knave but not both.
        And::create({Or::create({a_knight, a_knave}), Not::create(And::create({a_knight, a_knave}))}),

        // B can be a Knight or a Knave but not both.
        And::create({Or::create({b_knight, b_knave}), Not::create(And::create({b_knight, b_knave}))}),

        // A says "We are the same kind."
        Biconditional::create(a_knight, Biconditional::create(a_knight, b_knight)),

        // B says "We are of different kind."
        Biconditional::create(b_knight, Biconditional::create(a_knight, b_knave))
    });


    // Puzzle 3
    // A says either "I am a knight." or "I am a knave.", but you don't know which.
    // B says "A said 'I am a knave'."
    // B says "C is a knave."
    // C says "A is a knight."
    auto knowledge3 = And::create({
        // A can be a Knight or a Knave but not both.
        And::create({Or::create({a_knight, a_knave}), Not::create(And::create({a_knight, a_knave}))}),
        
        // B can be a Knight or a Knave but not both.
        And::create({Or::create({b_knight, b_knave}), Not::create(And::create({b_knight, b_knave}))}),
   
        // C can be a Knight or a Knave but not both.
        And::create({Or::create({c_knight, c_knave}), Not::create(And::create({c_knight, c_knave}))}),
    
        // A says either "I am a knight." or "I am a knave."
        Biconditional::create(a_knight, Or::create({a_knight, a_knave})),

        // B says "A said 'I am a knave'."
        Biconditional::create(b_knight, Biconditional::create(a_knight, a_knave)),
    
        // B says "C is a knave."
        Biconditional::create(b_knight, c_knave),

        // C says "A is a knight."
        Biconditional::create(c_knight, a_knight)
    });

    std::vector<PropositionPtr> variables{{a_knight, a_knave, b_knight, b_knave, c_knight, c_knave}};
    std::vector<PropositionPtr> puzzles{{knowledge1, knowledge2, knowledge3}};

    for (size_t i = 0; i < puzzles.size(); ++i)
    {
        std::cout << "Puzzle " << i + 1 << std::endl;

        for (auto variable : variables)
        {
            if (check_model(puzzles[i], variable))
            {
                std::cout << variable->to_string() << std::endl;
            }
        }
    }

    return EXIT_SUCCESS;
}
