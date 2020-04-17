"""
MIT License

Copyright (c) 2020 Konstantin Shegay

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

"""


extends Node


""" 
Take a Dictionary type object and returns a prettified JSON string
"""
func get_pretty_json_string(dict : Dictionary, indent_increment : int = 0):
	var pretty : String = ""
	
	var indent : String = "    "
	var quote : String = "\""
	var newline : String = "\n"
	var colon : String = ":"
	var openbracket : String = "{"
	var closebracket : String = "}"
	var space : String = " "
	var comma : String = ","
	
	pretty = openbracket
	
	var is_not_last : bool = true
	var element_counter : int = 0
	
	for element in dict.keys():
		element_counter += 1
		
		pretty += newline
		
		for i in range (indent_increment + 1):
			pretty += indent 
		
		pretty += quote + str(element) + quote + space + colon + space 
		
		match typeof(dict.get(element)):
			TYPE_DICTIONARY:
				pretty += self.get_pretty_json_string(dict.get(element), indent_increment + 1)
			TYPE_BOOL:
				pretty += str(dict.get(element)).to_lower()
			TYPE_STRING:
				pretty += quote + dict.get(element) + quote
			_:
				pretty += str(dict.get(element))
		
		if len(dict.keys()) <= 1 or len(dict.keys()) == element_counter:
			is_not_last = false
		
		if is_not_last:
			pretty += comma
		
	pretty += newline 
	
	for i in range (indent_increment):
		pretty += indent 
	
	pretty += closebracket
	
	return pretty