# Channel Access Token API
# This document describes Channel Access Token API.
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
      module ChannelAccessToken
        class ApiClient
          def initialize(base_url: nil, http_options: {})
            @http_client = HttpClient.new(
              base_url: base_url || 'https://api.line.me',
              http_options: http_options
            )
          end

          # Gets all valid channel access token key IDs.
          #
          # @param client_assertion_type `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`
          # @param client_assertion A JSON Web Token (JWT) (opens new window)the client needs to create and sign with the private key.
          # @see https://developers.line.biz/en/reference/messaging-api/#get-all-valid-channel-access-token-key-ids-v2-1
          def gets_all_valid_channel_access_token_key_ids_with_http_info(
            client_assertion_type:,
            client_assertion:
          )
            path = "/oauth2/v2.1/tokens/kid"
            query_params = {
              "client_assertion_type": client_assertion_type,
              "client_assertion": client_assertion
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            response_body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ChannelAccessToken::ChannelAccessTokenKeyIdsResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Gets all valid channel access token key IDs.
          #
          # @param client_assertion_type `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`
          # @param client_assertion A JSON Web Token (JWT) (opens new window)the client needs to create and sign with the private key.
          # @see https://developers.line.biz/en/reference/messaging-api/#get-all-valid-channel-access-token-key-ids-v2-1
          def gets_all_valid_channel_access_token_key_ids(
            client_assertion_type:,
            client_assertion:
          )
            response_body, _status_code, _headers = gets_all_valid_channel_access_token_key_ids_with_http_info(
              client_assertion_type: client_assertion_type,
              client_assertion: client_assertion
            )

            response_body
          end

          # Issue short-lived channel access token
          #
          # @param grant_type `client_credentials`
          # @param client_id Channel ID.
          # @param client_secret Channel secret.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-shortlived-channel-access-token
          def issue_channel_token_with_http_info(
            grant_type:,
            client_id:,
            client_secret:
          )
            path = "/v2/oauth/accessToken"

            form_params = {
              "grant_type": grant_type,
              "client_id": client_id,
              "client_secret": client_secret
            }.compact

            response = @http_client.post_form(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ChannelAccessToken::IssueShortLivedChannelAccessTokenResponse.new(**json)
                   when 400
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ChannelAccessToken::ErrorResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Issue short-lived channel access token
          #
          # @param grant_type `client_credentials`
          # @param client_id Channel ID.
          # @param client_secret Channel secret.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-shortlived-channel-access-token
          def issue_channel_token(
            grant_type:,
            client_id:,
            client_secret:
          )
            response_body, _status_code, _headers = issue_channel_token_with_http_info(
              grant_type: grant_type,
              client_id: client_id,
              client_secret: client_secret
            )

            response_body
          end

          # Issues a channel access token that allows you to specify a desired expiration date. This method lets you use JWT assertion for authentication.
          #
          # @param grant_type client_credentials
          # @param client_assertion_type urn:ietf:params:oauth:client-assertion-type:jwt-bearer
          # @param client_assertion A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-channel-access-token-v2-1
          def issue_channel_token_by_jwt_with_http_info(
            grant_type:,
            client_assertion_type:,
            client_assertion:
          )
            path = "/oauth2/v2.1/token"

            form_params = {
              "grant_type": grant_type,
              "client_assertion_type": client_assertion_type,
              "client_assertion": client_assertion
            }.compact

            response = @http_client.post_form(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ChannelAccessToken::IssueChannelAccessTokenResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Issues a channel access token that allows you to specify a desired expiration date. This method lets you use JWT assertion for authentication.
          #
          # @param grant_type client_credentials
          # @param client_assertion_type urn:ietf:params:oauth:client-assertion-type:jwt-bearer
          # @param client_assertion A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-channel-access-token-v2-1
          def issue_channel_token_by_jwt(
            grant_type:,
            client_assertion_type:,
            client_assertion:
          )
            response_body, _status_code, _headers = issue_channel_token_by_jwt_with_http_info(
              grant_type: grant_type,
              client_assertion_type: client_assertion_type,
              client_assertion: client_assertion
            )

            response_body
          end

          # Issues a new stateless channel access token, which doesn't have max active token limit unlike the other token types. The newly issued token is only valid for 15 minutes but can not be revoked until it naturally expires. 
          #
          # @param grant_type `client_credentials`
          # @param client_assertion_type URL-encoded value of `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`
          # @param client_assertion A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
          # @param client_id Channel ID.
          # @param client_secret Channel secret.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-stateless-channel-access-token
          def issue_stateless_channel_token_with_http_info(
            grant_type: nil,
            client_assertion_type: nil,
            client_assertion: nil,
            client_id: nil,
            client_secret: nil
          )
            path = "/oauth2/v3/token"

            form_params = {
              "grant_type": grant_type,
              "client_assertion_type": client_assertion_type,
              "client_assertion": client_assertion,
              "client_id": client_id,
              "client_secret": client_secret
            }.compact

            response = @http_client.post_form(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Issues a new stateless channel access token, which doesn't have max active token limit unlike the other token types. The newly issued token is only valid for 15 minutes but can not be revoked until it naturally expires. 
          #
          # @param grant_type `client_credentials`
          # @param client_assertion_type URL-encoded value of `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`
          # @param client_assertion A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
          # @param client_id Channel ID.
          # @param client_secret Channel secret.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-stateless-channel-access-token
          def issue_stateless_channel_token(
            grant_type: nil,
            client_assertion_type: nil,
            client_assertion: nil,
            client_id: nil,
            client_secret: nil
          )
            response_body, _status_code, _headers = issue_stateless_channel_token_with_http_info(
              grant_type: grant_type,
              client_assertion_type: client_assertion_type,
              client_assertion: client_assertion,
              client_id: client_id,
              client_secret: client_secret
            )

            response_body
          end

          # Revoke short-lived or long-lived channel access token
          #
          # @param access_token Channel access token
          # @see https://developers.line.biz/en/reference/messaging-api/#revoke-longlived-or-shortlived-channel-access-token
          def revoke_channel_token_with_http_info(
            access_token:
          )
            path = "/v2/oauth/revoke"

            form_params = {
              "access_token": access_token
            }.compact

            response = @http_client.post_form(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 200
                     response.body
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Revoke short-lived or long-lived channel access token
          #
          # @param access_token Channel access token
          # @see https://developers.line.biz/en/reference/messaging-api/#revoke-longlived-or-shortlived-channel-access-token
          def revoke_channel_token(
            access_token:
          )
            response_body, _status_code, _headers = revoke_channel_token_with_http_info(
              access_token: access_token
            )

            response_body
          end

          # Revoke channel access token v2.1
          #
          # @param client_id Channel ID
          # @param client_secret Channel Secret
          # @param access_token Channel access token
          # @see https://developers.line.biz/en/reference/messaging-api/#revoke-channel-access-token-v2-1
          def revoke_channel_token_by_jwt_with_http_info(
            client_id:,
            client_secret:,
            access_token:
          )
            path = "/oauth2/v2.1/revoke"

            form_params = {
              "client_id": client_id,
              "client_secret": client_secret,
              "access_token": access_token
            }.compact

            response = @http_client.post_form(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 200
                     response.body
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Revoke channel access token v2.1
          #
          # @param client_id Channel ID
          # @param client_secret Channel Secret
          # @param access_token Channel access token
          # @see https://developers.line.biz/en/reference/messaging-api/#revoke-channel-access-token-v2-1
          def revoke_channel_token_by_jwt(
            client_id:,
            client_secret:,
            access_token:
          )
            response_body, _status_code, _headers = revoke_channel_token_by_jwt_with_http_info(
              client_id: client_id,
              client_secret: client_secret,
              access_token: access_token
            )

            response_body
          end

          # Verify the validity of short-lived and long-lived channel access tokens
          #
          # @param access_token A short-lived or long-lived channel access token.
          # @see https://developers.line.biz/en/reference/messaging-api/#verify-channel-access-token
          def verify_channel_token_with_http_info(
            access_token:
          )
            path = "/v2/oauth/verify"

            form_params = {
              "access_token": access_token
            }.compact

            response = @http_client.post_form(
              path: path,
              form_params: form_params,
            )

            response_body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ChannelAccessToken::VerifyChannelAccessTokenResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Verify the validity of short-lived and long-lived channel access tokens
          #
          # @param access_token A short-lived or long-lived channel access token.
          # @see https://developers.line.biz/en/reference/messaging-api/#verify-channel-access-token
          def verify_channel_token(
            access_token:
          )
            response_body, _status_code, _headers = verify_channel_token_with_http_info(
              access_token: access_token
            )

            response_body
          end

          # You can verify whether a Channel access token with a user-specified expiration (Channel Access Token v2.1) is valid.
          #
          # @param access_token Channel access token with a user-specified expiration (Channel Access Token v2.1).
          # @see https://developers.line.biz/en/reference/messaging-api/#verify-channel-access-token-v2-1
          def verify_channel_token_by_jwt_with_http_info(
            access_token:
          )
            path = "/oauth2/v2.1/verify"
            query_params = {
              "access_token": access_token
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            response_body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::ChannelAccessToken::VerifyChannelAccessTokenResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # You can verify whether a Channel access token with a user-specified expiration (Channel Access Token v2.1) is valid.
          #
          # @param access_token Channel access token with a user-specified expiration (Channel Access Token v2.1).
          # @see https://developers.line.biz/en/reference/messaging-api/#verify-channel-access-token-v2-1
          def verify_channel_token_by_jwt(
            access_token:
          )
            response_body, _status_code, _headers = verify_channel_token_by_jwt_with_http_info(
              access_token: access_token
            )

            response_body
          end
        end
      end
    end
  end
end
