# PBCore

Gem for working with PBCore 2.0 XML data:
* http://pbcore.org/
* http://www.pbcoreresources.org/

Uses sax-machine (which relies on nokogiri) for parsing:
* https://github.com/pauldix/sax-machine
* http://nokogiri.org/

Created for Pop Up Archive project:
* http://popuparchive.org/
* https://github.com/PRX/pop-up-archive

## Installation

Add this line to your application's Gemfile:

    gem 'pb_core'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pb_core

## Usage

	require 'pb_core'
	f = File.open(some_file)
	doc = PBCore::V2::DescriptionDocument.parse(f)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
