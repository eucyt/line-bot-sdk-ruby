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
        # A user's membership subscription status
        # @see https://developers.line.biz/en/reference/messaging-api/#get-a-users-membership-subscription-status
        class GetMembershipSubscriptionResponse
          attr_accessor :subscriptions # List of subscription information

          def initialize(
            subscriptions:,
            **dynamic_attributes
          )
            
            @subscriptions = subscriptions

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
