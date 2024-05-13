// Programming Languages
// Lecture 10: Functions

package main

import "fmt"

// Function declaration
func fibonacci(n int) int {
	f0, f1 := 0, 1

	for i := 0; i < n; i++ {
		f0, f1 = f1, f0 + f1
	}

	return f0
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a % b
	}

	return a 
}

func main() {
	// Function call
	fmt.Println(fibonacci(10))
	fmt.Println(gcd(10, 15))
}