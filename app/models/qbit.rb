require 'net/http'
require 'uri'
require 'json'

class Qbit
  class JSONRPCError < RuntimeError; end
  class ConnectionRefusedError < StandardError; end

  def initialize
    @url = 'http://178.79.128.112:8080'
  end

  def http_get_request(url, body)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth uri.user, uri.password
    request.content_type = 'text/plain'
    request.body = body
    reply = JSON.parse(http.request(request).body)
  end

  def handle(url, name, *args)
    body = { 'jsonrpc' => '1.0', 'method' => name, 'params' => args, 'id' => 'curltext' }.to_json
    http_get_request(url, body)
  end

  def gettransaction(txid)
    handle(@url, 'gettransaction', txid)
  end

  def getstate()
    handle(@url, 'getstate')
  end

  def getblock(chain, height)
       handle(@url, 'getblockheaderbyheight', chain, height.to_s)
  end

end
