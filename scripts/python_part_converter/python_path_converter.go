package main

import (
	"fmt"
	"os"
	"strings"
)

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

	fmt.Println(string(pathOut))
}
