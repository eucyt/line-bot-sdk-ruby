require 'spec_helper'

describe 'misc' do
  let(:channel_access_token) { 'YOUR_CHANNEL_ACCESS_TOKEN' }

  describe 'Uploading' do
    describe 'Uploading' do
      describe 'POST /v2/bot/audienceGroup/upload/byFile' do
        let(:client) { Line::Bot::V2::ManageAudience::ApiBlobClient.new(channel_access_token: channel_access_token) }
        let(:file_path) { 'spec/fixtures/line/bot/v2/sample_user_ids.txt' }
        let(:file) { File.open(file_path) }

        it 'uploads a file to the audience successfully' do
          stub_request(:put, "https://api-data.line.me/v2/bot/audienceGroup/upload/byFile")
            .with(
              headers: {
                'Authorization' => "Bearer #{channel_access_token}",
                'Content-Type' => %r{multipart/form-data} # webmock doesn't support multipart/form-data so we use regex
              }
            )
            .to_return(status: 202, body: '', headers: {})

          response_body, status_code, headers = client.add_user_ids_to_audience_with_http_info(
            file: file,
            audience_group_id: 1234,
            upload_description: 'Test Audience'
          )

          expect(status_code).to eq(202)
          expect(response_body).to be_empty
        end
      end

      describe 'POST /v2/bot/audienceGroup/upload' do
        let(:client) { Line::Bot::V2::ManageAudience::ApiClient.new(channel_access_token: channel_access_token) }

        it 'uploads a json to the audience successfully' do
          create_audience_group_request = {
            description: 'Test Audience',
          }

          stub_request(:post, "https://api.line.me/v2/bot/audienceGroup/upload")
            .with(
              body: "{\"description\":\"Test Audience\"}",
              headers: {
                'Authorization' => "Bearer #{channel_access_token}",
                'Content-Type' => 'application/json',
              }
            )
            .to_return(status: 202, body: "{\"description\": \"Test Audience response\"}", headers: {})

          response_body, status_code, headers = client.create_audience_group_with_http_info(
            create_audience_group_request: create_audience_group_request
          )

          expect(status_code).to eq(202)
          expect(response_body.description).to eq('Test Audience response')
        end
      end

      describe 'POST /v2/bot/richmenu/{richMenuId}/content' do
        let(:client) { Line::Bot::V2::MessagingApi::ApiBlobClient.new(channel_access_token: channel_access_token) }
        let(:rich_menu_id) { 'test-rich-menu-id' }
        let(:image_path) { 'spec/fixtures/line/bot/v2/test-image.jpeg' }
        let(:image_file) { File.open(image_path, 'rb') }

        it 'uploads an image to the rich menu successfully' do
          stub_request(:post, "https://api-data.line.me/v2/bot/richmenu/#{rich_menu_id}/content")
            .with(
              headers: {
                'Authorization' => "Bearer #{channel_access_token}",
                'Content-Type' => 'image/jpeg' # webmock doesn't support specific image content types so we use regex
              }
            )
            .to_return(status: 200, body: 'Success', headers: { 'Content-Type' => 'application/json' })

          response_body, status_code, headers = client.set_rich_menu_image_with_http_info(
            rich_menu_id: rich_menu_id,
            body: image_file
          )

          expect(status_code).to eq(200)
        end
      end
    end
  end

  describe 'Downloading' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiBlobClient.new(channel_access_token: channel_access_token) }
    let(:message_id) { 'test-message-id' }
    let(:rich_menu_id) { 'test-rich-menu-id' }
    let(:response_body) { 'binary data' }
    let(:response_code) { 200 }

    describe 'GET /v2/bot/message/{messageId}/content' do
      it 'downloads a message content successfully' do
        stub_request(:get, "https://api-data.line.me/v2/bot/message/#{message_id}/content/transcoding")
          .with(
            headers: {
              'Authorization' => "Bearer #{channel_access_token}",
            }
          )
          .to_return(status: response_code, body: { "status" => "ready" }.to_json, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_message_content_transcoding_by_message_id_with_http_info(
          message_id: message_id
        )

        expect(status_code).to eq(200)
        expect(body.status).to eq('ready')
      end
    end

    describe 'GET /v2/bot/richmenu/{richMenuId}/content' do
      it 'downloads a rich menu image successfully' do
        stub_request(:get, "https://api-data.line.me/v2/bot/richmenu/#{rich_menu_id}/content")
          .with(
            headers: {
              'Authorization' => "Bearer #{channel_access_token}",
            }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'image/jpeg' })

        body, status_code, headers = client.get_rich_menu_image_with_http_info(
          rich_menu_id: rich_menu_id
        )

        expect(status_code).to eq(200)
        expect(body).to eq('binary data')
      end
    end
  end

  describe 'GET /v2/bot/insight/followers' do
    let(:client) { Line::Bot::V2::Insight::ApiClient.new(channel_access_token: channel_access_token) }
    let(:response_code) { 200 }

    it 'returns the number of followers successfully (ready status)' do
      response_body = {
        "status" => "ready",
        "followers" => 1000,
        "targetedReaches" => 900,
        "blocks" => 100
      }.to_json

      stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
        .with(
          headers: {
            'Authorization' => "Bearer #{channel_access_token}"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, = client.get_number_of_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.status).to eq('ready')
      expect(body.followers).to eq(1000)
      expect(body.targeted_reaches).to eq(900)
      expect(body.blocks).to eq(100)
    end

    it 'handles the null fields properly (unready status)' do
      response_body = {
        "status" => "unready",
        "followers" => nil,
        "targetedReaches" => nil,
        "blocks" => nil
      }.to_json

      stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
        .with(
          headers: {
            'Authorization' => "Bearer #{channel_access_token}"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, = client.get_number_of_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.status).to eq('unready')
      expect(body.followers).to be_nil
      expect(body.targeted_reaches).to be_nil
      expect(body.blocks).to be_nil
    end
  end

  describe 'GET /v2/bot/message/progress/narrowcast' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: channel_access_token) }
    let(:response_body) do
      # missing errorCode, completedTime, targetCount
      {
        "phase" => "waiting",
        "acceptedTime" => "2020-12-03T10:15:30.121Z"
      }
        .to_json
    end
    let(:response_code) { 200 }

    it 'no problem even when response does not contain some JSON keys' do
      stub_request(:get, "https://api.line.me/v2/bot/message/progress/narrowcast?requestId=7d51557c-7ba0-4ed7-991f-36b2a340dc1a")
        .with(
          headers: {
            'Authorization' => 'Bearer YOUR_CHANNEL_ACCESS_TOKEN',
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'x-line-request-id' => '3a785346-2cf3-482f-8469-c893117fcef8' })

      body, status_code, headers = client.get_narrowcast_progress_with_http_info(
        request_id: '7d51557c-7ba0-4ed7-991f-36b2a340dc1a'
      )

      expect(status_code).to eq(200)
      expect(body.phase).to eq('waiting')
      expect(body.accepted_time).to eq('2020-12-03T10:15:30.121Z')
      expect(body.error_code).to be_nil
      expect(body.completed_time).to be_nil
      expect(body.target_count).to be_nil
    end
  end

  describe 'POST /v2/oauth/accessToken' do
    let(:client) { Line::Bot::V2::ChannelAccessToken::ApiClient.new }
    let(:grant_type) { 'client_credentials' }
    let(:client_id) { 'test-client-id' }
    let(:client_secret) { 'test-client-secret' }
    let(:response_body) { { "access_token" => "test-access-token", "expires_in" => 2592000 }.to_json }
    let(:response_code) { 200 }

    it "doesn't require bearer token" do
      stub_request(:post, "https://api.line.me/v2/oauth/accessToken")
        .with(
          body: { client_id: "test-client-id", client_secret: "test-client-secret", grant_type: "client_credentials" }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.issue_channel_token_with_http_info(
        grant_type: grant_type,
        client_id: client_id,
        client_secret: client_secret
      )

      expect(status_code).to eq(200)
      expect(body.access_token).to eq('test-access-token')
    end
  end

  describe 'GET /v2/bot/followers/ids' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_code) { 200 }

    it 'returns a list of followers successfully without optional parameters' do
      response_body = { "user_ids" => ["U1234567890", "U0987654321"] }.to_json
      stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
    end

    it 'query with only start' do
      response_body = { "user_ids" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json
      stub_request(:get, "https://api.line.me/v2/bot/followers/ids?start=from%20previous%20NEXT")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT")

      expect(status_code).to eq(200)
      expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
      expect(body._next).to eq("nExT Token")
    end

    it 'query with limit and start' do
      response_body = { "user_ids" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json
      stub_request(:get, "https://api.line.me/v2/bot/followers/ids?limit=10&start=from%20previous%20NEXT")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT", limit: 10)

      expect(status_code).to eq(200)
      expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
      expect(body._next).to eq("nExT Token")
    end
  end

  describe 'PUT /liff/v1/apps/{liffId}' do
    let(:client) { Line::Bot::V2::Liff::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { "" } # not empty json, but empty string
    let(:response_code) { 200 }

    it 'empty response body should not throw error' do
      stub_request(:put, "https://api.line.me/liff/v1/apps/test-liff-id")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: {})

      request = Line::Bot::V2::Liff::UpdateLiffAppRequest.new(view: { url: 'https://example.com' })
      body, status_code, headers = client.update_liff_app_with_http_info(liff_id: 'test-liff-id', update_liff_app_request: request)

      expect(status_code).to eq(200)
      expect(body).to eq("")
    end
  end

  describe 'POST /v2/bot/message/push' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) do
      {
        "sentMessages": [
          {
            "id": "461230966842064897",
            "quoteToken": "IStG5h1Tz7b..."
          }
        ]
      }.to_json
    end
    let(:response_code) { 200 }

    it 'response - success' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.push_message_with_http_info(push_message_request: { type: 'text', text: 'Hello, world!' })

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      # TODO: Add test after https://github.com/line/line-bot-sdk-ruby/issues/440 is resolved
      # We should access body.sent_messages[0].id and body.sent_messages[0].quote_token, but it's not possible now.
      expect(body.sent_messages).to eq([{ id: '461230966842064897', quote_token: 'IStG5h1Tz7b...' }])
    end

    it 'request with x_line_retry_key: nil' do
      client = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token-retry-key-nil')
      retry_key = nil
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token-retry-key-nil",
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      client.push_message_with_http_info(push_message_request: { type: 'text', text: 'Hello, world!' }, x_line_retry_key: retry_key)

      expect(WebMock).to(have_requested(:post, "https://api.line.me/v2/bot/message/push")
                           .with { |req| !req.headers.key?("X-Line-Retry-Key") })
    end

    it 'request with  x-line-retry-key header - success' do
      retry_key = 'f03c3eb4-0267-4080-9e65-fffa184e1933'
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.push_message_with_http_info(push_message_request: { type: 'text', text: 'Hello, world!' }, x_line_retry_key: retry_key)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      # TODO: Add test after https://github.com/line/line-bot-sdk-ruby/issues/440 is resolved
      # We should access body.sent_messages[0].id and body.sent_messages[0].quote_token, but it's not possible now.
      expect(body.sent_messages).to eq([{ id: '461230966842064897', quote_token: 'IStG5h1Tz7b...' }])
    end

    it 'request with  x-line-retry-key header - conflicted' do
      retry_key = '2a6e07b0-0fcf-439f-908b-828ed527e882'
      request_id = '3a785346-2cf3-482f-8469-c893117fcef8'
      accepted_request_id = '4a6e07b0-0fcf-439f-908b-828ed527e882'

      error_response_body = {
        "message" => "The retry key is already accepted",
        "sentMessages" => [
          {
            "id" => "461230966842064897",
            "quoteToken" => "IStG5h1Tz7b..."
          }
        ]
      }.to_json
      error_response_headers = {
        'Content-Type' => 'application/json',
        'x-line-request-id' => request_id,
        'x-line-accepted-request-id' => accepted_request_id
      }
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: 409, body: error_response_body, headers: error_response_headers)

      body, status_code, headers = client.push_message_with_http_info(push_message_request: { type: 'text', text: 'Hello, world!' }, x_line_retry_key: retry_key)

      expect(status_code).to eq(409)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::ErrorResponse)
      expect(body.message).to eq("The retry key is already accepted")
      # TODO: Add test after https://github.com/line/line-bot-sdk-ruby/issues/440 is resolved.
      # We should access body.sent_messages[0].id and body.sent_messages[0].quote_token, but it's not possible now.
      expect(body.sent_messages).to eq([{ id: '461230966842064897', quote_token: 'IStG5h1Tz7b...' }])
      expect(headers['x-line-request-id']).to eq(request_id)
      expect(headers['x-line-accepted-request-id']).to eq(accepted_request_id)
    end
  end

  describe 'POST /v2/bot/message/broadcast' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { {}.to_json } # empty json
    let(:response_code) { 200 }

    it 'empty json as response body should not throw error' do
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: { type: 'text', text: 'Hello, world!' })

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end

    it 'request with x_line_retry_key: nil' do
      client = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token-retry-key-nil')
      retry_key = nil
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token-retry-key-nil",
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(broadcast_request: { type: 'text', text: 'Hello, world!' }, x_line_retry_key: retry_key)

      expect(WebMock).to(have_requested(:post, "https://api.line.me/v2/bot/message/broadcast")
                           .with { |req| !req.headers.key?("X-Line-Retry-Key") })
    end

    it 'request with  x-line-retry-key header - success' do
      retry_key = 'f03c3eb4-0267-4080-9e65-fffa184e1933'
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: { type: 'text', text: 'Hello, world!' }, x_line_retry_key: retry_key)

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end

    it 'request with  x-line-retry-key header - conflicted' do
      retry_key = '2a6e07b0-0fcf-439f-908b-828ed527e882'
      request_id = '3a785346-2cf3-482f-8469-c893117fcef8'
      accepted_request_id = '4a6e07b0-0fcf-439f-908b-828ed527e882'

      error_response_body = { "message" => "The retry key is already accepted" }.to_json
      error_response_headers = {
        'Content-Type' => 'application/json',
        'x-line-request-id' => request_id,
        'x-line-accepted-request-id' => accepted_request_id
      }
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: 409, body: error_response_body, headers: error_response_headers)

      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: { type: 'text', text: 'Hello, world!' }, x_line_retry_key: retry_key)

      expect(status_code).to eq(409)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::ErrorResponse)
      expect(body.message).to eq("The retry key is already accepted")
      expect(headers['x-line-request-id']).to eq(request_id)
      expect(headers['x-line-accepted-request-id']).to eq(accepted_request_id)
    end
  end

  describe 'GET /v2/bot/message/aggregation/list' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { { "custom_aggregation_units" => ["unit1", "unit2"], "next" => "token" }.to_json }
    let(:response_code) { 200 }

    it 'returns a list of aggregation units successfully without optional parameters' do
      stub_request(:get, "https://api.line.me/v2/bot/message/aggregation/list")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_aggregation_unit_name_list_with_http_info

      expect(status_code).to eq(200)
      expect(body.custom_aggregation_units).to eq(["unit1", "unit2"])
      expect(body._next).to eq("token")
    end
  end

  describe 'Same endpoint but different HTTP method' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:rich_menu_id) { "richmenuid" }

    describe 'GET /v2/bot/user/all/richmenu' do
      let(:response_body) { { richMenuId: rich_menu_id }.to_json }
      let(:response_code) { 200 }

      it 'returns a default rich menu ID successfully' do
        stub_request(:get, "https://api.line.me/v2/bot/user/all/richmenu")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: response_body, headers: {})

        body, status_code, headers = client.get_default_rich_menu_id_with_http_info

        expect(status_code).to eq(response_code)
        expect(body.rich_menu_id).to eq(rich_menu_id)
      end
    end

    describe 'POST /v2/bot/user/all/richmenu' do
      let(:response_body) { {}.to_json }
      let(:response_code) { 200 }

      it 'sets the default rich menu successfully' do
        stub_request(:post, "https://api.line.me/v2/bot/user/all/richmenu/#{rich_menu_id}")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: '{}', headers: {})

        body, status_code, headers = client.set_default_rich_menu_with_http_info(rich_menu_id: rich_menu_id)

        expect(status_code).to eq(response_code)
        expect(body).to eq(response_body)
      end
    end

    describe 'DELETE /v2/bot/user/all/richmenu' do
      let(:response_body) { {}.to_json }
      let(:response_code) { 200 }

      it 'deletes the default rich menu successfully' do
        stub_request(:delete, "https://api.line.me/v2/bot/user/all/richmenu")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: '{}', headers: {})

        # Call the API method
        body, status_code, headers = client.cancel_default_rich_menu_with_http_info

        # Assertions
        expect(status_code).to eq(200)
        expect(body).to eq(response_body)
      end
    end
  end

  describe 'HTTP Request' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:user_id) { 'u1234567890' }
    let(:response_body) { { displayName: "LINE taro", userId: user_id, language: "en", pictureUrl: "https://profile.line-scdn.net/ch/v2/p/uf9da5ee2b...", statusMessage: "Hello, LINE!" }.to_json }
    let(:response_code) { 200 }

    it 'has correct User-Agent header' do
      path = "https://api.line.me/v2/bot/profile/#{user_id}"
      stub_request(:get, path)
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_profile_with_http_info(user_id: user_id)

      expect(status_code).to eq(response_code)
      expect(body.user_id).to eq(user_id)
      expect(WebMock).to have_requested(:get, path).
        with(headers: { 'User-Agent' => "LINE-BotSDK-Ruby/#{Line::Bot::V2::VERSION}" })
    end
  end

  describe 'Unknown responses' do
    describe 'like unknown fields' do
      describe 'POST /v2/bot/message/reply' do
        let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
        let(:response_body) { { sentMessages: [{ id: "461230966842064897", quoteToken: "IStG5h1Tz7b..." }], invalidField: "foobar" }.to_json }
        let(:response_code) { 200 }

        it 'handles unknown fields in the response' do
          stub_request(:post, "https://api.line.me/v2/bot/message/reply")
            .with(
              headers: {
                'Authorization' => "Bearer test-channel-access-token",
                'Content-Type' => 'application/json'
              },
              body: anything
            )
            .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

          request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
            reply_token: 'test-reply-token',
            messages: [
              Line::Bot::V2::MessagingApi::TextMessage.new(
                text: 'Hello, world!'
              )
            ]
          )

          body, status_code, headers = client.reply_message_with_http_info(
            reply_message_request: request
          )

          expect(status_code).to eq(response_code)
          expect(body.invalid_field).to eq("foobar")
        end
      end
    end
  end

  describe 'Line::Bot::V2::MessagingApi::TemplateMessage#initialize' do
    it "contains fixed type attribute" do
      template_message = Line::Bot::V2::MessagingApi::TemplateMessage.new(
        alt_text: 'Test Alt Text',
        template: Line::Bot::V2::MessagingApi::ButtonsTemplate.new(
          text: 'Test Text',
          actions: [],
          title: 'Test Title'
        )
      )

      expect(template_message.type).to eq('template')
    end
  end
end
