# encoding: utf-8

Feature: UnicodeData.txt file is to be used locally until it’s absent

	Scenario: Get all composed symbols
		When we call all_character_decomposition_mapping on Forkforge::UnicodeData
		Then the result count equals to 5405

###############################################################################

  Scenario: Camel to underscore function works
    Given we have a string "CamelCasedString"
    When we call "camel_to_underscore" method on Forkforge::Unicode
    Then the result is "camel_cased_string"

  Scenario: Underscore to camel function works
    Given we have a string "underscore_old_school_string"
    When we call "underscore_to_camel" method on Forkforge::Unicode
    Then the result is "UnderscoreOldSchoolString"

###############################################################################

  Scenario: Get all specific letter: uppercase
    When we call "uppercase" method on Forkforge::Letter
    Then the result count equals to 1421
     And the first item equals to "A"

	Scenario: Get all specific letter: lowercase
		When we call "lowercase" method on Forkforge::Letter
		Then the result count equals to 1748
		 And the first item equals to "a"

	Scenario: Get all specific letter: titlecase
		When we call "titlecase" method on Forkforge::Letter
		Then the result count equals to 31
		 And the first item equals to "ǅ"

	Scenario: Get all specific letter: modifier
		When we call "modifier" method on Forkforge::Letter
		Then the result count equals to 187
		 And the first item equals to "ʰ"

	Scenario: Get all specific letter: others
		When we call "other" method on Forkforge::Letter
		Then the result count equals to 8679
		 And the first item equals to "ƻ"

	Scenario: Get all codepoints for uppercased letters
	  When we call uppercase_code_point on Forkforge::Letter
	  Then we print results

###############################################################################

	Scenario: Get all specific marks: non-spacing
		When we call "non_spacing" method on Forkforge::Mark
		Then the result count equals to 1032
		 And the first item equals to "̀"

	Scenario: Get all specific marks: spacing combining
		When we call "spacing_combining" method on Forkforge::Mark
		Then the result count equals to 236
		 And the first item equals to "ः"

	Scenario: Get all specific marks: enclosing
		When we call "enclosing" method on Forkforge::Mark
		Then the result count equals to 13
		 And the first item equals to "҈"

###############################################################################

	Scenario: Get all specific numbers: decimal digit
		When we call "decimal_digit" method on Forkforge::Number
		Then the result count equals to 370
		 And the first item equals to "0"

	Scenario: Get all specific numbers: letter
		When we call "letter" method on Forkforge::Number
		Then the result count equals to 214
		 And the first item equals to "ᛮ"

	Scenario: Get all specific numbers: other
		When we call "other" method on Forkforge::Number
		Then the result count equals to 349
		 And the first item equals to "²"

###############################################################################

	Scenario: Get all specific punctuation: connectors
		When we call "connector" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item equals to "_"

	Scenario: Get all specific punctuation: dashes
		When we call "dash" method on Forkforge::Punctuation
		Then the result count equals to 20
		 And the first item equals to "-"

	Scenario: Get all specific punctuation: opens
		When we call "open" method on Forkforge::Punctuation
		Then the result count equals to 72
		 And the first item equals to "("

	Scenario: Get all specific punctuation: closes
		When we call "close" method on Forkforge::Punctuation
		Then the result count equals to 71
		 And the first item equals to ")"

	Scenario: Get all specific punctuation: initial_quotes
		When we call "initial_quote" method on Forkforge::Punctuation
		Then the result count equals to 12
		 And the first item equals to "«"

	Scenario: Get all specific punctuation: final_quotes
		When we call "final_quote" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item equals to "»"

	Scenario: Get all specific punctuation: others
		When we call "other" method on Forkforge::Punctuation
		Then the result count equals to 315
		 And the first item equals to "!"

###############################################################################

	Scenario: Get all specific symbols: math
		When we call "math" method on Forkforge::Symbol
		Then the result count equals to 945
		 And the first item equals to "+"

	Scenario: Get all specific symbols: currency
		When we call "currency" method on Forkforge::Symbol
		Then the result count equals to 41
		 And the first item equals to "$"

	Scenario: Get all specific symbols: modifier
		When we call "modifier" method on Forkforge::Symbol
		Then the result count equals to 99
		 And the first item equals to "^"

	Scenario: Get all specific symbols: other
		When we call "other" method on Forkforge::Symbol
		Then the result count equals to 3225
		 And the first item equals to "¦"

