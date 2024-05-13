// Programming Languages
// Lecture 10: Slices

package main

import "fmt"

func main() {
	// Slice
	xs := []int{1, 2, 3, 4, 5}
	fmt.Println(xs)

	// Append values
	xs = append(xs, 6, 7, 8)
	fmt.Println(xs)

	// Append slice
	ys := []int{9, 10, 11}
	xs = append(xs, ys...)
	fmt.Println(xs)

	// Delete values {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11} -> {1, 2, 3, 7, 8, 9, 10, 11}
	xs = append(xs[:3], xs[6:]...)
	fmt.Println(xs)

	// Cap and Len
	fmt.Println(len(xs), cap(xs))

	// Creating slices using make
	states := make([]string, 10, 500)
	states = append(states, "Mérida", "Táchira", "Trujillo", "Lara")
	fmt.Println(states)
	fmt.Println(len(states), cap(states))

	for i, value := range states {
		fmt.Println(i, value)
	}

	// Slice 2D
	ss1 := []string{"a", "b", "c"}
	ss2 := []string{"d", "e", "f"}
	sss := [][]string{ss1, ss2}
	fmt.Println(sss)

	for i, ss := range sss {
		fmt.Println(i, ss)

		for j, s := range ss {
			fmt.Println(j, s)
		}
	}
}