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
        class RichMenuResponse
          attr_accessor :rich_menu_id # ID of a rich menu
          attr_accessor :size
          attr_accessor :selected # `true` to display the rich menu by default. Otherwise, `false`.
          attr_accessor :name # Name of the rich menu. This value can be used to help manage your rich menus and is not displayed to users.
          attr_accessor :chat_bar_text # Text displayed in the chat bar
          attr_accessor :areas # Array of area objects which define the coordinates and size of tappable areas

          def initialize(
            rich_menu_id:,
            size:,
            selected:,
            name:,
            chat_bar_text:,
            areas:,
            **dynamic_attributes
          )
            
            @rich_menu_id = rich_menu_id
            @size = size
            @selected = selected
            @name = name
            @chat_bar_text = chat_bar_text
            @areas = areas

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
