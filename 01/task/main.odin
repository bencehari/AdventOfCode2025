package aoc_01_task

import "core:os"
import "core:fmt"
import "core:strings"
import "core:strconv"

main :: proc() {
	// part_one();
	part_two();
}

part_two :: proc() {
	input, _ := os.read_entire_file("./input.txt", context.allocator)
	defer delete(input, context.allocator)

	act := 50
	counter: int = 0

	it := string(input)
	for line in strings.split_lines_iterator(&it) {
		prev := act

		dir := rune(line[0])

		val_str := line[1:]

		num_len := len(val_str)
		if num_len > 2 {
			hundreds, _ := strconv.parse_int(val_str[:num_len - 2])

			// fmt.println(line, num_len, hundreds)

			counter += hundreds
			val_str = val_str[(num_len - 2):]
		}

		val, _ := strconv.parse_int(val_str)

		v := dir == 'L' ? val * -1 : val
		act += v

		if act < 0 {
			act = act + 100
			if prev != 0 {
				counter += 1
			}
		}
		else if act > 99 {
			act = act - 100
			if prev != 0 {
				counter += 1
			}
		}
		else if act == 0 {
			counter += 1
		}
	}

	fmt.println("Counter:", counter)
}

part_one :: proc() {
	input, _ := os.read_entire_file("./input.txt", context.allocator)
	defer delete(input, context.allocator)

	act := 50
	counter: int = 0

	it := string(input)
	for line in strings.split_lines_iterator(&it) {
		dir := rune(line[0])

		val_str := line[1:]
		if len(val_str) > 2 {
			val_str = val_str[(len(val_str) - 2):]
		}

		val, _ := strconv.parse_int(val_str)

		v := dir == 'L' ? val * -1 : val
		act += v

		if act < 0 {
			act = act + 100
		}
		else if act > 99 {
			act = act - 100
		}

		if act == 0 {
			counter += 1
		}
	}

	fmt.println("Counter:", counter)
}
