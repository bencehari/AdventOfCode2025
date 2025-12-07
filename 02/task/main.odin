package aoc_02_task

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

	sum: int = 0

	ranges := strings.split(string(input), ",")
	for r in ranges {
		fromTo := strings.split(strings.trim(r, "\n"), "-")
		sum += sum_of_invalid_ids_p2(fromTo)
	}

	fmt.println("Sum:", sum)
}

sum_of_invalid_ids_p2 :: proc(fromTo: []string) -> int {
	from, _ := strconv.parse_int(fromTo[0])
	to, _ := strconv.parse_int(fromTo[1])

	sum: int = 0

	input: for v in from..=to {
		if v < 10 {
			continue
		}

		str := fmt.tprintf("%v", v)
		len := len(str)

		all_the_same_counter := 0
		for c in str {
			if c == rune(str[0]) {
				all_the_same_counter += 1
			}
			else do break
		}
		if all_the_same_counter == len {
			sum += v
			// fmt.println("invalid:", v)
			continue
		}

		// -------------------------

		// fmt.println(v)
		for act_len in 2..=(len / 2) {
			if len % act_len != 0 {
				continue
			}

			max_step_count := len / act_len
			counter := 0

			for step in 1..<max_step_count {
				act_start := (step * act_len)
				if str[:act_len] == str[act_start:act_start + act_len] {
					counter += 1
				}
				else do break

				// fmt.println("a:", str[:act_len], "b:", str[act_start:act_start + act_len], "c:", counter, "(", max_step_count - 1, ")")
			}
			if counter == max_step_count - 1 {
				sum += v
				// fmt.println("invalid:", v)
				continue input
			}
		}
	}

	return sum
}

part_one :: proc() {
	input, _ := os.read_entire_file("./input.txt", context.allocator)
	defer delete(input, context.allocator)

	sum: int = 0

	ranges := strings.split(string(input), ",")
	for r in ranges {
		fromTo := strings.split(strings.trim(r, "\n"), "-")
		sum += sum_of_invalid_ids_p1(fromTo)
	}

	fmt.println("Sum:", sum)
}

sum_of_invalid_ids_p1 :: proc(fromTo: []string) -> int {
	from, _ := strconv.parse_int(fromTo[0])
	to, _ := strconv.parse_int(fromTo[1])

	// fmt.printf("%d --- %d\n", from, to)

	sum: int = 0
	for v in from..=to {
		str_val := fmt.tprintf("%v", v)
		if (len(str_val) % 2 != 0) {
			continue
		}

		half_len := len(str_val) / 2
		if str_val[:half_len] == str_val[half_len:] {
			sum += v
		}
	}

	return sum
}
