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

require 'multi_json'
require 'oj'

module Sumologic
  class SearchException < StandardError
  end

  class Client

    attr_accessor :consumer, :request_client
    attr_reader :options

    DEFAULT_OPTIONS = {
        :debug              => false,
        :ssl_verify_mode    => OpenSSL::SSL::VERIFY_NONE,
        :use_ssl            => true,
        :auth_type          => :basic
    }

    DEFAULT_HEADERS = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
    }

    def initialize(options={})
      @options = DEFAULT_OPTIONS.merge(options)
      @request_client = HttpClient.new(@options)
      @options.freeze
    end

    # Issues a search query using the Sumo Logic's search engine.
    #
    # @param [SearchRequest] The search query to be issued
    #
    # @return [SearchResponse] The search result
    def search(search_request=nil)
      url = Sumologic::API_BASE_URL + Sumologic::API_SEARCH_PATH
      resp = @request_client.get(url, search_request.to_hash, DEFAULT_HEADERS)

      raise SearchException, resp.body if resp.code.to_i != 200
      begin
        search_result = MultiJson.load(resp.body)
      rescue Exception => e
        raise SearchException(e)
      end

      SearchResponse.new(search_request, search_result)
    end

  end
end
