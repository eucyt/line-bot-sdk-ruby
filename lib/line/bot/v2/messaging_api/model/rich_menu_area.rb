# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module MessagingApi
        # Rich menu area
        class RichMenuArea
          attr_accessor :bounds
          attr_accessor :action

          def initialize(
            bounds: nil,
            action: nil,
            **dynamic_attributes
          )
            
            @bounds = bounds
            @action = action

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
