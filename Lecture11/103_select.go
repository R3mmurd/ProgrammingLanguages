// Programming Languages
// Lecture 11: Select

package main

import (
	"fmt"
	"time"
)

func main() {
	c1 := make(chan string)
	c2 := make(chan string)

	go func(ch1 chan string) {
		for i := 0; i < 10; i++ {
			ch1 <- "from 1"
			time.Sleep(time.Second * 2)
		}
		close(ch1)
	}(c1)

	go func(ch2 chan string) {
		for i := 0; i < 10; i++ {
			ch2 <- "from 2"
			time.Sleep(time.Second * 3)
		}
		close(ch2)
	}(c2)

	for {
		select {
			case msg1 := <-c1:
				fmt.Println(msg1)
			case msg2 := <-c2:
				fmt.Println(msg2)
		}
	}
}