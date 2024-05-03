// Programing Language
// Lecture 10: Expressions

package main

import (
	"fmt"
	"strconv"
)

type expr interface {
	eval() value
	toString() string
	hasZero() bool
	noNegConstants() expr
}

type value interface {
	expr
	addValue(other value) value
	addInt(other myInt) value
	addString(other myString) value
	addRational(other myRational) value
}

//////////////////////////////////////////
// myInt definition
//////////////////////////////////////////
type myInt struct {
	value int
}

func (e myInt) eval() value {
	return e
}

func (e myInt) toString() string {
	return strconv.Itoa(e.value)
}

func (e myInt) hasZero() bool {
	return e.value == 0
}

func (e myInt) noNegConstants() expr {
	if e.value < 0 {
		return negate{myInt{-e.value}}
	}
	return e
}

func (e myInt) addValue(other value) value {
	return other.addInt(e)
}

func (e myInt) addInt(other myInt) value {
	return myInt{e.value + other.value}
}

func (e myInt) addString(other myString) value {
	return myString{other.value + strconv.Itoa(e.value)}
}

func (e myInt) addRational(other myRational) value {
	return myRational{other.numerator + e.value * other.denominator, other.denominator}
}
//////////////////////////////////////////
// end of myInt definition
//////////////////////////////////////////

//////////////////////////////////////////
// myString definition
//////////////////////////////////////////
type myString struct {
	value string
}

func (e myString) eval() value {
	return e
}

func (e myString) toString() string {
	return "\"" + e.value + "\""
}

func (e myString) hasZero() bool {
	return false
}

func (e myString) noNegConstants() expr {
	return e
}

func (e myString) addValue(other value) value {
	return other.addString(e)
}

func (e myString) addInt(other myInt) value {
	return myString{strconv.Itoa(other.value) + e.value}
}

func (e myString) addString(other myString) value {
	return myString{other.value + e.value}
}

func (e myString) addRational(other myRational) value {
	return myString{strconv.Itoa(other.numerator) + "/" + strconv.Itoa(other.denominator) + e.value}
}
//////////////////////////////////////////
// end of myString definition
//////////////////////////////////////////

//////////////////////////////////////////
// myRational definition
//////////////////////////////////////////
type myRational struct {
	numerator int
	denominator int
}

func (e myRational) eval() value {
	return e
}

func (e myRational) toString() string {
	return strconv.Itoa(e.numerator) + "/" + strconv.Itoa(e.denominator)
}

func (e myRational) hasZero() bool {
	return e.numerator == 0
}

func (e myRational) noNegConstants() expr {
	if e.numerator < 0 && e.denominator < 0 {
		return myRational{-e.numerator, -e.denominator}
	} else if e.numerator < 0 {
		return negate{myRational{-e.numerator, e.denominator}}
	} else if e.denominator < 0 {
		return negate{myRational{e.numerator, -e.denominator}}
	} else {
		return e
	}
	return e
}

func (e myRational) addValue(other value) value {
	return other.addRational(e)
}

func (e myRational) addInt(other myInt) value {
	return other.addRational(e) // reuse addRational from int because it is commutative
}

func (e myRational) addString(other myString) value {
	return myString{other.value + strconv.Itoa(e.numerator) + "/" + strconv.Itoa(e.denominator)}
}

func (e myRational) addRational(other myRational) value {
	return myRational{e.numerator * other.denominator + other.numerator * e.denominator, e.denominator * other.denominator}
}
//////////////////////////////////////////
// end of myRational definition
//////////////////////////////////////////

//////////////////////////////////////////
// negate definition
//////////////////////////////////////////
type negate struct {
	inner expr
}

func (e negate) eval() value {
	return myInt{-e.inner.eval().(myInt).value}
}

func (e negate) toString() string {
	return "-(" + e.inner.toString() + ")"
}

func (e negate) hasZero() bool {
	return e.inner.hasZero()
}

func (e negate) noNegConstants() expr {
	return negate{e.inner.noNegConstants()}
}
//////////////////////////////////////////
// end of negate definition
//////////////////////////////////////////

//////////////////////////////////////////
// add definition
//////////////////////////////////////////
type add struct {
	left expr
	right expr
}

func (e add) eval() value {
	return e.left.eval().addValue(e.right.eval())
}

func (e add) toString() string {
	return "(" + e.left.toString() + " + " + e.right.toString() + ")"
}

func (e add) hasZero() bool {
	return e.left.hasZero() || e.right.hasZero()
}

func (e add) noNegConstants() expr {
	return add{e.left.noNegConstants(), e.right.noNegConstants()}
}
//////////////////////////////////////////
// end of add definition
//////////////////////////////////////////

func main() {
	// 3 + 4
	e1 := add{myInt{3}, myInt{4}}
	fmt.Printf("%s = %s\n", e1.toString(), e1.eval().toString())

	// 3 + 4 + 5
	e2 := add{add{myInt{3}, myInt{4}}, myInt{5}}
	fmt.Printf("%s = %s\n", e2.toString(), e2.eval().toString())
	
	// 3 + 4 - 5
	e3 := add{add{myInt{3}, myInt{4}}, negate{myInt{5}}}
	fmt.Printf("%s = %s\n", e3.toString(), e3.eval().toString())
	
	// 3 + 4 - 5
	e4 := add{add{myInt{3}, myInt{4}}, myInt{-5}}.noNegConstants()
	fmt.Printf("%s = %s\n", e4.toString(), e4.eval().toString())

	// "Hello " + 4
	e5 := add{myString{"Hello "}, myInt{4}}
	fmt.Printf("%s = %s\n", e5.toString(), e5.eval().toString())

	// 3 + " World"
	e6 := add{myInt{3}, myString{" World"}}
	fmt.Printf("%s = %s\n", e6.toString(), e6.eval().toString())

	// 3 + 4/5
	e7 := add{myInt{3}, myRational{4, 5}}
	fmt.Printf("%s = %s\n", e7.toString(), e7.eval().toString())

	// 4/5 + 3
	e8 := add{myRational{4, 5}, myInt{3}}
	fmt.Printf("%s = %s\n", e8.toString(), e8.eval().toString())
	
	// "Hello " + 4/5
	e9 := add{myString{"Hello "}, myRational{4, 5}}
	fmt.Printf("%s = %s\n", e9.toString(), e9.eval().toString())

	// 4/5 + " World"
	e10 := add{myRational{4, 5}, myString{" World"}}
	fmt.Printf("%s = %s\n", e10.toString(), e10.eval().toString())

	// 3/4 + 4/5
	e11 := add{myRational{3, 4}, myRational{4, 5}}
	fmt.Printf("%s = %s\n", e11.toString(), e11.eval().toString())
}
