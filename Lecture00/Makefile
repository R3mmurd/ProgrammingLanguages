CXX = clang++ -std=c++17
WARN        = -Wall -Wextra -Wcast-align -Wno-sign-compare -Wno-write-strings -Wno-parentheses -Wfloat-equal -pedantic
FLAGS       = -DDEBUG -g -O0

all: KnightsAndKnaves

KnightsAndKnaves: KnightsAndKnaves.cpp Logic.o
	$(CXX) $(FLAGS) -I. $< -o $@ Logic.o

Logic.o: Logic.hpp Logic.cpp
	$(CXX) $(FLAGS) -I. -c Logic.cpp

.PHONY:
clean:
	$(RM) Logic.o KnightsAndKnaves