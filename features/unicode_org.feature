# encoding: utf-8

Feature: UnicodeData.txt file is to be used locally until it’s absent

  Scenario: Create a file in "data" directory with "UnicodeData.txt" content
    Given we have no local copy of the "data/UnicodeData.txt" file
    When the file is requested
    Then the file is got from www.unicode.org/Public/5.1.0/ucd/UnicodeData.txt is printed out

	Scenario: Get all composed symbols
		When we call all_character_decomposition_mapping on Forkforge::UnicodeData
		Then the result count equals to 5405

###############################################################################
	
	Scenario: Get all specific punctuation: connectors
		When we call "connectors" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item equals to "_"
	
	Scenario: Get all specific punctuation: dashes
		When we call "dashes" method on Forkforge::Punctuation
		Then the result count equals to 20
		 And the first item equals to "-"
	
	Scenario: Get all specific punctuation: opens
		When we call "opens" method on Forkforge::Punctuation
		Then the result count equals to 72
		 And the first item equals to "("
	
	Scenario: Get all specific punctuation: closes
		When we call "closes" method on Forkforge::Punctuation
		Then the result count equals to 71
		 And the first item equals to ")"
	
	Scenario: Get all specific punctuation: initial_quotes
		When we call "initial_quotes" method on Forkforge::Punctuation
		Then the result count equals to 12
		 And the first item equals to "«"
	
	Scenario: Get all specific punctuation: final_quotes
		When we call "final_quotes" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item equals to "»"
	
	Scenario: Get all specific punctuation: others
		When we call "others" method on Forkforge::Punctuation
		Then the result count equals to 315
		 And the first item equals to "!"
		 
###############################################################################

	Scenario: Get all connectors with their names
		When we call "connectors_character_name" method on Forkforge::Punctuation
		Then the result count equals to 10
		 And the first item’s value equals to "LOW LINE"
	
	Scenario: Get all dashes with their names
		When we call "dashes_character_name" method on Forkforge::Punctuation
		Then the result count equals to 20
		 And the first item’s value equals to "HYPHEN-MINUS"
	
###############################################################################
	
  Scenario: Upcase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is upcased
    Then the result is "МАМА МЫЛА РАМУ"

  Scenario: Titlecase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is titlecased
    Then the result is "Мама Мыла Раму"

  Scenario: Downcase function works properly on cyrillics
    Given we have a cyrillic string "МАМА мыла РАМУ"
    When the string is downcased
    Then the result is "мама мыла раму"

###############################################################################

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
	    And we print first "1" results
	    
	Scenario: Lookup tags using meta method
	  Given we have a pattern looking like a tag
	   When result is set to response from "control" function call
		 Then the result count equals to 65
	    And we print first "1" results