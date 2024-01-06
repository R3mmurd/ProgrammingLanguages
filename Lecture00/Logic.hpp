#pragma once

#include <algorithm>
#include <memory>
#include <stdexcept>
#include <string>
#include <string_view>
#include <unordered_map>
#include <unordered_set>
#include <vector>

std::string parenthesize(std::string_view sv) noexcept;

class Proposition;

using PropositionPtr = std::shared_ptr<Proposition>;

using VariableSet = std::unordered_set<std::string>;

using ModelTable = std::unordered_map<std::string, bool>;

class Proposition
{
public:
    virtual ~Proposition();

    virtual bool evaluate(const ModelTable& model) = 0;

    virtual std::string to_string() const noexcept = 0;

    virtual VariableSet variables() const noexcept = 0;
};

class Variable : public Proposition
{
public:
    Variable(std::string_view sv_name) noexcept;

    static PropositionPtr create(std::string_view sv_name) noexcept;

    bool evaluate(const ModelTable& model) override;

    std::string to_string() const noexcept override;

    VariableSet variables() const noexcept override;

private:
    std::string name;
};

class Not : public Proposition
{
public:
    Not(PropositionPtr _operand) noexcept;

    static PropositionPtr create(PropositionPtr operand) noexcept;

    bool evaluate(const ModelTable& model) override;

    std::string to_string() const noexcept override;

    VariableSet variables() const noexcept override;

private:
    PropositionPtr operand;
};

class And : public Proposition
{
public:
    And(std::vector<PropositionPtr>&& _conjuncts) noexcept;

    static PropositionPtr create(std::initializer_list<PropositionPtr> Propositions) noexcept;

    bool evaluate(const ModelTable& model) override;

    std::string to_string() const noexcept override;

    VariableSet variables() const noexcept override;
    
private:
    std::vector<PropositionPtr> conjuncts;
};

class Or : public Proposition
{
public:
    Or(std::vector<PropositionPtr>&& _disjuncts) noexcept;

    static PropositionPtr create(std::initializer_list<PropositionPtr> Propositions) noexcept;

    bool evaluate(const ModelTable& model) override;

    std::string to_string() const noexcept override;

    VariableSet variables() const noexcept override;
    
private:
    std::vector<PropositionPtr> disjuncts;
};

class Implication : public Proposition
{
public:
    Implication(PropositionPtr _antecedent, PropositionPtr _consequent) noexcept;

    static PropositionPtr create(PropositionPtr antecedent, PropositionPtr consequent) noexcept;

    bool evaluate(const ModelTable& model) override;

    std::string to_string() const noexcept override;

    VariableSet variables() const noexcept override;

private:
    PropositionPtr antecedent;
    PropositionPtr consequent;
};

class Biconditional : public Proposition
{
public:
    Biconditional(PropositionPtr _left, PropositionPtr _right) noexcept;

    static PropositionPtr create(PropositionPtr left, PropositionPtr right) noexcept;

    bool evaluate(const ModelTable& model) override;

    std::string to_string() const noexcept override;

    VariableSet variables() const noexcept override;

private:
    PropositionPtr left;
    PropositionPtr right;
};

bool check_model(PropositionPtr knowledge, PropositionPtr query) noexcept;