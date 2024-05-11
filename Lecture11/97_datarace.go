// Programming Languages
// Lecture 11: Datarace

package main

import (
	"fmt"
	"runtime"
	"sync"
)

// Prove that it is a data race by using the -race flag

func main() {
	fmt.Println("CPUs:", runtime.NumCPU())
	fmt.Println("Goroutines:", runtime.NumGoroutine())
	counter := 0

	const gs = 100

	var wg sync.WaitGroup
	wg.Add(gs)

	for i := 0; i < gs; i++ {
		go func() {
			v := counter	   // read the counter
			runtime.Gosched()  // yield the processor to allow other goroutines to run
			v++                // increment the counter
			counter = v        // write the new value back to the counter
			wg.Done()          // Notify the WaitGroup that the goroutine is done
		}()
		fmt.Println("Goroutines:", runtime.NumGoroutine())
	}

	wg.Wait()

	fmt.Println("Goroutines:", runtime.NumGoroutine())
	fmt.Println("count:", counter)
}