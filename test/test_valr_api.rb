# frozen_string_literal: true

require "test_helper"

class TestValrApi < Minitest::Test
  COMMON_HEADERS = {
    "Accept" => "*/*",
    "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
    "Content-Type" => "application/json",
    "User-Agent" => "Ruby"
  }.freeze

  def setup
    @client = ValrApi::Client.new("fake_api_key", "fake_api_secret")

    stub_request(:get, "https://api.valr.com/v1/public/currencies")
      .with { |req| headers_keys_match?(req.headers) }
      .to_return(status: 200, body: [
        {
          "symbol": "R",
          "isActive": true,
          "shortName": "ZAR",
          "longName": "Rand",
          "decimalPlaces": "2",
          "withdrawalDecimalPlaces": "2",
          "collateral": true,
          "collateralWeight": "1"
        },
        {
          "symbol": "BTC",
          "isActive": true,
          "shortName": "BTC",
          "longName": "Bitcoin",
          "decimalPlaces": "8",
          "withdrawalDecimalPlaces": "8",
          "collateral": true,
          "collateralWeight": "0.95"
        },
        {
          "symbol": "ETH",
          "isActive": true,
          "shortName": "ETH",
          "longName": "Ethereum",
          "decimalPlaces": "18",
          "withdrawalDecimalPlaces": "8",
          "collateral": false,
          "collateralWeight": "0.0"
        }
      ].to_json, headers: {})

    stub_request(:post, "https://api.valr.com/v1/orders/limit")
      .with(body: "side=SELL&quantity=0.100000&price=10000&pair=BTCZAR&postOnly=true&customerOrderId=1235") { |req| headers_keys_match?(req.headers) }
      .to_return(status: 202, body: { "id": "558f5e0a-ffd1-46dd-8fae-763d93fa2f25" }.to_json, headers: {})

    stub_request(:delete, "https://api.valr.com/v1/orders/order")
      .with { |req| headers_keys_match?(req.headers) }
      .to_return(status: 200, headers: {})
  end

  def headers_keys_match?(headers)
    COMMON_HEADERS.keys.all? { |key| headers.key?(key) } &&
      headers.key?("X-Valr-Api-Key") &&
      headers.key?("X-Valr-Signature") &&
      headers.key?("X-Valr-Timestamp")
  end

  def test_get_endpoint
    response = @client.get_endpoint("/public/currencies")
    assert response.success?, "GET request failed"
  end

  def test_post_endpoint
    response = @client.post_endpoint("/orders/limit", {
                                       "side": "SELL",
                                       "quantity": "0.100000",
                                       "price": "10000",
                                       "pair": "BTCZAR",
                                       "postOnly": true,
                                       "customerOrderId": "1235"
                                     })
    assert response.success?, "POST request failed"
  end

  def test_delete_endpoint
    response = @client.delete_endpoint("/orders/order")
    assert response.success?, "DELETE request failed"
  end
end
