// Programming Languages
// Lecture 10: Variables and Constants

package main

import "fmt"

func main() {
	// Print function
	fmt.Println("Hello, Gophers!")

	// Variable declaration
	var someName string = "Axl"
	someAge := 22

	// Print variables
	fmt.Println(someName, someAge)

	// Print formatted string
	fmt.Printf("An approximation of pi is %f\n", pi)
	fmt.Printf("%s is %d years old!\n", someName, someAge)

	// Variable group
	var (
		name string = "Slash"
		age  int    = 23
	)

	fmt.Printf("%s is %d years old!\n", name, age)

	// Tuple assignment
	x, y := 10, 20
	fmt.Println(x, y)
	x, y = y, x
	fmt.Println(x, y)

	// Constant declaration
	const pi float64 = 3.14159265359

	// Constant group
	const (
		absoluteZeroCelsius float64 = -273.15
		freezingCelsius     float64 = 0
		boilingCelsius      float64 = 100
	)

	fmt.Println(absoluteZeroCelsius, freezingCelsius, boilingCelsius)	
}