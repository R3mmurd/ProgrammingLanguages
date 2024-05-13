// Programming Languages
// Lecture 10: Structs

package main

import "fmt"

// Struct declaration
type person struct {
	firstName string
	lastName string
	favoriteIceCreamFlavors []string
}

func main() {
	// Struct initialization
	p1 := person{
		firstName: "Simone",
		lastName: "Simmons",
		favoriteIceCreamFlavors: []string{"Chocolate", "Vanilla"},
	}

	p2 := person{
		firstName: "Floor",
		lastName: "Jansen",
		favoriteIceCreamFlavors: []string{"Strawberry", "Mint"},
	}

	fmt.Println(p1)
	fmt.Println(p2)

	// Map of structs
	m := map[string]person{
		p1.lastName: p1,
		p2.lastName: p2,
	}

	for _, p := range m {
		fmt.Println(p.firstName, p.lastName, p.favoriteIceCreamFlavors)
	}

	// Anonymous struct
	p3 := struct {
		name string
		favoriteDrinks []string
		currentSemesterGrades map[string]float64
	}{
		name: "Tarja Turunen",
		favoriteDrinks: []string{"Coffee", "Water"},
		currentSemesterGrades: map[string]float64{
			"Math": 90,
			"Physics": 85,
			"Chemistry": 80,
		},
	}

	fmt.Println(p3)
}