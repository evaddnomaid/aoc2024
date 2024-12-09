package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strings"
	"strconv"
)

func main() {
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
