// Programing Language
// Lecture 11: Wait Groups

package main

import (
	"fmt"
	"time"
	"math/rand"
	"sync"
)

func main() {

	wg := sync.WaitGroup{}
	
	for i := 0; i < 5; i++ {
		wg.Add(1)
		go func() {
			f()
			wg.Done()
		}()
	}

	fmt.Println("Hello from main")

	wg.Wait()
}

func f() {
	for i := 0; i < 10; i++ {
		fmt.Println("Hello from goroutine:", i)
		amt := time.Duration(rand.Intn(250))
		time.Sleep(time.Millisecond * amt)
	}
}