###############################################################################

	Scenario: Get all specific separators: space
		When we call "space" method on Forkforge::Separator
		Then the result count equals to 18
		 And the first item equals to " "

	Scenario: Get all specific separators: line
		When we call "line" method on Forkforge::Separator
		Then the result count equals to 1
		 And we print results

	Scenario: Get all specific separators: paragraph
		When we call "paragraph" method on Forkforge::Separator
		Then the result count equals to 1
		 And we print results

###############################################################################

	Scenario: Get all specific others: control
		When we call "control" method on Forkforge::Other
		Then the result count equals to 65

	Scenario: Get all specific others: format
		When we call "format" method on Forkforge::Other
		Then the result count equals to 139
		 And the first item equals to "­"

	Scenario: Get all specific others: surrogate
		When we call "surrogate" method on Forkforge::Other
		Then the result count equals to 6
		 And we print results

	Scenario: Get all specific others: private use
		When we call "private_use" method on Forkforge::Other
		Then the result count equals to 6
		 And we print results

	Scenario: Get all specific others: not assigned
		When we call "not_assigned" method on Forkforge::Other
		Then the result count equals to 0

###############################################################################

	Scenario: Get all connectors with their names
		When we call "connector_character_name" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item’s value equals to "LOW LINE"

	Scenario: Get all dashes with their names
		When we call "dash_character_name" method on Forkforge::Punctuation
		Then the result count equals to 20
		 And the first item’s value equals to "HYPHEN-MINUS"

###############################################################################

  Scenario: Upcase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is upcased
    Then the result is "МАМА МЫЛА РАМУ"

  # titlecase titleize every funcking letter!!
  Scenario: Titlecase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is titlecased
    Then the result is "МАМА МЫЛА РАМУ"

  Scenario: Downcase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is downcased
    Then the result is "мама мыла раму"

  Scenario: Upcase function works properly on combined
    Given we have a cyrillic string "naïve Álto Pàlo"
    When the string is upcased
    Then the result is "NAÏVE ÁLTO PÀLO"

  Scenario: Upcase function works properly with Turkic (CAPITAL I WITH DOT)
    Given we have a string "naïve istanbul"
    When the string is upcased with language set to "tr"
    Then the result is "NAİ̈VE İSTANBUL"

  Scenario: Upcase function works properly with generic (CAPITAL I WITHOUT DOT)
    Given we have a string "naïve istanbul"
    When the string is upcased with language set to ""
    Then the result is "NAÏVE ISTANBUL"

  Scenario: Downcase function works properly with generic (SMALL I WITH DOT)
    Given we have a string "NAÏVE ISTANBUL"
    When the string is downcased with language set to ""
    Then the result is "naïve istanbul"

  Scenario: Print out known conditions
    When we ask to print known conditions
    Then we print results

###############################################################################

	Scenario: Lookup symbols by name
	  Given we have a pattern "RiNg AbOvE"
	   When lookup is done with this pattern
	   Then we print results

	Scenario: Lookup symbols by name
	  Given we have a pattern "RING ABOVE"
	   When lookup using all_character_name is done with this pattern
	   Then we print first "2" results

	Scenario: Lookup symbols with tagged character_name
	  Given we have a pattern looking like a tag
	   When lookup using all_character_name is done with this pattern
	   Then we print first "1" results

	Scenario: Lookup tag names using character_name
	  Given we have a pattern looking like a tag
	   When result is filtered to show tags
		 Then the result count equals to 21
	    And we print first "21" results

	Scenario: Lookup tags using character_name
	  Given we have a pattern looking like a tag
	   When result is filtered to show tagged characters
		 Then the result count equals to 21
	    And the result’s first element nested count is "65"

	Scenario: Lookup tags using meta method
	  Given we have a pattern looking like a tag
	   When result is set to response from "control" function call
		 Then the result count equals to 65
	    And we print first "1" results

	Scenario: Print info on symbol
	  Given we have a symbol "〷"
	   When we retrieve it’s info
		 Then we print results
		  And the result is "IDEOGRAPHIC TELEGRAPH LINE FEED SEPARATOR SYMBOL"

	Scenario: Print info on symbol on it’s codebase
	  Given we have a symbol with codebase "0x3037"
	   When we retrieve it’s info
		 Then we print results
			And the result is "IDEOGRAPHIC TELEGRAPH LINE FEED SEPARATOR SYMBOL"

