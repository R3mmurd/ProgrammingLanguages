#include <Logic.hpp>

using namespace std::literals;

bool is_parenthesis_balance(std::string_view sv) noexcept
{
    size_t count = 0;

    for (char c : sv)
    {
        if (c == '(')
        {
            ++count;
        }
        else if (c == ')')
        {
            if (count == 0)
            {
                return false;
            }

            --count;
        }
    }

    return count == 0;
}

bool isalpha(std::string_view sv)
{
    for (char c : sv)
    {
        if (!std::isalpha(c))
        {
            return false;
        }
    }

    return true;
}

std::string parenthesize(std::string_view sv) noexcept
{
    if (sv.empty() || isalpha(sv) || (sv[0] == '(' && sv[sv.size() - 1] == ')' && is_parenthesis_balance(sv.substr(1, sv.size() - 2))))
    {
        return std::string{sv};
    }

    return "("s + std::string{sv} + ")"s;
}

Proposition::~Proposition() {}

Variable::Variable(std::string_view sv_name) noexcept : name{sv_name} {}

PropositionPtr Variable::create(std::string_view sv_name) noexcept
{
    return std::make_shared<Variable>(sv_name);
}

bool Variable::evaluate(const ModelTable& model)
{
    auto it = model.find(name);

    if (it == model.end())
    {
        std::string error_message = "Variable "s + name + " not in model"s;
        throw std::logic_error{error_message};
    }

    return it->second;
}

std::string Variable::to_string() const noexcept
{
    return name;
}

VariableSet Variable::variables() const noexcept
{
    return VariableSet{{name}};
}

Not::Not(PropositionPtr _operand) noexcept : operand{_operand} {}

PropositionPtr Not::create(PropositionPtr operand) noexcept
{
    return std::make_shared<Not>(operand);
}

bool Not::evaluate(const ModelTable& model)
{
    return !operand->evaluate(model);
}

std::string Not::to_string() const noexcept
{
    return "¬"s + parenthesize(operand->to_string());
}

VariableSet Not::variables() const noexcept
{
    return operand->variables();
}

And::And(std::vector<PropositionPtr>&& _conjunts) noexcept
    : conjuncts{std::forward<std::vector<PropositionPtr>>(_conjunts)} {}

PropositionPtr And::create(std::initializer_list<PropositionPtr> Propositions) noexcept
{
    std::vector<PropositionPtr> conjuncts{Propositions.begin(), Propositions.end()};
    return std::make_shared<And>(std::move(conjuncts));
}

bool And::evaluate(const ModelTable& model)
{
    return std::all_of(conjuncts.begin(), conjuncts.end(), [&model](PropositionPtr s)
                       { return s->evaluate(model); });
}

std::string And::to_string() const noexcept
{
    if (conjuncts.empty())
    {
        return "";
    }

    auto it = conjuncts.begin();
    std::string result = parenthesize((*it)->to_string());
    ++it;

    for (; it != conjuncts.end(); ++it)
    {
        result += " ^ "s + parenthesize((*it)->to_string());
    }

    return result;
}

VariableSet And::variables() const noexcept
{
    VariableSet result;

    for (PropositionPtr conjunct : conjuncts)
    {
        VariableSet joined;
        VariableSet current_variables = conjunct->variables();
        std::set_union(result.begin(), result.end(),
                       current_variables.begin(), current_variables.end(),
                       std::inserter(joined, joined.begin()));
        std::swap(joined, result);
    }

    return result;
}

Or::Or(std::vector<PropositionPtr>&& _disjuncts) noexcept
    : disjuncts{std::forward<std::vector<PropositionPtr>>(_disjuncts)} {}

PropositionPtr Or::create(std::initializer_list<PropositionPtr> Propositions) noexcept
{
    std::vector<PropositionPtr> disjuncts{Propositions.begin(), Propositions.end()};
    return std::make_shared<Or>(std::move(disjuncts));
}

