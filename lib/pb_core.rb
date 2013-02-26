require 'sax-machine'

require "pb_core/version"
require 'pb_core/v2/base'
require 'pb_core/v2/instantiation_document'
require 'pb_core/v2/collection'

module PBCore

  # :date_format - For DateType elements, use this format to parse
  def self.config
    @_config ||= {}
  end

end
