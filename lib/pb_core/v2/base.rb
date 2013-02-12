require 'sax-machine'

module PBCore
  module V2

    module SourceVersionGroup
      def SourceVersionGroup.included(mod)
        mod.attribute :source
        mod.attribute :ref
        mod.attribute :version
        mod.attribute :annotation
      end
    end

    module StartEndTimeGroup
      def StartEndTimeGroup.included(mod)
        mod.attribute :startTime, :as => :start_time
        mod.attribute :endTime, :as => :end_time
        mod.attribute :timeAnnotation, :as => :time_annotation
      end
    end

    module CollectionGroup
      def CollectionGroup.included(mod)
        mod.attribute :collectionTitle, :as => :collection_title
        mod.attribute :collectionDescription, :as => :collection_description
        mod.attribute :collectionSource, :as => :collection_source
        mod.attribute :collectionRef, :as => :collection_ref
        mod.attribute :collectionDate, :as => :collection_date
      end
    end

    class Base
      include SAXMachine

      def self.source_version_group; include PBCore::V2::SourceVersionGroup; end

      def self.start_end_time_group; include PBCore::V2::StartEndTimeGroup; end

      def self.collection_group; include PBCore::V2::CollectionGroup; end

      def self.instantiation_group; include PBCore::V2::InstantiationGroup; end
    end

    class Identifier < PBCore::V2::Base
      source_version_group
    end

    class Type < PBCore::V2::Base
      source_version_group
    end

    class Title < PBCore::V2::Base
      source_version_group
      start_end_time_group

      attribute :titleType, :as => :type
    end

    class Description < PBCore::V2::Base
      start_end_time_group

      attribute :descriptionType, :as => :type
      attribute :descriptionTypeSource, :as => :type_source
      attribute :descriptionTypeRef, :as => :type_ref
      attribute :descriptionTypeVersion, :as => :type_version
      attribute :descriptionTypeAnnotation, :as => :type_annotation

      attribute :segmentType, :as => :segment_type
      attribute :segmentTypeSource, :as => :segment_type_source
      attribute :segmentTypeRef, :as => :segment_type_ref
      attribute :segmentTypeVersion, :as => :segment_type_version
      attribute :segmentTypeAnnotation, :as => :segment_type_annotation

      attribute :annotation
    end

    class DateType < PBCore::V2::Base
      attribute :dateType, :as => :type
    end

    class Subject < PBCore::V2::Base
      source_version_group
      start_end_time_group

      attribute :subjectType, :as => :type
    end

    class Genre < PBCore::V2::Base
      source_version_group
      start_end_time_group    
    end

    class Relation < PBCore::V2::Base
      element 'relationType', :as => :type, :class => PBCore::V2::Type
      element 'relationIdentifier', :as => :identifier, :class => PBCore::V2::Identifier
    end

    class CoverageInfo < PBCore::V2::Base
      source_version_group
      start_end_time_group
    end

    class Coverage < PBCore::V2::Base
      element 'coverage', :as => :info, :class => PBCore::V2::CoverageInfo
      element 'coverageType', :as=> :type
    end

    class Affiliate < PBCore::V2::Base
      start_end_time_group

      attribute :affiliation
      attribute :ref
      attribute :annotation
    end

    class Creator < PBCore::V2::Base
      element 'creator', :as => :name, :class => PBCore::V2::Affiliate
      element 'creatorRole', :as => :role, :class => PBCore::V2::Type
    end

    class ContributorType < PBCore::V2::Base
      source_version_group

      attribute :portrayal
    end

    class Contributor < PBCore::V2::Base
      element 'contributer', :as => :name, :class => PBCore::V2::Affiliate
      element 'contributerRole', :as => :role, :class => PBCore::V2::ContributorType
    end

    class Publisher < PBCore::V2::Base
      element 'publisher', :as => :name, :class => PBCore::V2::Affiliate
      element 'publisherRole', :as => :role, :class => PBCore::V2::Type
    end

    class Annotated < PBCore::V2::Base
      attribute :annotation
    end

    class Rights < PBCore::V2::Base
      start_end_time_group

      element 'rightsSummary', :as => :summary, :class => PBCore::V2::Type
      element 'rightsLink', :as => :link, :class => PBCore::V2::Annotated
      element 'rightsEmbedded', :as => :embedded, :class => PBCore::V2::Annotated
    end

    class Measurement < PBCore::V2::Base
      attribute :annotation
      attribute :unitsOfMeasure, :as => :units
    end

    class Standard < PBCore::V2::Base
      source_version_group

      attribute :profile
    end

    class Annotation < PBCore::V2::Base
      attribute :annotationType, :as => :annotation_type
      attribute :ref
    end

    class ExtensionWrap < PBCore::V2::Base
      attribute :annotation

      element   'extensionElement', :as => :element
      element   'extensionValue', :as => :value
      element   'extensionAuthorityUsed', :as => :authority_used
    end

    class Extension < PBCore::V2::Base
      element   'extensionWrap', :as => :wrap, :class => PBCore::V2::ExtensionWrap
      element   'extensionEmbedded', :as => :embedded, :class => PBCore::V2::Annotated
    end

    class EssenceTrack < PBCore::V2::Base
      element   'essenceTrackType', :as => :type
      elements  'essenceTrackIdentifier', :as => :identifiers, :class => PBCore::V2::Identifier
      element   'essenceTrackStandard', :as => :standard, :class => PBCore::V2::Type
      element   'essenceTrackEncoding', :as => :encoding, :class => PBCore::V2::Type
      element   'essenceTrackDataRate', :as => :data_rate, :class => PBCore::V2::Measurement
      element   'essenceTrackFrameRate', :as => :frame_rate, :class => PBCore::V2::Measurement
      element   'essenceTrackPlaybackSpeed', :as => :playback_speed, :class => PBCore::V2::Measurement
      element   'essenceTrackSamplingRate', :as => :sampling_rate, :class => PBCore::V2::Measurement
      element   'essenceTrackBitDepth', :as => :bit_depth
      element   'essenceTrackFrameSize', :as => :frame_size, :class => PBCore::V2::Type
      element   'essenceTrackAspectRatio', :as => :aspect_ration, :class => PBCore::V2::Type
      element   'essenceTrackTimeStart', :as => :time_start
      element   'essenceTrackDuration', :as => :duration
      element   'essenceTrackLanguage', :as => :language, :class => PBCore::V2::Type
      element   'essenceTrackAnnotation', :as => :annotation, :class => PBCore::V2::Annotation
      elements  'essenceTrackExtension', :as => :extensions, :class =>PBCore::V2::Extension
    end

    class InstantiationRelation < PBCore::V2::Base
      element 'instantiationRelationType', :as => :type, :class => PBCore::V2::Type
      element 'instantiationRelationIdentifier', :as => :identifier, :class => PBCore::V2::Identifier
    end

  end
end
