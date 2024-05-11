// Programming Languages
// Lecture 11: Channel Direction

package main

import (
	"fmt"
	"time"
	"sync"
)

func pinger(c chan<- string) {
	for i := 0; i < 10; i++ {
		c <- fmt.Sprintf("ping %d", i)
	}
	c <- "exit"
	close(c)
}

func printer(c <-chan string) {
	for  {
		msg := <- c
		if msg == "exit" {
			break
		}
		fmt.Println(msg)
		time.Sleep(time.Second)
	}
}

func main() {
	c := make(chan string)
	wg := sync.WaitGroup{}

	wg.Add(2)
	go pinger(c)
	go printer(c)
	wg.Wait()
}

