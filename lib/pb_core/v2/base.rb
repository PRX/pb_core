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

      def detect_element(elements_name, atr=:type, values=nil, use_first=true)
        l = Array(self.send(elements_name))
        values = Array(values)
        return nil if l.size <= 0

        e = nil
        Array(values).each{|v|
          e = l.detect{|i| element_value(i, atr) == standardize(v) }
          break if e
        }
        e = l.first if use_first && e.nil?
        return e
      end

      private

      def element_value(ele, atr)
        standardize(ele.send(atr))
      end

      def standardize(val)
        v = val
        if val && val.is_a?(String)
          v = val.downcase
          v = nil if v == ''
        end
        v
      end

    end



    class Identifier < PBCore::V2::Base
      source_version_group
      value :value
    end

    class Type < PBCore::V2::Base
      source_version_group
      value :value
    end

    class Title < PBCore::V2::Base
      source_version_group
      start_end_time_group
      attribute :titleType, :as => :type
      value :value
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

      value :value
    end

    class DateType < PBCore::V2::Base
      attribute :dateType, :as => :type

      value :value

      def date(format=nil)
        if format
          DateTime.strptime(self.value, format)
        elsif PBCore.config[:date_format]
          DateTime.strptime(self.value, PBCore.config[:date_format])
        else
          DateTime.parse(self.value)
        end
      end

    end

    class Subject < PBCore::V2::Base
      source_version_group
      start_end_time_group

      attribute :subjectType, :as => :type

      value :value
    end

    class Genre < PBCore::V2::Base
      source_version_group
      start_end_time_group    

      value :value
    end

    class Relation < PBCore::V2::Base
      element 'relationType', :as => :type, :class => PBCore::V2::Type
      element 'relationIdentifier', :as => :identifier, :class => PBCore::V2::Identifier
    end

    class CoverageInfo < PBCore::V2::Base
      source_version_group
      start_end_time_group
      value :value
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

      value :value
    end

    class Creator < PBCore::V2::Base
      element 'creator', :as => :name, :class => PBCore::V2::Affiliate
      element 'creatorRole', :as => :role, :class => PBCore::V2::Type
    end

    class ContributorType < PBCore::V2::Base
      source_version_group

      attribute :portrayal

      value :value
    end

    class Contributor < PBCore::V2::Base
      element 'contributor', :as => :name, :class => PBCore::V2::Affiliate
      element 'contributorRole', :as => :role, :class => PBCore::V2::ContributorType
    end

    class Publisher < PBCore::V2::Base
      element 'publisher', :as => :name, :class => PBCore::V2::Affiliate
      element 'publisherRole', :as => :role, :class => PBCore::V2::Type
    end

    class Annotated < PBCore::V2::Base
      attribute :annotation
      value :value
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
      value :value
    end

    class Standard < PBCore::V2::Base
      source_version_group

      attribute :profile
      value :value
    end

    class Annotation < PBCore::V2::Base
      attribute :annotationType, :as => :type
      attribute :ref
      value :value
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
