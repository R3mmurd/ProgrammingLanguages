// Programming Languages
// Lecture 10: Maps

package main

import "fmt"

func main() {
	var someMap map[string]int = make(map[string]int)
	someMap["one"] = 1
	someMap["two"] = 2
	someMap["three"] = 3

	fmt.Println(someMap)

	otherMap := map[string]int{
		"four": 4,
		"five": 5,
		"six": 6,
	}

	fmt.Println(otherMap)

	programmingLanguageCreators := map[string]string{
		"Python": "Guido van Rossum",
		"Java": "James Gosling",
		"C": "Dennis Ritchie",
		"Go": "Robert Griesemer",
		"C++": "Bjarne Stroustrup",
		"Ruby": "Yukihiro Matsumoto",
		"SML": "Robin Milner",
		"Kotlin": "JetBrains",
	}

	fmt.Println(programmingLanguageCreators)

	fmt.Println()

	for key, value := range programmingLanguageCreators {
		fmt.Printf("%s was created by %s\n", key, value)
	}

	// Map add
	programmingLanguageCreators["Rust"] = "Graydon Hoare"

	fmt.Println()
	for key, value := range programmingLanguageCreators {
		fmt.Printf("%s was created by %s\n", key, value)
	}

	// Map delete
	delete(programmingLanguageCreators, "SML")
	delete(programmingLanguageCreators, "JavaScript") // No error

	fmt.Println()
	for key, value := range programmingLanguageCreators {
		fmt.Printf("%s was created by %s\n", key, value)
	}
}
		