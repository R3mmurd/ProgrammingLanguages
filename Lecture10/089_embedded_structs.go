// Programming Languages
// Lecture 10: Embedded Structs

package main

import "fmt"

type day int8
type month int8
type year int16

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

type date struct {
	d day
	m month
	y year
}

type person struct {
	firstName string
	lastName string
	dob date
}

type universityRecord struct {
	student person
	department string
	startDate date
}

// Embeddeding structs without names, similar to inheritance in OOP
type commonData struct {
	firstName string
	lastName string
	dob date
	department string
	startDate date
}

type student struct {
	commonData
	avgGrade float64
}

type staff struct {
	commonData
	salary float64
}

func main() {
	records := []universityRecord{
		{
			student: person{
				firstName: "John",
				lastName: "Petrucci",
				dob: date{
					d: 12,
					m: February,
					y: 1967,
				},
			},
			department: "Computer Science",
			startDate: date{
				d: 1,
				m: September,
				y: 1985,
			},
		},
		{
			student: person{
				firstName: "Jordan",
				lastName: "Rudess",
				dob: date{
					d: 4,
					m: November,
					y: 1956,
				},
			},
			department: "Music",
			startDate: date{
				d: 1,
				m: September,
				y: 1985,
			},
		},
	}

	for _, record := range records {
		fmt.Println(record.student.firstName, record.student.lastName, record.student.dob, record.department, record.startDate)
	}

	student1 := student{
		commonData: commonData{
			firstName: "James",
			lastName: "LaBrie",
			dob: date{
				d: 5,
				m: May,
				y: 1963,
			},
			department: "Music",
			startDate: date{
				d: 1,
				m: September,
				y: 1985,
			},
		},
		avgGrade: 90,
	}

	fmt.Println(student1.firstName)
	fmt.Println(student1)

	staff1 := staff{}
	staff1.firstName = "John"
	staff1.lastName = "Myung"
	staff1.dob = date{
		d: 24,
		m: January,
		y: 1967,
	}
	staff1.department = "Music"
	staff1.startDate = date{
		d: 1,
		m: September,
		y: 1985,
	}
	staff1.salary = 100000.0

	fmt.Println(staff1)
}
