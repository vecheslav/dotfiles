; Keywords
[
  "module"
  "script"
  "address"
  "public"
  "fun"
  "struct"
  "const"
  "let"
  "use"
  "friend"
  "native"
  "entry"
  "inline"
  "acquires"
  "has"
] @keyword

; Type annotations and specifiers
(phantom) @keyword

; Control flow keywords
[
  "if"
  "else"
  "while"
  "loop"
  "for"
  "match"
  "return"
  "abort"
] @keyword.control

; Break and continue expressions (these are aliased in the grammar)
(break_expr) @keyword.control
(continue_expr) @keyword.control

; Binary operators
(binary_operator) @operator

; Assignment operator
"=" @operator

; Unary operators
"!" @operator

; Reference operators
"&" @operator
"&mut" @operator

; Dereference operator
"*" @operator

; Keywords that act as operators
[
  "move"
  "copy"
  "as"
  "in"
] @operator

; Types
[
  "u8"
  "u16"
  "u32"
  "u64"
  "u128"
  "u256"
  "bool"
  "address"
  "vector"
] @type.builtin

; Quantifier directives and verification keywords
[
  "exists"
  "forall"
  "choose"
  "min"
  "where"
] @keyword.function

; Literals
(bool_literal) @boolean
(number) @number
(typed_number) @number

; String literals
(byte_string) @string

; Comments
(line_comment) @comment
(block_comment) @comment

; Address blocks
(address_block) @namespace

; Special attributes
(declaration
  (attributes) @constant.builtin)

; Attributes
(attribute) @attribute

; Identifiers and variables
(identifier) @variable
(var_name) @variable

; Functions and macros
func: (identifier) @function.call
(function_decl name: (identifier) @function)
func_name: (name_access_chain name: (identifier) @function.call)
func_name: (name_access_chain access_two: (identifier) @function.call)
(macro_call_expr macro_name: (name_access_chain name: (identifier) @function.macro))
(receiver_call func: (identifier) @function.call)

; Type names
(type
  (name_access_chain name: (identifier) @type))
(type ref: (name_access_chain name: (identifier) @type.builtin))

; Members
member: (member (identifier) @type)

; Type arguments
(type_args (type
    (name_access_chain name: (identifier) @type.builtin)))

; Structs
struct_name: (name_access_chain name: (identifier) @type)
(struct_decl name: (identifier) @type)

; Access field expressions
(access_field field: (identifier) @property)

; Access specifier
specifier: (access_specifier_list
  (access_specifier
    (name_access_chain_wildcard name: (identifier) @type.builtin)))

; Discouraged names
(discouraged_name) @warning

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ";"
  ":"
  "::"
  "."
  "|"
] @punctuation.delimiter

; Special highlighting for error nodes
(ERROR) @error

; Highlight discouraged names differently
(discouraged_name) @warning
