module main

import encoding.utf8 { is_number }

fn rpn(expression string) string {
	expr := expression
		.replace('(', ' ( ')
		.replace(')', ' ) ')
		.split(' ')
		.filter(it.len > 0)

	operators := ['+', '-', '*', '/']

	precedence := {
		'+': 1
		'-': 1
		'*': 2
		'/': 2
	}

	mut op_stack := []string{} // Operator stack
	mut out_queue := []string{} // Output queue

	for token in expr {
		if is_number(token[0]) {
			// If token is a number, add it to the output queue
			out_queue << token
			// Token is an operator
		} else if token in operators {
			// While we still have operators on the operator stack and the precedence of the last operator is the same or higher then the current token (operator)
			for op_stack.len > 0 && op_stack.last() in operators
				&& precedence[op_stack.last()] >= precedence[token] {
				// Pop the latest operator off and add it to the output queue
				out_queue << op_stack.pop()
			}
			// Then put the current operator onto the operator stack
			op_stack << token
		} else if token == '(' {
			op_stack << token
		} else if token == ')' {
			for op_stack.len > 0 && op_stack.last() != '(' {
				// As long as there are operators and the latest top most op isn't a left bracket
				out_queue << op_stack.pop()
				// Pop operators from the stack onto the queu
			}

			// When we finally reach the left bracket -> Discard it
			op_stack.pop()
		}
	}

	for op_stack.len > 0 {
		last_op := op_stack.pop()
		if last_op != '(' && last_op != ')' {
			out_queue << last_op
		}
	}

	return out_queue.join(' ')
}
