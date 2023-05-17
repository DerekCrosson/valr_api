# frozen_string_literal: true

require_relative "valr_api/version"
require 'httparty'
require 'openssl'
require 'faye/websocket'
require 'eventmachine'

module ValrApi
  class Client
    include HTTParty
    base_uri "https://api.valr.com/v1"

    def initialize(api_key, api_secret)
      @api_key = api_key
      @api_secret = api_secret
    end

    def get(endpoint)
      sign_request("GET", endpoint)
      self.class.get(endpoint, headers: headers)
    end

    def post(endpoint, options = {})
      sign_request("POST", endpoint, options)
      self.class.post(endpoint, { body: options, headers: headers })
    end

    def delete(endpoint)
      sign_request("DELETE", endpoint)
      self.class.delete(endpoint, headers: headers)
    end

    private

    def sign_request(verb, path, body = nil)
      timestamp = (Time.now.to_f * 1000).to_i.to_s
      payload = [timestamp, verb, path, body.to_json].compact.join
      @signature = OpenSSL::HMAC.hexdigest("sha512", @api_secret, payload)

      @headers = {
        "X-VALR-API-KEY" => @api_key,
        "X-VALR-SIGNATURE" => @signature,
        "X-VALR-TIMESTAMP" => timestamp,
        "Content-Type" => "application/json"
      }
    end

    def headers
      @headers
    end
  end
end

