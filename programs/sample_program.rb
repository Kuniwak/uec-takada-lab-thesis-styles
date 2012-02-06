#! /usr/bin/ruby
#
# = 'Multi-char-auth' outcomes calcurator
# Authors:: {Yuki Kokubun (2012 UEC Tokyo Japan, Takada.Lab)}[mailto:uec.takada.lab@hotmail.com]
# Copyright:: Copyright (C) 2012 Yuki Kokubun (UEC Tokyo)
# License:: {MIT License}[http://kuni-uec-takada-lab.mit-license.org/]
#
# -*- encoding: utf-8 -*-

# Arguments processing module
require 'optparse'

# \constant {Boolean} Switch accept repeated case such as [0,1,1]
accept_repeated = true

# \constant {Boolean} Switch print all cases
export_cases = false

# Arguments process
digit = 0
opt = OptionParser.new()
opt.on('-d=<digit>', 'Number digit') {|v| digit = v.to_i}
opt.on('-a', 'Accept goto upper row') {|v| accept_goto_upper_row = true} 
opt.on('--export', 'Print all cases') {|v| export_cases = true} 
argv = opt.parse!(ARGV)

if digit == 0
	puts "Invalied argument digit: #{digit}"
	exit
end

# \param {Array} chars_array
# \return {Array} families
def make_families (chars_array)
	#families[family[series[lot[]]]]
	families = []
	for last_index in 0..chars_array.length - 1
		family = []
		family_prefix = chars_array[0..last_index]
		if is_asc? family_prefix
			if last_index < chars_array.length - 1
				returned_families = make_families(chars_array[last_index + 1 .. -1])
				returned_families.each do |returned_family|
					returned_family.each do |returned_series|
						family << [family_prefix] + returned_series
					end
				end
			else
				family << [family_prefix]
			end
			families << family
		end
	end
	return families
end

# \param {Array} chars_array
# \return {Array} all_series
def make_series (chars_array)
	all_series = []
	make_families(chars_array).each do |family|
		all_series += family
	end
	return all_series
end

# \param {Number}
# \return {Array} all_cases
def make_all_cases (digit)
	period = "9" * digit
	cases = []
	for i in 0 .. period.to_i
		numbers = []
		sprintf("%0#{digit}d", i).each_char do |char| numbers.push(char.to_i) end
		cases += make_series(numbers)
	end
	return cases
end

# \param {Number}
# \return {Array} families
def make_all_families (digit)
	period = "9" * digit
	cases = []
	for i in 0 .. period.to_i
		numbers = []
		sprintf("%0#{digit}d", i).each_char do |char| numbers.push(char.to_i) end
		cases += make_families(numbers)
	end
	return cases
end

if accept_repeated
	# \param {Array} chars_array
	# \return {Boolean}
	def is_asc? (chars_array)
		chars_array.each_index do |index|
			if index < chars_array.length - 1
				if chars_array[index] > chars_array[index + 1]
					return false
				end
			end
		end
		return true
	end
else
	# \param {Array} chars_array
	# \return {Boolean}
	def is_asc? (chars_array)
		chars_array.each_index do |index|
			if index < chars_array.length - 1
				if chars_array[index] >= chars_array[index + 1]
					return false
				end
			end
		end
		return true
	end
end

cases = make_all_cases(digit)

if export_cases
	cases.each do |the_case|
		p the_case
	end
else
	puts "Outcomes: #{cases.length}"
end
