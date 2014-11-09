# encoding: utf-8

###############################################################################
####    GIVEN
###############################################################################

Given(/^we have no local copy of the "(.*?)" file$/) do |f|
  @f = f
end

Given(/^we have a cyrillic string "(.*?)"$/) do |input|
  @input = input
end

###############################################################################
#####    WHEN
###############################################################################

When(/^the string is upcased$/) do
  @output = Forkforge::Unicode::upcase @input
end

When(/^the string is downcased$/) do
  @output = Forkforge::Unicode::downcase @input
end

When(/^the string is titlecased$/) do
  @output = Forkforge::Unicode::titlecase @input
end

When(/^the file is requested$/) do
  @raw = Forkforge::UnicodeData::raw
end

When(/^we call all_character_decomposition_mapping on Forkforge::UnicodeData$/) do
  @output = Forkforge::UnicodeData::all_character_decomposition_mapping
end

When(/^we call "(.*?)" method on Forkforge::Punctuation$/) do |method|
  @output = Forkforge::Punctuation::send :"#{method}"
end

###############################################################################
#####    THEN
###############################################################################

Then(/^the file is got from www.unicode.org\/Public\/5.1.0\/ucd\/UnicodeData.txt is printed out$/) do
  @hash = Forkforge::UnicodeData::hash
  puts @hash.take 48, 10
end

Then(/^the result is "(.*?)"$/) do |result|
  expect(@output).to eq(result)
end

Then(/^we print a result$/) do
  puts @output
#  puts @output.take 10, 10
end
