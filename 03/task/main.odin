package aoc_03_task

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"

main :: proc() {
	// part_one()
	part_two()
}

part_two :: proc() {
	input, _ := os.read_entire_file("./input.txt", context.allocator)
	defer delete(input, context.allocator)

	MAX_LEN :: 12

	sum := 0

	it := string(input)
	for bank in strings.split_lines_iterator(&it) {
		blen := len(bank)
		max: [MAX_LEN]rune
		for number, i in bank {
			for m in 0..<MAX_LEN {
				if number > max[m] && i < blen - ((MAX_LEN - 1) - m) {
					max[m] = number

					for x in (m + 1)..=(MAX_LEN - 1) {
						max[x] = '0'
					}

					break
				}
			}
		}

		str := fmt.tprintf(
			"%v%v%v%v%v%v%v%v%v%v%v%v",
			max[0], max[1], max[2], max[3], max[4], max[5], max[6], max[7], max[8], max[9], max[10], max[11])

		if v, ok := strconv.parse_int(str); ok {
			sum += v
		}
	}

	fmt.println(sum)
}

part_one :: proc() {
	input, _ := os.read_entire_file("./input.txt", context.allocator)
	defer delete(input, context.allocator)

	sum := 0

	it := string(input)
	for bank in strings.split_lines_iterator(&it) {
		blen := len(bank)
		max: [2]rune
		for n, i in bank {
			if n > max[0] && i < blen - 1 {
				max[0] = n
				max[1] = '0'
			}
			else if n > max[1] {
				max[1] = n
			}
		}
		str := fmt.tprintf("%v%v", max[0], max[1])
		if v, ok := strconv.parse_int(str); ok {
			sum += v
		}
	}

	fmt.println(sum)
}
