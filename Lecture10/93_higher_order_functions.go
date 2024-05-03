// Programming Languages
// Lecture 10: Higher-Order Functions

package main

import "fmt"

// Higher-Order Functions
func apply(f func(int, int) int, a, b int) int {
	return f(a, b)
}

func add(a, b int) int {
	return a + b
}

func subtract(a, b int) int {
	return a - b
}

// Returning Functions
func createGreeting() func(string) string {
	return func(name string) string {
		return "Hello, " + name
	}
}

// Closure
func createFibonacciGenerator() func() int {
	a, b := 0, 1
	return func() int {
		result := a
		a, b = b, a + b
		return result
	}
}

func main() {
	fmt.Println(apply(add, 1, 2))
	fmt.Println(apply(subtract, 1, 2))

	greet := createGreeting()
	fmt.Println(greet("Gophers"))

	fibonacciGenerator := createFibonacciGenerator()

	for i := 0; i < 10; i++ {
		fmt.Println(fibonacciGenerator())
	}
}