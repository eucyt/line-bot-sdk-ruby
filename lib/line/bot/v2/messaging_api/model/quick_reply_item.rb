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
        # @see https://developers.line.biz/en/reference/messaging-api/#items-object
        class QuickReplyItem
          attr_accessor :image_url # URL of the icon that is displayed at the beginning of the button
          attr_accessor :action
          attr_accessor :type # `action`

          def initialize(
            image_url: nil,
            action: nil,
            type: 'action',
            **dynamic_attributes
          )
            
            @image_url = image_url
            @action = action
            @type = type

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
