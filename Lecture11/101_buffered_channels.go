// Programming Languages
// Lecture 11: Buffered Channels

package main

import (
	"fmt"
	"time"
)

func main() {
	// Create a buffered channel with a capacity of 5
	c := make(chan string, 5)

	go func(ch chan string) {
		for i := 0; i < 10; i++ {
			fmt.Println("Sending message to channel")
			ch <- fmt.Sprintf("Hello %d", i) // Send message to channel
			time.Sleep(time.Millisecond * 100)
		}
		ch <- "exit" // Send message to channel
		close(ch)
	}(c)
	

	for  {
		msg := <- c // Receive message from channel

		// Check if message is "exit" to break the loop
		if msg == "exit" {
			break;
		}

		fmt.Println("Received message from channel")
		fmt.Println(msg)
		time.Sleep(time.Second * 1)
	}
}