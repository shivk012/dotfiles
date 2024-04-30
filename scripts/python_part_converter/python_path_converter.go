package main

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"
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

func fromImportConverter(input string) string {
	split := strings.Fields(input)
	return split[1] + "." + split[len(split)-1]
}

func dotPathConverter(input string) string {
	split := strings.Split(input, ".")
	return strings.Join(split[:len(split)-1], "/")
}

func main() {
	query := os.Args[1]

	var pathOut string
	
  if strings.Fields(query)[0] == "from" {
		pathOut = fromImportConverter(query)
	} else {
		pathOut = dotPathConverter(query)
	}

	item := Item{
		UID:      "path",
		Title:    pathOut,
		Subtitle: "Enter to copy",
		Arg:      pathOut,
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
