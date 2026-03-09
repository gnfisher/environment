; extends

((function_declaration
  (type_parameter_list) @function.signature)
 (#set! priority 110))

((function_declaration
  parameters: (parameter_list) @function.signature)
 (#set! priority 110))

((function_declaration
  result: (_) @function.signature)
 (#set! priority 110))

((method_declaration
  receiver: (parameter_list) @function.signature)
 (#set! priority 110))

((method_declaration
  parameters: (parameter_list) @function.signature)
 (#set! priority 110))

((method_declaration
  result: (_) @function.signature)
 (#set! priority 110))

((method_elem
  parameters: (parameter_list) @function.signature)
 (#set! priority 110))

((method_elem
  result: (_) @function.signature)
 (#set! priority 110))
