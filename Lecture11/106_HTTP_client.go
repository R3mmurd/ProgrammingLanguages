// Programming Languages
// Lecture 11: HTTP Client

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
)

type Entry struct {
	Key string `json:"key"`
	Value interface{} `json:"value"`
}

func sendRequest(method string, url string, entry *Entry) (*Entry, error) {
	entryBuffer := new(bytes.Buffer)
	encoder := json.NewEncoder(entryBuffer)
	if err := encoder.Encode(entry); err != nil {
		log.Printf("Error encoding JSON: %v", err)
		return nil, err	
	}

	req, err := http.NewRequest(method, url, entryBuffer)
	if err != nil {
		log.Printf("Error creating request: %v", err)
		return nil, err
	}

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		log.Printf("Error sending request: %v", err)
		return nil, err
	}

	defer res.Body.Close()

	decoder := json.NewDecoder(res.Body)
	entry = &Entry{}
	if err := decoder.Decode(&entry); err != nil {
		log.Printf("Error decoding JSON: %v", err)
		return nil, err
	}

	return entry, nil
}

func main() {

	for i := 0; i < 100; i++ {
		go func(id int) {
			fmt.Printf("Sending request %d\n", id)
			idStr := strconv.Itoa(id)
			entry := &Entry{idStr , idStr}
			entry, err := sendRequest("POST", "http://localhost:8080/db", entry)
			if err != nil {
				log.Printf("Error sending request: %v", err)
				return
			}

			fmt.Printf("Response in %d: %v\n", id, entry)
		}(i)
	}

	fmt.Scanln()
}
	