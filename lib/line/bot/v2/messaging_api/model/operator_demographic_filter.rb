# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './demographic_filter'

module Line
  module Bot
    module V2
      module MessagingApi
        class OperatorDemographicFilter < DemographicFilter
          attr_reader :type # Type of demographic filter
          attr_accessor :_and
          attr_accessor :_or
          attr_accessor :_not

          def initialize(
            _and: nil,
            _or: nil,
            _not: nil,
            **dynamic_attributes
          )
            @type = "operator"
            
            @_and = _and
            @_or = _or
            @_not = _not

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key
              instance_variable_set("@#{key}", value)
            end
          end
        end
      end
    end
  end
end
