// Programming Languages
// Lecture 11: Mutex

package main

import (
	"fmt"
	"runtime"
	"sync"
)

func main() {
	fmt.Println("CPUs:", runtime.NumCPU())
	fmt.Println("Goroutines:", runtime.NumGoroutine())
	counter := 0

	const gs = 100

	var wg sync.WaitGroup
	var mu sync.Mutex
	wg.Add(gs)

	for i := 0; i < gs; i++ {
		go func() {
			mu.Lock()
			defer mu.Unlock()
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