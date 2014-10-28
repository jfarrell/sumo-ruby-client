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

$: << File.expand_path(File.dirname(__FILE__))

module Sumologic
  API_VERSION = 1
  API_BASE_URL = "https://api.sumologic.com/api/v#{API_VERSION}"
  API_SEARCH_PATH = "/logs/search"
  API_COLLECTOR_PATH = "/collectors"

  class Time < Time
    def to_ms
      (self.to_f * 1000.0).to_i
    end
  end

end

require 'sumologic/http_client'
require 'sumologic/client'

require 'sumologic/model/search_request'
require 'sumologic/model/search_response'
