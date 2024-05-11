// Programing Language
// Lecture 11: Goroutines

package main

import "fmt"

func main() {
	// Goroutine is a lightweight thread of execution
	go f(0)

	fmt.Println("Hello from main")

	fmt.Scanln()
}

func f(id int) {
	for i := 0; i < 10; i++ {
		fmt.Println(id, ":", i)
	}
}