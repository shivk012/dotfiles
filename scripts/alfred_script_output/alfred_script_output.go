package main

import (
	"encoding/json"
	"fmt"
	"os"
)

type Item struct {
	UID      string `json:"uid"`
	Title    string `json:"title"`
	Subtitle string `json:"subtitle"`
	Arg      string `json:"arg"`
	Valid    bool   `json:"valid"`
}

type Payload struct {
	Items []Item `json:"items"`
}

func main() {
	query := os.Args[1]

	item := Item{
		UID:      "path",
		Title:    query,
		Subtitle: "Enter to copy",
		Arg:      query,
		Valid:    true,
	}

	payload := Payload{
		Items: []Item{item},
	}

	jsonPayload, err := json.Marshal(payload)
	if err != nil {
		fmt.Println("Error marshalling JSON:", err)
		return
	}

	fmt.Println(string(jsonPayload))
}
