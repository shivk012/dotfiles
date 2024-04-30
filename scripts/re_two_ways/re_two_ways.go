package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {

	arg := os.Args[1]
	split := strings.Split(arg, " ")
	arg1 := split[0]
	arg2 := split[1]

	result := fmt.Sprintf("(%s.*%s)|(%s.*%s)", arg1, arg2, arg2, arg1)
	fmt.Println(result)
}
