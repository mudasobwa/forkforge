# encoding: utf-8

Feature: UnicodeData.txt file is to be used locally until it’s absent
	Scenario: Get all composed symbols
		When we call all_character_decomposition_mapping on Forkforge::UnicodeData
		Then the result count equals to 5721

###############################################################################
	@camel
  Scenario: Camel to underscore function works
    Given we have a string "CamelCasedString"
    When we call "camel_to_underscore" method on Forkforge::Unicode
    Then the result is "camel_cased_string"

	@camel
  Scenario: Underscore to camel function works
    Given we have a string "underscore_old_school_string"
    When we call "underscore_to_camel" method on Forkforge::Unicode
    Then the result is "UnderscoreOldSchoolString"

###############################################################################

	@letter
  Scenario: Get all specific letter: uppercase
    When we call "uppercase" method on Forkforge::Letter
    Then the result count equals to 1490
     And the first item equals to "A"

	@letter
	Scenario: Get all specific letter: lowercase
		When we call "lowercase" method on Forkforge::Letter
		Then the result count equals to 1841
		 And the first item equals to "a"

	@letter
	Scenario: Get all specific letter: titlecase
		When we call "titlecase" method on Forkforge::Letter
		Then the result count equals to 31
		 And the first item equals to "ǅ"

	@letter
	Scenario: Get all specific letter: modifier
		When we call "modifier" method on Forkforge::Letter
		Then the result count equals to 248
		 And the first item equals to "ʰ"

	@letter
	Scenario: Get all specific letter: others
		When we call "other" method on Forkforge::Letter
		Then the result count equals to 13350
		 And the first item equals to "ª"

	@letter
	Scenario: Get all codepoints for uppercased letters
	  When we call uppercase_code_point on Forkforge::Letter
	  Then we print first 10 results

###############################################################################

	@mark
	Scenario: Get all specific marks: non-spacing
		When we call "non_spacing" method on Forkforge::Mark
		Then the result count equals to 1418
		 And the first item equals to "̀"

	@mark
	Scenario: Get all specific marks: spacing combining
		When we call "spacing_combining" method on Forkforge::Mark
		Then the result count equals to 399
		 And the first item equals to "ः"

	@mark
	Scenario: Get all specific marks: enclosing
		When we call "enclosing" method on Forkforge::Mark
		Then the result count equals to 13
		 And the first item equals to "҈"

###############################################################################

	@number
	Scenario: Get all specific numbers: decimal digit
		When we call "decimal_digit" method on Forkforge::Number
		Then the result count equals to 540
		 And the first item equals to "0"

	@number
	Scenario: Get all specific numbers: letter
		When we call "letter" method on Forkforge::Number
		Then the result count equals to 236
		 And the first item equals to "ᛮ"

	@number
	Scenario: Get all specific numbers: other
		When we call "other" method on Forkforge::Number
		Then the result count equals to 570
		 And the first item equals to "²"

###############################################################################

	@punctuation
	Scenario: Get all specific punctuation: connectors
		When we call "connector" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item equals to "_"

	@punctuation
	Scenario: Get all specific punctuation: dashes
		When we call "dash" method on Forkforge::Punctuation
		Then the result count equals to 24
		 And the first item equals to "-"

	@punctuation
	Scenario: Get all specific punctuation: opens
		When we call "open" method on Forkforge::Punctuation
		Then the result count equals to 75
		 And the first item equals to "("

	@punctuation
	Scenario: Get all specific punctuation: closes
		When we call "close" method on Forkforge::Punctuation
		Then the result count equals to 73
		 And the first item equals to ")"

	@punctuation
	Scenario: Get all specific punctuation: initial_quotes
		When we call "initial_quote" method on Forkforge::Punctuation
		Then the result count equals to 12
		 And the first item equals to "«"

	@punctuation
	Scenario: Get all specific punctuation: final_quotes
		When we call "final_quote" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item equals to "»"

	@punctuation
	Scenario: Get all specific punctuation: others
		When we call "other" method on Forkforge::Punctuation
		Then the result count equals to 484
		 And the first item equals to "!"

