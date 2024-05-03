// Programming Languages
// Lecture 10: Types

package main

import "fmt"

// Custom type declaration
type day int
type month int
type year int

const (
	January month = 1 + iota
	February
	March
	April
	May
	June
	July
	August
	September
	October
	November
	December
)

func main() {
	// Custom type declaration
	var d day = 4
	var m month = May
	var y year = 2024

	fmt.Println(d, m, y)
}