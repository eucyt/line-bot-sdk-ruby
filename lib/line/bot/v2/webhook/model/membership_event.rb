# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './event'

module Line
  module Bot
    module V2
      module Webhook
        # This event indicates that a user has subscribed (joined), unsubscribed (left), or renewed the bot's membership.
        class MembershipEvent < Event
          attr_reader :type # Type of the event
          attr_accessor :source
          attr_accessor :timestamp # Time of the event in milliseconds.
          attr_accessor :mode
          attr_accessor :webhook_event_id # Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          attr_accessor :delivery_context
          attr_accessor :reply_token # Reply token used to send reply message to this event
          attr_accessor :membership

          def initialize(
            type:,
            source: nil,
            timestamp:,
            mode:,
            webhook_event_id:,
            delivery_context:,
            reply_token:,
            membership:,
            **dynamic_attributes
          )
            @type = "membership"
            
            @source = source
            @timestamp = timestamp
            @mode = mode
            @webhook_event_id = webhook_event_id
            @delivery_context = delivery_context
            @reply_token = reply_token
            @membership = membership

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
