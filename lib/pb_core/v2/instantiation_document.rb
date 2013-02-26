require 'pb_core/v2/base'

module PBCore
  module V2

    class InstantiationType < PBCore::V2::Base
      start_end_time_group

      elements  'instantiationIdentifier', :as => :identifiers, :class => PBCore::V2::Identifier
      elements  'instantiationDate', :as => :dates, :class => PBCore::V2::DateType
      elements  'instantiationDimensions', :as => :dimensions, :class => PBCore::V2::Measurement
      element   'instantiationPhysical', :as => :physical, :class => PBCore::V2::Type
      element   'instantiationDigital', :as => :digital, :class => PBCore::V2::Type
      element   'instantiationStandard', :as => :standard, :class => PBCore::V2::Standard
      element   'instantiationLocation', :as => :location
      element   'instantiationMediaType', :as => :media_type, :class => PBCore::V2::Type
      elements  'instantiationGenerations', :as => :generations, :class => PBCore::V2::Type
      element   'instantiationFileSize', :as => :file_size, :class=> PBCore::V2::Measurement
      element   'instantiationTimeStart', :as => :time_start
      element   'instantiationDuration', :as => :duration
      element   'instantiationDataRate', :as => :data_rate, :class=> PBCore::V2::Measurement
      element   'instantiationColors', :as => :colors, :class=> PBCore::V2::Type
      element   'instantiationTracks', :as => :tracks
      element   'instantiationChannelConfiguration', :as => :channel_configuration
      element   'instantiationLanguage', :as => :language, :class=> PBCore::V2::Type
      element   'instantiationAlternativeModes', :as => :alternative_modes
      elements  'instantiationEssenceTrack', :as => :essence_tracks, :class => PBCore::V2::EssenceTrack
      elements  'instantiationRelation', :as => :relations, :class => PBCore::V2::InstantiationRelation
      elements  'instantiationRights', :as => :rights, :class => PBCore::V2::Rights
      elements  'instantiationAnnotation', :as => :annotations, :class => PBCore::V2::Annotation
      elements  'instantiationExtension', :as => :extensions, :class => PBCore::V2::Extension
      elements  'instantiationPart', :as => :parts, :class => PBCore::V2::InstantiationType
    end

    class Instantiation < PBCore::V2::InstantiationType
    end

    class InstantiationDocument < PBCore::V2::InstantiationType
    end

  end
end
