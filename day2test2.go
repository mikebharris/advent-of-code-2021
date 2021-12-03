package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type move struct {
	operation string
	steps     int
}

func main() {
	file, _ := os.Open("day2-input.txt")
	scanner := bufio.NewScanner(file)

	var moves []move
	for scanner.Scan() {
		s := strings.Split(scanner.Text(), " ")
		steps, _ := strconv.Atoi(s[1])
		moves = append(moves, move{
			operation: s[0],
			steps:     steps,
		})
	}

	fmt.Printf("recorded %d moves\n", len(moves))

	currentDepth := 0
	currentDistance := 0
	currentAim := 0

	for index, _ := range moves {
		switch moves[index].operation {
		case "forward":
			currentDistance += moves[index].steps
			if currentAim != 0 {
				currentDepth += moves[index].steps * currentAim
			}
		case "down":
			currentAim += moves[index].steps
		case "up":
			currentAim -= moves[index].steps
		}
	}

	fmt.Printf("Final position: distance = %d, depth = %d, multipled = %d \n", currentDistance, currentDepth, currentDistance*currentDepth)
}
