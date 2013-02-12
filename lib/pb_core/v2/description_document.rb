require 'pb_core/v2/base'
require 'pb_core/v2/instantiation_document'

module PBCore
  module V2

    class DocumentType < PBCore::V2::Base; end

    # pbcoreDescriptionDocument
    class Part < PBCore::V2::DocumentType
      start_end_time_group
    end

    class DocumentType < PBCore::V2::Base
      collection_group

      elements  'pbcoreAssetType', :as => :asset_types, :class => PBCore::V2::Type
      elements  'pbcoreAssetDate', :as => :asset_dates, :class => PBCore::V2::DateType
      elements  'pbcoreIdentifier', :as => :identifiers, :class => PBCore::V2::Identifier
      elements  'pbcoreTitle', :as => :titles, :class => PBCore::V2::Title
      elements  'pbcoreDescription', :as=> :descriptions, :class => PBCore::V2::Description
      elements  'pbcoreSubject', :as=> :subjects, :class => PBCore::V2::Subject
      elements  'pbcoreCoverage', :as => :coverages, :class => PBCore::V2::Coverage
      elements  'pbcoreAudienceLevel', :as => :audience_levels, :class => PBCore::V2::Type
      elements  'pbcoreAudienceRating', :as => :audience_ratings, :class => PBCore::V2::Type
      elements  'pbcoreCreator', :as => :creators, :class => PBCore::V2::Creator
      elements  'pbcoreContributor', :as => :contributors, :class => PBCore::V2::Contributor
      elements  'pbcorePublisher', :as => :publishers, :class => PBCore::V2::Publisher
      elements  'pbcoreRightsSummary', :as => :rights, :class => PBCore::V2::Rights
      elements  'pbcoreInstantiation', :as => :instantiations, :class => PBCore::V2::Instantiation
      elements  'pbcoreAnnotation', :as => :annotations, :class => PBCore::V2::Annotation
      elements  'pbcorePart', :as => :parts, :class => PBCore::V2::Part
    end

    # pbcoreDescriptionDocument
    class DescriptionDocument < PBCore::V2::DocumentType
    end

    class Collection < PBCore::V2::Base
      collection_group
      elements  'pbcoreDescriptionDocument', :as => :description_documents, :class => PBCore::V2::DescriptionDocument
    end

  end
end
