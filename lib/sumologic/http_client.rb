#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'net/https'
require 'net/http'
require 'openssl'
require 'cgi'
require 'uri'

module Sumologic
  class HttpClient

    DEFAULT_OPTIONS = {
      :ssl_verify_mode  => OpenSSL::SSL::VERIFY_NONE,
    }

    attr_reader :options

    def initialize(options)
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def delete(path, params={}, headers={})
      request(Net::HTTP::Delete, path, params, headers)
    end

    def get(url, params={}, headers={})
      request(Net::HTTP::Get, url, params, headers)
    end

    def post(url, params={},  headers={}, body=nil)
      request(Net::HTTP::Post, url, params, headers, body)
    end

    def put(url, params={},  headers={}, body=nil)
      request(Net::HTTP::Put, url, params, headers, body)
    end

    def request(http_method, url, params=nil, headers=nil, body=nil)
      uri = URI.parse(url)
      uri.query = params.map { |k,v| "#{k}=#{CGI.escape(v)}" }.join('&') if params

      http = Net::HTTP.new(uri.host, uri.port)
      http.set_debug_output($stdout) if @options['debug']
      http.use_ssl = true if uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = http_method.new(uri.request_uri)
      request.basic_auth(@options['username'], @options['password']) if @options['username'] && @options['password']
      headers.each_pair {|name, value| request[name] = value } if headers
      unless body.nil?
        request.body = body
        request.content_length = body.size
      end
      http.request(request)
    end

  end
end

