// Programming Languages
// Lecture 11: HTTP Server

package main

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"sync"
)

var (
	db map [string]interface{} = make(map[string]interface{})
	dbLock sync.Mutex
)

type Entry struct {
	Key string `json:"key"`
	Value interface{} `json:"value"`
}

func cpuWaste() {
	iterations :=  rand.Intn(50) + 100

	for i := 0; i < iterations; i++ {
		for j := 0; j < 100000000; j++ {
			_ = j
		}
	}
}

func helloWorld(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, world!")
}

func sendResponse(entry *Entry, w http.ResponseWriter, httpStatusCode int) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(httpStatusCode)
	encoder := json.NewEncoder(w)
	if err := encoder.Encode(entry); err != nil {
		log.Printf("Error encoding JSON: %v", err)
	}	
}

func dbPostHandler(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	log.Printf("Received request: %v", r)

	decoder := json.NewDecoder(r.Body)
	entry := &Entry{}

	if err := decoder.Decode(&entry); err != nil {
		log.Printf("Error decoding JSON: %v", err)
		sendResponse(nil, w, http.StatusBadRequest)
		return
	}

	cpuWaste()

	dbLock.Lock()
	defer dbLock.Unlock()
	db[entry.Key] = entry.Value
	
	sendResponse(entry, w, http.StatusCreated)
}

func main() {
	http.HandleFunc("/helloworld", helloWorld)
	http.HandleFunc("/db", dbPostHandler)

	log.Printf("Starting server on port 8080")

	err := http.ListenAndServe(":8080", nil)

	log.Fatal(err)
}