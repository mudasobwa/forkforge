# encoding: utf-8

require 'forkforge/internal/unicode_data'

module Forkforge

=begin
  0:	Spacing, split, enclosing, reordrant, and Tibetan subjoined
  1:	Overlays and interior
  7:	Nuktas
  8:	Hiragana/Katakana voicing marks
  9:	Viramas
  10:	Start of fixed position classes
  199:	End of fixed position classes
  200:	Below left attached
  202:	Below attached
  204:	Below right attached
  208:	Left attached (reordrant around single base character)
  210:	Right attached
  212:	Above left attached
  214:	Above attached
  216:	Above right attached
  218:	Below left
  220:	Below
  222:	Below right
  224:	Left (reordrant around single base character)
  226:	Right
  228:	Above left
  230:	Above
  232:	Above right
  233:	Double below
  234:	Double above
  240:	Below (iota subscript)
=end
  module CanonicalCombiningClasses
    VARIANTS = {
      '0'    => { name: 'Spacing, split, enclosing, reordrant, and Tibetan subjoined' },
      '1'    => { name: 'Overlays and interior' },
      '7'    => { name: 'Nuktas' },
      '8'    => { name: 'Hiragana/Katakana voicing marks' },
      '9'    => { name: 'Viramas' },
      '10'   => { name: 'Start of fixed position classes' },
      '199'  => { name: 'End of fixed position classes' },
      '200'  => { name: 'Below left attached' },
      '202'  => { name: 'Below attached' },
      '204'  => { name: 'Below right attached' },
      '208'  => { name: 'Left attached (reordrant around single base character)' },
      '210'  => { name: 'Right attached' },
      '212'  => { name: 'Above left attached' },
      '214'  => { name: 'Above attached' },
      '216'  => { name: 'Above right attached' },
      '218'  => { name: 'Below left' }
      '220'  => { name: 'Below' },
      '222'  => { name: 'Below right' },
      '224'  => { name: 'Left (reordrant around single base character)' },
      '226'  => { name: 'Right' },
      '228'  => { name: 'Above left' }
      '230'  => { name: 'Above' },
      '232'  => { name: 'Above right' },
      '234'  => { name: 'Double above' },
      '240'  => { name: 'Below (iota subscript)' }
    }

    extend self
  end
end
