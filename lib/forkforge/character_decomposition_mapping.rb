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
      :super    => { :character_name => "A superscript form",  :general_category => "Yp" },
      :sub      => { :character_name => "A subscript form",  :general_category => "Yb" },
      :vertical => { :character_name => "A vertical layout presentation form",  :general_category => "Yv" },
      :wide     => { :character_name => "A wide (or zenkaku) compatibility character",  :general_category => "Yz" },
      :narrow   => { :character_name => "A narrow (or hankaku) compatibility character",  :general_category => "Yh" },
      :small    => { :character_name => "A small variant form (CNS compatibility)",  :general_category => "Ya" },
      :square   => { :character_name => "A CJK squared font variant",  :general_category => "Yq" },
      :fraction => { :character_name => "A vulgar fraction form",  :general_category => "Yt" },
      :compat   => { :character_name => "Otherwise unspecified compatibility character",  :general_category => "Yo" }
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
