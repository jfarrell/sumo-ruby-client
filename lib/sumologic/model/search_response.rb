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
  class SearchResponse
    attr_accessor :request, :response

    def initialize(request, response)
      @request = request
      @response = response
    end

    def to_json(options)
      MultiJson.dump({ "request" => @request.to_h, "response" => @response }, options)
    end

  end
end