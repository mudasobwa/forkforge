# encoding: utf-8

Feature: UnicodeData.txt file is to be used locally until it’s absent

  Scenario: Create a file in "data" directory with "UnicodeData.txt" content
    Given we have no local copy of the "data/UnicodeData.txt" file
    When the file is requested
    Then the file is got from www.unicode.org/Public/5.1.0/ucd/UnicodeData.txt is printed out

	Scenario: Get all composed symbols
		When we call all_character_decomposition_mapping on Forkforge::UnicodeData
		Then we print a result
	
	Scenario: Get all specific punctuation: connectors
		When we call "connectors" method on Forkforge::Punctuation
		Then we print a result
	
	Scenario: Get all connectors with their names
		When we call "connectors_character_name" method on Forkforge::Punctuation
		Then we print a result
	
	Scenario: Get all specific punctuation: dashes
		When we call "dashes" method on Forkforge::Punctuation
		Then we print a result
	
	Scenario: Get all specific punctuation: opens
		When we call "opens" method on Forkforge::Punctuation
		Then we print a result
	
	Scenario: Get all specific punctuation: closes
		When we call "closes" method on Forkforge::Punctuation
		Then we print a result
	
	Scenario: Get all specific punctuation: initial_quotes
		When we call "initial_quotes" method on Forkforge::Punctuation
		Then we print a result
	
	Scenario: Get all specific punctuation: final_quotes
		When we call "final_quotes" method on Forkforge::Punctuation
		Then we print a result
	
	Scenario: Get all specific punctuation: others
		When we call "others" method on Forkforge::Punctuation
		Then we print a result
	
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

    