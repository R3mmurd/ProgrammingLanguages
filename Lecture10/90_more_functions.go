// Programming Languages
// Lecture 10: More Functions

package main

import "fmt"

// Variadic Parameters
func sum(nums ...int) int {
	total := 0
	for _, num := range nums {
		total += num
	}
	return total
}

// Named Return Values
func add(a, b int) (result int) {
	result = a + b
	return
}

func main() {
	fmt.Println(sum())
	fmt.Println(sum(1))
	fmt.Println(sum(1, 2))
	fmt.Println(sum(1, 2, 3, 4, 5))
	fmt.Println(add(1, 2))

	// Anonymous Functions
	func() {
		fmt.Println("Anonymous function")
	}()

	// Function as a Variable
	f := func() {
		fmt.Println("Function as a variable")
	}

	f()
}