###############################################################################

	@symbol
	Scenario: Get all specific symbols: math
		When we call "math" method on Forkforge::Symbol
		Then the result count equals to 948
		 And the first item equals to "+"

	@symbol
	Scenario: Get all specific symbols: currency
		When we call "currency" method on Forkforge::Symbol
		Then the result count equals to 52
		 And the first item equals to "$"

	@symbol
	Scenario: Get all specific symbols: modifier
		When we call "modifier" method on Forkforge::Symbol
		Then the result count equals to 116
		 And the first item equals to "^"

	@symbol
	Scenario: Get all specific symbols: other
		When we call "other" method on Forkforge::Symbol
		Then the result count equals to 5082
		 And the first item equals to "¦"

###############################################################################

	@separator
	Scenario: Get all specific separators: space
		When we call "space" method on Forkforge::Separator
		Then the result count equals to 17
		 And the first item equals to " "

	@separator
	Scenario: Get all specific separators: line
		When we call "line" method on Forkforge::Separator
		Then the result count equals to 1
		 And we print results

	@separator
	Scenario: Get all specific separators: paragraph
		When we call "paragraph" method on Forkforge::Separator
		Then the result count equals to 1
		 And we print results

###############################################################################

	@other
	Scenario: Get all specific others: control
		When we call "control" method on Forkforge::Other
		Then the result count equals to 65

	@other
	Scenario: Get all specific others: format
		When we call "format" method on Forkforge::Other
		Then the result count equals to 150
		 And the first item equals to "­"

	@other
	Scenario: Get all specific others: surrogate
		When we call "surrogate" method on Forkforge::Other
		Then the result count equals to 6
		 And we print results

	@other
	Scenario: Get all specific others: private use
		When we call "private_use" method on Forkforge::Other
		Then the result count equals to 6
		 And we print results

	@other
	Scenario: Get all specific others: not assigned
		When we call "not_assigned" method on Forkforge::Other
		Then the result count equals to 0

###############################################################################

	@punctuation @connector
	Scenario: Get all connectors with their names
		When we call "connector_character_name" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item’s value equals to "LOW LINE"

	@punctuation @connector
	Scenario: Get all dashes with their names
		When we call "dash_character_name" method on Forkforge::Punctuation
		Then the result count equals to 24
		 And the first item’s value equals to "HYPHEN-MINUS"

###############################################################################

  @languages
	Scenario: Upcase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is upcased
    Then the result is "МАМА МЫЛА РАМУ"

  # titlecase titleize every funcking letter!!
  @languages
	Scenario: Titlecase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is titlecased
    Then the result is "МАМА МЫЛА РАМУ"

  @languages
	Scenario: Downcase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is downcased
    Then the result is "мама мыла раму"

	@languages
  Scenario: Upcase function works properly on combined
    Given we have a cyrillic string "naïve Álto Pàlo"
    When the string is upcased
    Then the result is "NAÏVE ÁLTO PÀLO"

  @languages
	Scenario: Upcase function works properly with Turkic (CAPITAL I WITH DOT)
    Given we have a string "naïve istanbul"
    When the string is upcased with language set to "tr"
    Then the result is "NAİ̈VE İSTANBUL"

  @languages
	Scenario: Upcase function works properly with generic (CAPITAL I WITHOUT DOT)
    Given we have a string "naïve istanbul"
    When the string is upcased with language set to ""
    Then the result is "NAÏVE ISTANBUL"

  @languages
	Scenario: Downcase function works properly with generic (SMALL I WITH DOT)
    Given we have a string "NAÏVE ISTANBUL"
    When the string is downcased with language set to ""
    Then the result is "naïve istanbul"

  @languages
	Scenario: Print out known conditions
    When we ask to print known conditions
    Then we print results

###############################################################################

	@lookup
	Scenario: Lookup symbols by name
	  Given we have a pattern "RiNg AbOvE"
	   When lookup is done with this pattern
	   Then we print results

	@lookup
	Scenario: Lookup symbols by name
	  Given we have a pattern "RING ABOVE"
	   When lookup using all_character_name is done with this pattern
	   Then we print first 2 results

	@lookup
	Scenario: Lookup symbols with tagged character_name
	  Given we have a pattern looking like a tag
	   When lookup using all_character_name is done with this pattern
	   Then we print first 1 results

	@lookup
	Scenario: Lookup tag names using character_name
	  Given we have a pattern looking like a tag
	   When result is filtered to show tags
		 Then the result count equals to 25
	    And we print first 21 results

	@lookup
	Scenario: Lookup tags using character_name
	  Given we have a pattern looking like a tag
	   When result is filtered to show tagged characters
		 Then the result count equals to 25
	    And the result’s first element nested count is "65"

	@lookup
	Scenario: Lookup tags using meta method
	  Given we have a pattern looking like a tag
	   When result is set to response from "control" function call
		 Then the result count equals to 65
	    And we print first 1 results

	@lookup
	Scenario: Print info on symbol
	  Given we have a symbol "〷"
	   When we retrieve it’s info
		 Then we print results
		  And the result is "IDEOGRAPHIC TELEGRAPH LINE FEED SEPARATOR SYMBOL"

	@lookup
	Scenario: Print info on symbol on it’s codebase
	  Given we have a symbol with codebase "0x3037"
	   When we retrieve it’s info
		 Then we print results
			And the result is "IDEOGRAPHIC TELEGRAPH LINE FEED SEPARATOR SYMBOL"

