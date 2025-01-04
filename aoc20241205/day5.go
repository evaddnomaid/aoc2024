package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strings"
	"strconv"
	"errors"
	//"sort"
)

// TODO: use https://pkg.go.dev/slices#SortFunc ?

// Return the first element from a list of 2 or more
// 2-element orderings
func find_first(ordering [][2]int) (int, error) {
	if len(ordering) == 0 {
		return 0, errors.New("Empty ordering list")
	}
	if len(ordering) == 1 {
		return 0, errors.New("Only one ordering item")
	}
	candidate := ordering[0][0]
	i := 0
	for i < len(ordering) {
		if ordering[i][1] == candidate {
			candidate = ordering[i][0]
			i = 0
		} else {
			i += 1
		}
	}
	return candidate, nil
}

func print_array(array []int) {
	println("Array len: ", len(array))
	for i := 0; i < len(array); i++ {
		fmt.Printf("%d ", array[i])
	}
	println("<thatsall")
}

type Person struct {
	name string
	height int
}

func tallest_person(people []Person) Person {
	return people[0]
}

func main() {
	a_person_slice := []Person{{"Bill", 190},{"Sally", 283}}
	println(tallest_person(a_person_slice).name)
	println()
	os.Exit(0)
	ordering_sample := [][2]int{
		{47, 53},
		{97, 47},
		{53, 18} }
	sorted := []int{}
	var first int
	var tempholder [2]int
	ordering := [][2]int{}
	ordering = ordering_sample
	for len(ordering) > 1 {
		first, _ = find_first(ordering)
		print_array(sorted)
		sorted = append(sorted, first)
		// remove ordering list items mentioning the first element
		newordering := [][2]int{}
		for i := 0; i < len(ordering); i++ {
			if ordering[i][0] != first {
				tempholder[0] = ordering[i][0]
				tempholder[1] = ordering[i][1]
				newordering = append(newordering, tempholder)
			}
		}
		ordering = newordering
		first, _ = find_first(ordering)
	}
	sorted = append(sorted, ordering[0][1])
	print_array(sorted)
	sorted = append(sorted, ordering[0][0])
	print_array(sorted)
	os.Exit(0)

	fmt.Println("Hello, world! =====================================================")
	var pageOrderingRulesSearch = regexp.MustCompile(`^([0-9]+)\|([0-9]+)$`)
	pageOrderingRegexList := []*regexp.Regexp{}
	var pagesToProduceSearch = regexp.MustCompile(`^([0-9]+,)+[0-9]+$`)
	pagesToProduceList := []string{}
	var centerSum = 0

	input := bufio.NewScanner(os.Stdin)

	// Read in the pageOrderingRegexList and pagesToProduceList
	for input.Scan() {
		var textline = input.Text()
		if pageOrderingRulesSearch.MatchString(textline) {
			// Found a page ordering rule
			match := pageOrderingRulesSearch.FindStringSubmatch(textline)
			//fmt.Printf("%s -- Left side: %s; Right side: %s\n", textline, match[1], match[2])
			regexToBuild := fmt.Sprintf("%s,([0-9],)*%s", match[2], match[1])
			//fmt.Printf("Making a regex with %s\n", regexToBuild)
			pageOrderingRegexList = append(pageOrderingRegexList, regexp.MustCompile(regexToBuild))
		}
		if pagesToProduceSearch.MatchString(textline) {
			// Found a pagesToProduceList item
			pagesToProduceList = append(pagesToProduceList, textline)
			//fmt.Printf("Added a line: %s\n", textline)
			//fmt.Printf("Added a line: %s\n", pagesToProduceList[len(pagesToProduceList)-1])
		}
	}

	for _, line := range pagesToProduceList {
		//fmt.Printf("Produce line %d: %s -- %t\n", i, line, isOrderingOK(line, pageOrderingRegexList))
		if (isOrderingOK(line, pageOrderingRegexList)) {
		//println(centerElement(line))
			var center, _ = strconv.Atoi(centerElement(line))
			//println(center)
			centerSum += center
		}
	}
	println(centerSum)
}

func isOrderingOK(pagesToProduce string, pageOrderingRegexList []*regexp.Regexp) bool {
	for _, regex := range pageOrderingRegexList {
		if (regex.MatchString(pagesToProduce) ) {
			return false
		}
	}
	return true
}

func centerElement(line string) string {
	parts := strings.Split(line, ",")
	return parts[len(parts) / 2]
}
