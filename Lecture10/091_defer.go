// Programming Languages
// Lecture 10: Defer

package main

import "fmt"

func main() {
	exec(true, 1)
	exec(false, 2)
}

func exec(err bool, i int) {
	fmt.Println("Start exec", i)
	defer secureExit(i)

	if err {
		fmt.Println("Error")
		return
	}

	fmt.Println("End exec", i)
}

func secureExit(id int) {
	fmt.Println("Secure exit", id)
}