bool Or::evaluate(const ModelTable& model)
{
    return std::any_of(disjuncts.begin(), disjuncts.end(), [&model](PropositionPtr s)
                       { return s->evaluate(model); });
}

std::string Or::to_string() const noexcept
{
    if (disjuncts.empty())
    {
        return "";
    }

    auto it = disjuncts.begin();
    std::string result = parenthesize((*it)->to_string());
    ++it;

    for (; it != disjuncts.end(); ++it)
    {
        result += " v "s + parenthesize((*it)->to_string());
    }

    return result;
}

VariableSet Or::variables() const noexcept
{
    VariableSet result;

    for (PropositionPtr disjunct : disjuncts)
    {
        VariableSet joined;
        VariableSet current_variables = disjunct->variables();
        std::set_union(result.begin(), result.end(),
                       current_variables.begin(), current_variables.end(),
                       std::inserter(joined, joined.begin()));
        std::swap(joined, result);
    }

    return result;
}

Implication::Implication(PropositionPtr _antecedent, PropositionPtr _consequent) noexcept
    : antecedent{_antecedent}, consequent{_consequent} {}

PropositionPtr Implication::create(PropositionPtr antecedent, PropositionPtr consequent) noexcept
{
    return std::make_shared<Implication>(antecedent, consequent);
}

bool Implication::evaluate(const ModelTable& model)
{
    bool ant = antecedent->evaluate(model);
    bool con = consequent->evaluate(model);
    return !ant || con;
}

std::string Implication::to_string() const noexcept
{
    std::string ant = parenthesize(antecedent->to_string());
    std::string con = parenthesize(consequent->to_string());
    return ant + " => " + con;
}

VariableSet Implication::variables() const noexcept
{
    VariableSet result;
    VariableSet ant_variables = antecedent->variables();
    VariableSet con_variables = consequent->variables();

    std::set_union(ant_variables.begin(), ant_variables.end(),
                   con_variables.begin(), con_variables.end(),
                   std::inserter(result, result.begin()));

    return result;
}

Biconditional::Biconditional(PropositionPtr _left, PropositionPtr _right) noexcept
    : left{_left}, right{_right} {}

PropositionPtr Biconditional::create(PropositionPtr left, PropositionPtr right) noexcept
{
    return std::make_shared<Biconditional>(left, right);
}

bool Biconditional::evaluate(const ModelTable& model)
{
    bool l = left->evaluate(model);
    bool r = right->evaluate(model);
    return (l && r) || (!l && !r);
}

std::string Biconditional::to_string() const noexcept
{
    std::string l = parenthesize(left->to_string());
    std::string r = parenthesize(right->to_string());
    return l + " <=> " + r;
}

VariableSet Biconditional::variables() const noexcept
{
    VariableSet result;
    VariableSet l_variables = left->variables();
    VariableSet r_variables = right->variables();

    std::set_union(l_variables.begin(), l_variables.end(),
                   r_variables.begin(), r_variables.end(),
                   std::inserter(result, result.begin()));

    return result;
}

bool check_all(PropositionPtr knowledge, PropositionPtr query, const VariableSet& variables, const ModelTable& model) noexcept
{
    if (variables.empty())
    {
        if (knowledge->evaluate(model))
        {
            return query->evaluate(model);
        }

        return true;
    }

    auto remaining = variables;
    auto it = remaining.begin();
    auto p = *it;
    remaining.erase(it);

    ModelTable model_true = model;
    model_true[p] = true;

    ModelTable model_false = model;
    model_false[p] = false;

    return check_all(knowledge, query, remaining, model_true) &&
           check_all(knowledge, query, remaining, model_false);
}

bool check_model(PropositionPtr knowledge, PropositionPtr query) noexcept
{
    VariableSet variables;
    VariableSet k_variables = knowledge->variables();
    VariableSet q_variables = query->variables();
    std::set_union(k_variables.begin(), k_variables.end(),
                   q_variables.begin(), q_variables.end(),
                   std::inserter(variables, variables.begin()));

    ModelTable model;
    return check_all(knowledge, query, variables, model);
}
