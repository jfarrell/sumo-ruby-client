#!/usr/bin/env rake
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

require 'bundler/gem_tasks'
require "rake/clean"
require 'rspec/core/rake_task'

task :default => :test
task :test => :spec

desc "Run rspec tests"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--tag ~integration)
end

CLEAN.include ['.bundle', '*.gem', 'coverage']