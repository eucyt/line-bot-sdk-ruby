# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require 'json'

require 'line/bot/v2/http_client'
require 'line/bot/v2/reserved_words'
require 'line/bot/v2/utils'

module Line
  module Bot
    module V2
      module ManageAudience
        class ApiBlobClient
          def initialize(base_url: nil, channel_access_token:, http_options: {})
            @http_client = HttpClient.new(
              base_url: base_url || 'https://api-data.line.me',
              http_headers: {
                Authorization: "Bearer #{channel_access_token}"
              },
              http_options: http_options
            )
          end

          # Add user IDs or Identifiers for Advertisers (IFAs) to an audience for uploading user IDs (by file).
          #
          # @param file A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000 
          # @param audience_group_id The audience ID.
          # @param upload_description The description to register with the job
          # @see https://developers.line.biz/en/reference/messaging-api/#update-upload-audience-group-by-file
          def add_user_ids_to_audience_with_http_info(
            file:,
            audience_group_id: nil,
            upload_description: nil
          )
            path = "/v2/bot/audienceGroup/upload/byFile"

            form_params = {
              "audienceGroupId": audience_group_id,
              "uploadDescription": upload_description,
              "file": file
            }.compact

            response = @http_client.put_form_multipart(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 202
                     response.body
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Add user IDs or Identifiers for Advertisers (IFAs) to an audience for uploading user IDs (by file).
          #
          # @param file A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000 
          # @param audience_group_id The audience ID.
          # @param upload_description The description to register with the job
          # @see https://developers.line.biz/en/reference/messaging-api/#update-upload-audience-group-by-file
          def add_user_ids_to_audience(
            file:,
            audience_group_id: nil,
            upload_description: nil
          )
            response_body, _status_code, _headers = add_user_ids_to_audience_with_http_info(
              file: file,
              audience_group_id: audience_group_id,
              upload_description: upload_description
            )

            response_body
          end

          # Create audience for uploading user IDs (by file).
          #
          # @param file A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000 
          # @param description The audience's name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120 
          # @param is_ifa_audience To specify recipients by IFAs: set `true`. To specify recipients by user IDs: set `false` or omit isIfaAudience property. 
          # @param upload_description The description to register for the job (in `jobs[].description`). 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-upload-audience-group-by-file
          def create_audience_for_uploading_user_ids_with_http_info(
            file:,
            description: nil,
            is_ifa_audience: nil,
            upload_description: nil
          )
            path = "/v2/bot/audienceGroup/upload/byFile"

            form_params = {
              "description": description,
              "isIfaAudience": is_ifa_audience,
              "uploadDescription": upload_description,
              "file": file
            }.compact

            response = @http_client.post_form_multipart(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 202
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ManageAudience::CreateAudienceGroupResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Create audience for uploading user IDs (by file).
          #
          # @param file A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000 
          # @param description The audience's name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120 
          # @param is_ifa_audience To specify recipients by IFAs: set `true`. To specify recipients by user IDs: set `false` or omit isIfaAudience property. 
          # @param upload_description The description to register for the job (in `jobs[].description`). 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-upload-audience-group-by-file
          def create_audience_for_uploading_user_ids(
            file:,
            description: nil,
            is_ifa_audience: nil,
            upload_description: nil
          )
            response_body, _status_code, _headers = create_audience_for_uploading_user_ids_with_http_info(
              file: file,
              description: description,
              is_ifa_audience: is_ifa_audience,
              upload_description: upload_description
            )

            response_body
          end
        end
      end
    end
  end
end
