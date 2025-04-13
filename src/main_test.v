module main

fn test_rpn_simple_addition() {
	assert rpn('3 + 4') == '3 4 +'
}

fn test_rpn_with_precedence() {
	assert rpn('3 + 4 * 2') == '3 4 2 * +'
}

fn test_rpn_with_parentheses() {
	assert rpn('(3 + 4) * 2') == '3 4 + 2 *'
}

fn test_rpn_with_nested_parentheses() {
	assert rpn('((3 + 4) * (5 - 2)) / 7') == '3 4 + 5 2 - * 7 /'
}

fn test_rpn_complex_expression() {
	assert rpn('(3 + 4) * (2 - 1) / (5 - 3 + 1) + 6 * 2') == '3 4 + 2 1 - * 5 3 - 1 + / 6 2 * +'
}

fn test_rpn_long_chain() {
	assert rpn('1 + 2 + 3 + 4 * 5') == '1 2 + 3 + 4 5 * +'
}

fn test_rpn_all_operators() {
	assert rpn('5 + ((1 + 2) * 4) - 3') == '5 1 2 + 4 * + 3 -'
}
