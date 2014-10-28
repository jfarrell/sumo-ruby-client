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

module Sumologic
  class SearchRequest
    attr_accessor :query, :timezone, :nodrop
    attr_reader :to, :from

    def initialize(query, to=nil, from=nil, timezone="UTC", nodrop=false)
      @query = query
      @to = (!to.nil?) ? to : Time.now.to_ms
      @from = (!from.nil?) ? from : Time.at(Time.now.to_i - 900).to_ms # 15 min ago
      @timezone = timezone
      @nodrop = nodrop
    end

    def to=(epoch_timestamp)
      @to = epoch_timestamp.to_ms
    end

    def from=(epoch_timestamp)
      @from = epoch_timestamp.to_ms
    end

    def to_hash
      query_string = (@nodrop) ? "#{@query}  nodrop" : @query
      {
        :q => query_string,
        :to => "#{@to}",
        :from => "#{@from}",
        :timezone => @timezone,
        :format => "json",
      }
    end

    def to_h
      to_hash
    end

  end
end