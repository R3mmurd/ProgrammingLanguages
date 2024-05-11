// Programming Languages
// Lecture 11: Unbuffered Channels

package main

import (
	"fmt"
	"time"
)


func main() {
	// Create an unbuffered channel, it has no capacity
	c := make(chan string)

	go func(ch chan string) {
		for i := 0; i < 10; i++ {
			fmt.Println("Sending message to channel")
			ch <- fmt.Sprintf("Hello %d", i) // Send message to channel
			time.Sleep(time.Millisecond * 500)
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