# encoding: utf-8

require_relative 'monkeypatches'
require_relative 'unicode_data'

module Forkforge
  
=begin
  <font>    A font variant (e.g. a blackletter form).
  <noBreak>   A no-break version of a space or hyphen.
  <initial>   An initial presentation form (Arabic).
  <medial>    A medial presentation form (Arabic).
  <final>   A final presentation form (Arabic).
  <isolated>    An isolated presentation form (Arabic).
  <circle>    An encircled form.
  <super>   A superscript form.
  <sub>   A subscript form.
  <vertical>    A vertical layout presentation form.
  <wide>    A wide (or zenkaku) compatibility character.
  <narrow>    A narrow (or hankaku) compatibility character.
  <small>   A small variant form (CNS compatibility).
  <square>    A CJK squared font variant.
  <fraction>    A vulgar fraction form.
  <compat>    Otherwise unspecified compatibility character.
=end  
  module CharacterDecompositionMapping
    VARIANTS = {
      :font     => { :character_name => "A font variant (e.g. a blackletter form)",  :general_category => "Yf" },
      :noBreak  => { :character_name => "A no-break version of a space or hyphen",  :general_category => "Yn" },
      :initial  => { :character_name => "An initial presentation form (Arabic)",  :general_category => "Yi" },
      :medial   => { :character_name => "A medial presentation form (Arabic)",  :general_category => "Ym" },
      :final    => { :character_name => "A final presentation form (Arabic)",  :general_category => "Yl" },
      :isolated => { :character_name => "An isolated presentation form (Arabic)",  :general_category => "Ys" },
      :circle   => { :character_name => "An encircled form",  :general_category => "Yc" },
      :super    => { :character_name => "A superscript form",  :general_category => "Yu" },
      :sub      => { :character_name => "A subscript form",  :general_category => "Yb" },
      :vertical => { :character_name => "A vertical layout presentation form",  :general_category => "Yv" },
      :wide     => { :character_name => "A wide (or zenkaku) compatibility character",  :general_category => "Yw" },
      :narrow   => { :character_name => "A narrow (or hankaku) compatibility character",  :general_category => "Yr" },
      :small    => { :character_name => "A small variant form (CNS compatibility)",  :general_category => "Ya" },
      :square   => { :character_name => "A CJK squared font variant",  :general_category => "Yq" },
      :fraction => { :character_name => "A vulgar fraction form",  :general_category => "Yt" },
      :compat   => { :character_name => "Otherwise unspecified compatibility character",  :general_category => "Yo" }
    }
    VARIANTS_UC = VARIANTS.map { |k, v| [ "<#{k}>", v ] }.to_h
     
=begin
  :code_point, 
  :character_name, 
  :general_category,
  :canonical_combining_classes,
  :bidirectional_category,
  :character_decomposition_mapping,
  :decimal_digit_value,
  :digit_value,
  :numeric_value,
  :mirrored,
  :unicode_1_0_name,
  :_10646_comment_field,
  :uppercase_mapping,
  :lowercase_mapping,
  :titlecase_mapping
=end

    # Puts additional decomposition mapping into table
    # Useful entries: name, codepoint, decomposition_lambda, persistent
    def variant name: nil, code_point: nil, decomposition_lambda: nil, persistent: false, \
                character_name: nil, general_category: 'Yy', canonical_combining_classes: nil, \
                bidirectional_category: 'L', character_decomposition_mapping: '<custom>', decimal_digit_value: nil, \
                digit_value: nil, numeric_value: nil, mirrored: nil, unicode_1_0_name: nil, _10646_comment_field: nil, \
                uppercase_mapping: nil, lowercase_mapping:nil, titlecase_mapping: nil
      
    end
    def decomposition_lambda origin, &cb
    end
    extend self
  end
end