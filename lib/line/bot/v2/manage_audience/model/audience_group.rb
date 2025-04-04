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
      module ManageAudience
        # Audience group
        class AudienceGroup
          attr_accessor :audience_group_id # The audience ID.
          attr_accessor :type
          attr_accessor :description # The audience's name.
          attr_accessor :status
          attr_accessor :failed_type
          attr_accessor :audience_count # The number of users included in the audience.
          attr_accessor :created # When the audience was created (in UNIX time).
          attr_accessor :request_id # The request ID that was specified when the audience was created. This is only included when `audienceGroup.type` is CLICK or IMP. 
          attr_accessor :click_url # The URL that was specified when the audience was created. This is only included when `audienceGroup.type` is CLICK and link URL is specified. 
          attr_accessor :is_ifa_audience # The value indicating the type of account to be sent, as specified when creating the audience for uploading user IDs. 
          attr_accessor :permission
          attr_accessor :create_route

          def initialize(
            audience_group_id: nil,
            type: nil,
            description: nil,
            status: nil,
            failed_type: nil,
            audience_count: nil,
            created: nil,
            request_id: nil,
            click_url: nil,
            is_ifa_audience: nil,
            permission: nil,
            create_route: nil,
            **dynamic_attributes
          )
            
            @audience_group_id = audience_group_id
            @type = type
            @description = description
            @status = status
            @failed_type = failed_type
            @audience_count = audience_count
            @created = created
            @request_id = request_id
            @click_url = click_url
            @is_ifa_audience = is_ifa_audience
            @permission = permission
            @create_route = create_route

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
