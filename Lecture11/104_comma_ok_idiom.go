// Programming Languages
// Lecture 11: Comma OK Idiom

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
			case msg1, ok := <-c1:
				if ok {
					fmt.Println(msg1)
				} else {
					fmt.Println("Channel 1 is closed")
					c1 = nil
				}
			case msg2, ok := <-c2:
				if ok {
					fmt.Println(msg2)
				} else {
					fmt.Println("Channel 2 is closed")
					c2 = nil
				}
		}

		if c1 == nil && c2 == nil {
			break
		}
	}
}