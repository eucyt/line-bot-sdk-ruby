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
      module ModuleAttach
        # Attach by operation of the module channel provider
        class AttachModuleResponse
          attr_accessor :bot_id # User ID of the bot on the LINE Official Account.
          attr_accessor :scopes # Permissions (scope) granted by the LINE Official Account admin.

          def initialize(
            bot_id:,
            scopes:,
            **dynamic_attributes
          )
            
            @bot_id = bot_id
            @scopes = scopes

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
