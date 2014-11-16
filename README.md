# ![logo](https://raw.githubusercontent.com/mudasobwa/forkforge/master/media/ff-64.png) ForkForge Unicode Library

[![Build Status](https://travis-ci.org/mudasobwa/forkforge.png)](https://travis-ci.org/mudasobwa/forkforge)
[![Gemnasium](https://gemnasium.com/mudasobwa/forkforge.png?travis)](https://gemnasium.com/mudasobwa/forkforge)
[![Stories in Ready](https://badge.waffle.io/mudasobwa/forkforge.png?label=ready)](http://waffle.io/mudasobwa/forkforge)

**Status:** Minimum viable product

---

## Features

Easy UTF-8 strings manipulation.

Up-/down-casing:

```ruby
Forkforge::Unicode::uppercase 'istanbul'
#⇒ ISTANBUL
Forkforge::Unicode::uppercase 'istanbul', 'tr'
#⇒ İSTANBUL
Forkforge::UnicodeData::code_points.math 'abc'
#⇒ 𝐚𝐛𝐜𝑎𝑏𝑐𝒂𝒃𝒄𝒶𝒷𝒸𝓪𝓫𝓬𝔞𝔟𝔠𝕒𝕓𝕔𝖆𝖇𝖈𝖺𝖻𝖼𝗮𝗯𝗰𝘢𝘣𝘤𝙖𝙗𝙘𝚊𝚋𝚌
Forkforge::UnicodeData::code_points.math.franktur.bold 'abc'
#⇒ 𝖆𝖇𝖈
Forkforge::UnicodeData::code_points.franktur_math_bold 'abc'
#⇒ 𝖆𝖇𝖈
Forkforge::UnicodeData::compose('1'.codepoints.first, :circle).values.map { |v|
  Forkforge::CodePoint.new(v).to_s
}.join
#⇒ ①
```

The handy methods like `String#compose` and `String#franktur_math` are pending.

---

## Installation

Add this line to your application's Gemfile:

    gem 'forkforge'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install forkforge

## Usage

### Working features:

* uppercase
* lowercase
* titlecase

## Contributing

1. Fork it ( http://github.com/mudasobwa/forkforge/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
