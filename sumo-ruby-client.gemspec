# -*- encoding: utf-8 -*-
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

libpath = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(libpath) unless $LOAD_PATH.include?(libpath)

require 'sumologic/version'

Gem::Specification.new do |s|
  s.name        = 'sumo-ruby-client'
  s.version     = Sumologic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author = 'engineering@acquia.com'
  s.email = 'engineering@acquia.com'
  s.homepage    = "http://www.acquia.com"
  s.summary     = %q{Ruby Gem to interact with the Sumologic API}
  s.description = %q{Ruby API client for Sumologic}
  s.license     = 'Apache v2'

  s.files = Dir['[A-Z]*', '{bin,lib}/**/*']
  s.require_paths = ['lib']
  s.bindir = 'bin'
  s.executables = Dir['bin/*'].map { |f| File.basename(f) }.select { |f| f =~ /^[\w\-]+$/ }
  s.test_files = Dir['spec/**/*']
  s.has_rdoc = true
  s.extra_rdoc_files = []

  s.add_development_dependency('bundler')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 3.1.0')

  s.add_runtime_dependency('multi_json')
  s.add_runtime_dependency('oj')
  s.add_runtime_dependency('thor')
end

