// Programming Languages
// Lecture 10: Pointers

package main

import "fmt"

func main() {
	var someNumber int = 10

	// Pointer declaration (Similar to C/C++)
	var somePointer *int = &someNumber

	fmt.Println(&someNumber, somePointer)
	fmt.Println(someNumber, *somePointer)

	// Pointer assignment (similar to dereferencing in C/C++)
	*somePointer = 20
	fmt.Println(someNumber, *somePointer)

	// Null pointer
	var nullPointer *int
	fmt.Println(nullPointer)

	// Dynamic memory allocation
	anotherPointer := new(int)
	fmt.Println("New pointer address", anotherPointer)
	fmt.Println("New pointer value", *anotherPointer)
	*anotherPointer = 30
	fmt.Println("Assigned pointer value", *anotherPointer)
	
	// Dynamic memory deallocation
	// Go has a garbage collector
}