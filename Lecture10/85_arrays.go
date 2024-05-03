// Programming Languages
// Lecture 10: Arrays

package main

import "fmt"

func main() {
	// Array declaration
	var someArray [5]int
	fmt.Println(someArray)

	// Array initialization
	someArray = [5]int{1, 2, 3, 4, 5}
	fmt.Println(someArray)

	// Array declaration and initialization
	anotherArray := [5]int{6, 7, 8, 9, 10}
	fmt.Println(anotherArray)

	// Array length
	fmt.Println(len(someArray))

	// Array iteration
	for i := 0; i < len(someArray); i++ {
		fmt.Println(someArray[i])
	}

	// Array iteration using range
	for i, value := range someArray {
		fmt.Println(i, value)
	}

	// Array assignment
	someArray = anotherArray // Copy by value
	fmt.Println(someArray, anotherArray)

	anotherArray[0] = 100
	fmt.Println(someArray, anotherArray)

	// Slicing
	fmt.Println(someArray[1:3]) // [7, 8]
	fmt.Println(someArray[:3])  // [6, 7, 8]
	fmt.Println(someArray[3:])  // [9, 10]
}