# encoding: utf-8

###############################################################################
####    GIVEN
###############################################################################

Given(/^we have no local copy of the "(.*?)" file$/) do |f|
  @f = f
end

Given(/^we have a string "(.*?)"$/) do |input|
  @input = input
end

Given(/^we have a cyrillic string "(.*?)"$/) do |input|
  @input = input
end

Given(/^we have a pattern "(.*?)"$/) do |pattern|
  @pattern = pattern
end

Given(/^we have a pattern looking like a tag$/) do
  @pattern = /<.*?>/
end

Given(/^we have a symbol "(.*?)"$/) do |symbol|
  @input = symbol
end

Given(/^we have a symbol with codebase "(.*?)"$/) do |cb|
  @input = cb.to_i(16)
end

###############################################################################
#####    WHEN
###############################################################################

When(/^we call "(.*?)" method on Forkforge::Unicode$/) do |method|
  @output = Forkforge::Unicode::send method.to_sym, @input
end

When(/^we ask to print known conditions$/) do
  @output = Forkforge::SpecialCasing.all_condition_list.map { |k, v|
    v.map { |vv|
      vv[:condition_list]
    }
  }.flatten.uniq
end

When(/^the string is upcased with language set to "(.*?)"$/) do |lang|
  @output = Forkforge::Unicode::uppercase @input, lang
end

When(/^the string is downcased with language set to "(.*?)"$/) do |lang|
  @output = Forkforge::Unicode::lowercase @input, lang
end

When(/^the string is upcased$/) do
  @output = Forkforge::Unicode::uppercase @input
end

When(/^we decompose it$/) do
  @output = Forkforge::Unicode::decompose @input
end

When(/^we decompose it with circle tag only$/) do
  @output = Forkforge::Unicode::decompose @input, :circle
end

When(/^the string is downcased$/) do
  @output = Forkforge::Unicode::lowercase @input
end

When(/^the string is titlecased$/) do
  @output = Forkforge::Unicode::titlecase @input
end

When(/^we call all_character_decomposition_mapping on Forkforge::UnicodeData$/) do
  @output = Forkforge::UnicodeData::all_character_decomposition_mapping
end

When(/^we call "(.*?)" method on Forkforge::Letter$/) do |method|
  @output = Forkforge::Letter::send :"#{method}"
end

When(/^we call uppercase_code_point on Forkforge::Letter$/) do
  @output = Forkforge::Letter::uppercase_code_point
end

When(/^we call "(.*?)" method on Forkforge::Mark$/) do |method|
  @output = Forkforge::Mark::send :"#{method}"
end

When(/^we call "(.*?)" method on Forkforge::Number$/) do |method|
  @output = Forkforge::Number::send :"#{method}"
end

When(/^we call "(.*?)" method on Forkforge::Punctuation$/) do |method|
  @output = Forkforge::Punctuation::send :"#{method}"
end

When(/^we call "(.*?)" method on Forkforge::Symbol$/) do |method|
  @output = Forkforge::Symbol::send :"#{method}"
end

When(/^we call "(.*?)" method on Forkforge::Separator$/) do |method|
  @output = Forkforge::Separator::send :"#{method}"
end

When(/^we call "(.*?)" method on Forkforge::Other$/) do |method|
  @output = Forkforge::Other::send :"#{method}"
end

When(/^lookup using all_character_name is done with this pattern$/) do
  @output = Forkforge::UnicodeData::all_character_name Regexp.new @pattern
end

When(/^lookup is done with this pattern$/) do
  @output = Forkforge::Unicode::lookup Regexp.new @pattern, Regexp::IGNORECASE
end

When(/^result is filtered to show tags$/) do
  @output = Forkforge::TaggedCharacterName::ALL
end

When(/^result is filtered to show tagged characters$/) do
  @output = Forkforge::TaggedCharacterName::CHARACTERS
end

When(/^result is set to response from "(.*?)" function call$/) do |method|
  @output = Forkforge::TaggedCharacterName::send :"#{method}"
end

When(/^we retrieve it’s info$/) do
  @output = Forkforge::UnicodeData::info(@input)[:character_name]
end

When(/^we add custom decomposition rule$/) do
  @pending # Will be implemented after core is done
end

When(/^we construct Tag object against it$/) do
  @output = Forkforge::CharacterDecompositionMapping::Tag.new @input
end

When(/^we compose input to "(.*?)"$/) do |tag|
  @output = (Forkforge::Unicode::compose @input, "#{tag}").values.join(',')
end

When(/^we widify input$/) do
  @output = Forkforge::Unicode::wide @input
end

When(/^we circlefy input$/) do
  @output = Forkforge::Unicode::circle @input
end

When(/^we call "(.*?)" method on Forkforge::CodePoints for "(.*?)"$/) do |method, sym|
  @output = Forkforge::UnicodeData::code_points.send(method.to_sym, sym)
end

When(/^the string is directly widefied$/) do
  @output = @input.compose_wide
end

When(/^the string is directly upcased$/) do
  @output = @input.upcase
end

###############################################################################
#####    THEN
###############################################################################

Then(/^the file is got from www.unicode.org\/Public\/5.1.0\/ucd\/UnicodeData.txt is printed out$/) do
  @hash = Forkforge::UnicodeData.send :hash # just here for testing purposes, method is private
  puts @hash.take 2
end

Then(/^the result is "(.*?)"$/) do |result|
  expect(@output).to eq(result)
end

Then(/^the result to string is "(.*?)"$/) do |result|
  expect(@output.to_s).to eq(result)
end

Then(/^the result count equals to (\d+)$/) do |count|
  expect(@output.count).to eq(count.to_i)
end

Then(/^the first item equals to "(.*?)"$/) do |string|
  expect(@output[0]).to eq(string)
end

Then(/^the first item’s value equals to "(.*?)"$/) do |string|
  expect(@output.values[0]).to eq(string)
end

Then(/^the result’s first element nested count is "(.*?)"$/) do |count|
  expect(@output.values[0].count).to eq(count.to_i)
end

Then(/^we print first (\d+) results$/) do |count|
  puts @output.take count.to_i
end

Then(/^we print results$/) do
  puts @output
end

Then(/^we print a result count$/) do
  puts @output.count
end

Then(/^both sym and tag have correct values$/) do
  expect(@output.tag).to eq('<font>')
  expect(@output.sym).to eq(:font)
  expect(@output.valid?).to eq(true)
end

Then(/^both sym and tag have nil values$/) do
  expect(@output.tag).to eq(nil)
  expect(@output.sym).to eq(nil)
  expect(@output.valid?).to eq(false)
end
