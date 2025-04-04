# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './imagemap_action'

module Line
  module Bot
    module V2
      module MessagingApi
        class MessageImagemapAction < ImagemapAction
          attr_reader :type
          attr_accessor :area
          attr_accessor :text
          attr_accessor :label

          def initialize(
            area:,
            text:,
            label: nil,
            **dynamic_attributes
          )
            @type = "message"
            
            @area = area
            @text = text
            @label = label

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
