# EdinetCode

EDINETからedinetコードリストを取得する

## Installation

Add this line to your application's Gemfile:

    gem 'edinet_code'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install edinet_code

Use headless:
    
    install xvfb

## Usage

    require "edinet_code"

    EdinetCode.get

    EdinetCode.get(false) # do not use headless

    EdinetCode.get_code_exists

## Contributing

1. Fork it ( https://github.com/utahta/edinet_code/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
