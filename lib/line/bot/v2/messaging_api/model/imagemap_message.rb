# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './message'

module Line
  module Bot
    module V2
      module MessagingApi
        # @see https://developers.line.biz/en/reference/messaging-api/#imagemap-message
        class ImagemapMessage < Message
          attr_reader :type # Type of message
          attr_accessor :quick_reply
          attr_accessor :sender
          attr_accessor :base_url
          attr_accessor :alt_text
          attr_accessor :base_size
          attr_accessor :actions
          attr_accessor :video

          def initialize(
            quick_reply: nil,
            sender: nil,
            base_url:,
            alt_text:,
            base_size:,
            actions:,
            video: nil,
            **dynamic_attributes
          )
            @type = "imagemap"
            
            @quick_reply = quick_reply
            @sender = sender
            @base_url = base_url
            @alt_text = alt_text
            @base_size = base_size
            @actions = actions
            @video = video

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
