package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	bytes, err := ioutil.ReadFile("day1-input.txt")
	if err != nil {
		panic(err)
	}

	var readings []int
	for _, reading := range strings.Split(string(bytes), "\n") {
		if reading != "" {
			i, _ := strconv.Atoi(reading)
			readings = append(readings, i)
		}
	}

	fmt.Printf("recorded %d readings\n", len(readings))

	numberOfIncreases := 0

	for index, _ := range readings {
		if index + 3 > len(readings) - 1 {
			break
		}

		previousReading := readings[index] + readings[index+1] + readings[index+2]
		thisReading := readings[index+1] + readings[index+2] + readings[index+3]

		if thisReading > previousReading {
			numberOfIncreases++
		}
	}

	fmt.Printf("there were %d increases\n", numberOfIncreases)
}