###############################################################################

  @tag
	Scenario: Tag class accepts strings with tag delimiters properly
    Given we have a string "<font>"
     When we construct Tag object against it
     Then both sym and tag have correct values

  @tag
	Scenario: Tag class accepts strings without tag delimiters properly
    Given we have a string "font"
     When we construct Tag object against it
     Then both sym and tag have correct values

  @tag
	Scenario: Tag class rejects strings with improper tags
    Given we have a string "ghgh"
     When we construct Tag object against it
     Then both sym and tag have nil values

	@tag
  Scenario: Decompose symbols
    Given we have a string "Barçelona Niños"
     When we decompose it
     Then we print results
		  And the result is "Barçelona Niños"

  @tag
	Scenario: Decompose symbols with <font>
    Given we have a string "ℂool"
     When we decompose it
     Then we print results
			And the result is "Cool"

  @tag
	Scenario: Decompose symbols with <font>
    Given we have a string "ℂool"
     When we decompose it with circle tag only
     Then we print results
			And the result is "ℂool"

  @tag
	Scenario: Add custom decomposition symbols
    Given we have a string "Мáма"
     When we add custom decomposition rule
      And we decompose it
     Then we print results

###############################################################################

  @compose
	Scenario: Composing digit with circle
    Given we have a string "1"
     When we compose input to "circle"
     Then the result is "①"
      And we print results

	@compose
  Scenario: Composing letter with font
    Given we have a string "a"
     When we compose input to "font"
     Then the result is "𝐚,𝑎,𝒂,𝒶,𝓪,𝔞,𝕒,𝖆,𝖺,𝗮,𝘢,𝙖,𝚊"
      And we print results

  @compose
	Scenario: Composing letter with wide
    Given we have a string "a"
     When we compose input to "wide"
     Then the result is "ａ"
      And we print results

  @compose
	Scenario: Composing letter with super
    Given we have a string "a"
     When we compose input to "super"
     Then we print results
      And the result is "ª,ᵃ"

  @compose
	Scenario: Composing letter with sub
    Given we have a string "a"
     When we compose input to "sub"
     Then we print results
      And the result is "ₐ"

  @compose
	Scenario: Composing letter with vertical
    Given we have a string "?"
     When we compose input to "vertical"
     Then we print results
      And the result is "︖"

  @compose
	Scenario: Composing letter with small
    Given we have a string "?"
     When we compose input to "small"
     Then we print results
      And the result is "﹖"

  @compose
	Scenario: Composing letter with compat
    Given we have a string "µ"
     When we compose input to "compat"
     Then we print results
      And the result is ""

###############################################################################

  @lookup @complex
	Scenario: Code points method missing works on latin letters
    When we call "math" method on Forkforge::CodePoints for "b"
    Then we print results
     And the result to string is "𝐛𝑏𝒃𝒷𝓫𝔟𝕓𝖇𝖻𝗯𝘣𝙗𝚋"

	@lookup @complex
  Scenario: Code points method missing works on strings
    When we call "math" method on Forkforge::CodePoints for "abc"
    Then we print results
     And the result to string is "𝐚𝐛𝐜𝑎𝑏𝑐𝒂𝒃𝒄𝒶𝒷𝒸𝓪𝓫𝓬𝔞𝔟𝔠𝕒𝕓𝕔𝖆𝖇𝖈𝖺𝖻𝖼𝗮𝗯𝗰𝘢𝘣𝘤𝙖𝙗𝙘𝚊𝚋𝚌"

	@lookup @complex
	Scenario: Code points method missing chained works on strings
    When we call "math_fraktur_bold" method on Forkforge::CodePoints for "abc"
    Then we print results
     And the result to string is "𝖆𝖇𝖈"
