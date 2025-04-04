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
        # @see https://developers.line.biz/en/reference/messaging-api/#issue-link-token
        class IssueLinkTokenResponse
          attr_accessor :link_token # Link token. Link tokens are valid for 10 minutes and can only be used once.  

          def initialize(
            link_token:,
            **dynamic_attributes
          )
            
            @link_token = link_token

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
