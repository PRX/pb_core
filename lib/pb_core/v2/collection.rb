require 'pb_core/v2/base'
require 'pb_core/v2/description_document'

module PBCore
  module V2

    class Collection < PBCore::V2::Base
      collection_group
      elements  'pbcoreDescriptionDocument', :as => :description_documents, :class => PBCore::V2::DescriptionDocument
    end

  end
end
