// Programming Languages
// Lecture 10: Interfaces

package main

import "fmt"

// Methods
type myInt int

func (x myInt) add(y myInt) myInt {
	return x + y
}

// Interfaces
type animal interface {
	speak() string
	travel() string
}

type dog struct {
	name string
}

type cat struct {
	name string
}

func (d dog) speak() string {
	return "Woof"
}

func (d dog) travel() string {
	return "Walk"
}

func (c cat) speak() string {
	return "Meow"
}

func (c cat) travel() string {
	return "Run"
}

func main() {
	var x myInt = 10
	var y myInt = 20
	fmt.Println(x.add(y))

	animals := []animal{dog{"Rover"}, cat{"Whiskers"}}
	for _, a := range animals {
		fmt.Println(a.speak(), a.travel())
	}
}