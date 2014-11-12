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
      font:     { name: 'A font variant (e.g. a blackletter form)' },
      noBreak:  { name: 'A no-break version of a space or hyphen' },
      initial:  { name: 'An initial presentation form (Arabic)' },
      medial:   { name: 'A medial presentation form (Arabic)' },
      final:    { name: 'A final presentation form (Arabic)' },
      isolated: { name: 'An isolated presentation form (Arabic)' },
      circle:   { name: 'An encircled form' },
      super:    { name: 'A superscript form' },
      sub:      { name: 'A subscript form' },
      vertical: { name: 'A vertical layout presentation form' },
      wide:     { name: 'A wide (or zenkaku) compatibility character' },
      narrow:   { name: 'A narrow (or hankaku) compatibility character' },
      small:    { name: 'A small variant form (CNS compatibility)' },
      square:   { name: 'A CJK squared font variant' },
      fraction: { name: 'A vulgar fraction form' },
      compat:   { name: 'Otherwise unspecified compatibility character' }
    }
    VARIANTS_UC = VARIANTS.map { |k, v| [ "<#{k}>", v ] }.to_h

    class Tag
      attr_reader :tag, :sym
      def initialize str
        m = "#{str}".match /^<?(#{VARIANTS.keys.join('|')})>?$/
        @tag, @sym = "<#{m[1]}>", :"#{m[1]}" if MatchData === m
      end
      def valid?
        !@tag.nil? && !@sym.nil?
      end
      def self.tag s
        Tag.new(s)
      end
      def self.tag? s
        self.tag(s).valid?
      end
    end

    extend self
  end
end