###############################################################################

  Scenario: Tag class accepts strings with tag delimiters properly
    Given we have a string "<font>"
     When we construct Tag object against it
     Then both sym and tag have correct values

  Scenario: Tag class accepts strings without tag delimiters properly
    Given we have a string "font"
     When we construct Tag object against it
     Then both sym and tag have correct values

  Scenario: Tag class rejects strings with improper tags
    Given we have a string "ghgh"
     When we construct Tag object against it
     Then both sym and tag have nil values

  Scenario: Decompose symbols
    Given we have a string "Barçelona Niños"
     When we decompose it
     Then we print results
		  And the result is "Barçelona Niños"

  Scenario: Decompose symbols with <font>
    Given we have a string "ℂool"
     When we decompose it
     Then we print results
			And the result is "Cool"

  Scenario: Decompose symbols with <font>
    Given we have a string "ℂool"
     When we decompose it with circle tag only
     Then we print results
			And the result is "ℂool"

  Scenario: Add custom decomposition symbols
    Given we have a string "Мáма"
     When we add custom decomposition rule
      And we decompose it
     Then we print results

###############################################################################

  Scenario: Composing digit with circle
    Given we have a string "1"
     When we compose input to "circle"
     Then the result is "①"
      And we print results

  Scenario: Composing letter with font
    Given we have a string "a"
     When we compose input to "font"
     Then the result is "𝐚,𝑎,𝒂,𝒶,𝓪,𝔞,𝕒,𝖆,𝖺,𝗮,𝘢,𝙖,𝚊"
      And we print results

  Scenario: Composing letter with wide
    Given we have a string "a"
     When we compose input to "wide"
     Then the result is "ａ"
      And we print results

  Scenario: Composing letter with super
    Given we have a string "a"
     When we compose input to "super"
     Then we print results
      And the result is "ª,ᵃ"

  Scenario: Composing letter with sub
    Given we have a string "a"
     When we compose input to "sub"
     Then we print results
      And the result is "ₐ"

  Scenario: Composing letter with vertical
    Given we have a string "?"
     When we compose input to "vertical"
     Then we print results
      And the result is "︖"

  Scenario: Composing letter with small
    Given we have a string "?"
     When we compose input to "small"
     Then we print results
      And the result is "﹖"

  Scenario: Composing letter with compat
    Given we have a string "µ"
     When we compose input to "compat"
     Then we print results
      And the result is ""

###############################################################################

  Scenario: Code points method missing works on latin letters
    When we call "math" method on Forkforge::CodePoints for "b"
    Then we print results
     And the result to string is "𝐛𝑏𝒃𝒷𝓫𝔟𝕓𝖇𝖻𝗯𝘣𝙗𝚋"

  Scenario: Code points method missing works on strings
    When we call "math" method on Forkforge::CodePoints for "abc"
    Then we print results
     And the result to string is "𝐚𝐛𝐜𝑎𝑏𝑐𝒂𝒃𝒄𝒶𝒷𝒸𝓪𝓫𝓬𝔞𝔟𝔠𝕒𝕓𝕔𝖆𝖇𝖈𝖺𝖻𝖼𝗮𝗯𝗰𝘢𝘣𝘤𝙖𝙗𝙘𝚊𝚋𝚌"

  Scenario: Code points method missing chained works on strings
    When we call "math_fraktur_bold" method on Forkforge::CodePoints for "abc"
    Then we print results
     And the result to string is "𝖆𝖇𝖈"
