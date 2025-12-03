package aoc_01_test

import "core:fmt"
import "core:strconv"

main :: proc() {
	// part_one()
	part_two()
}

part_two :: proc() {
	input := []string {
		"L68",
		"L30",
		"R48",
		"L5",
		"R60",
		"L55",
		"L1",
		"L99",
		"R14",
		"L82",
	}
	defer delete(input)

	act := 50
	counter: int = 0

	for line in input {
		prev := act

		dir := rune(line[0])

		val_str := line[1:]

		num_len := len(val_str)
		if num_len > 2 {
			hundreds, ok := strconv.parse_int(val_str[:num_len - 2])

			// fmt.println(line, num_len, hundreds)

			counter += hundreds
			val_str = val_str[(num_len - 2):]
		}

		val, ok := strconv.parse_int(val_str)

		v := dir == 'L' ? val * -1 : val
		act += v

		if act < 0 {
			act = act + 100
			if prev != 0 {
				counter += 1
				fmt.println(prev, act, " --> ", line, "< 0")
			}
		}
		else if act > 99 {
			act = act - 100
			if prev != 0 {
				counter += 1
				fmt.println(prev, act, " --> ", line, "> 99")
			}
		}
		else if act == 0 {
			counter += 1

			fmt.println(prev, act, " --> ", line, "== 0")
		}
	}

	fmt.println("Counter:", counter)
}

part_one :: proc() {
	input := []string {
		"L68",
		"L30",
		"R48",
		"L5",
		"R60",
		"L55",
		"L1",
		"L99",
		"R14",
		"L82",
	}
	defer delete(input)

	act := 50
	counter: int = 0

	for s in input {
		dir := rune(s[0])
		val, ok := strconv.parse_int(s[1:])

		v := dir == 'L' ? val * -1 : val
		act = act + v

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
