#
# Author:: Joshua Timberman <opensource@housepub.org>
# Copyright:: Copyright (c) 2012, Joshua Timberman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Usage:
#   $ cd ~/Development/opscode/cookbooks/chef-server
#   $ knife metadata name platforms
#     name:  chef-server
#     maintainer:  Opscode, Inc.
#     license:  Apache 2.0

require 'chef/knife'

module KnifePlugins
  class Metadata < Chef::Knife
    deps do
      require 'chef/cookbook/metadata'
    end

    banner "knife metadata ATTRIBUTE"

    option :cookbook_path,
    :short => "-P PATH",
    :long => "--cookbook-path PATH",
    :description => "The path to a cookbook",
    :default => "."

    option :help,
    :short => "-h",
    :long => "--help",
    :description => "Show this message",
    :on => :tail,
    :boolean => true,
    :show_options => true,
    :exit => 0

    def run
      valid_attributes = [
        'name',
        'description',
        'long_description',
        'maintainer',
        'maintainer_email',
        'license',
        'platforms',
        'dependencies',
        'recommendations',
        'suggestions',
        'conflicting',
        'providing',
        'replacing',
        'attributes',
        'groupings',
        'recipes',
        'version'
      ]

      md_path = ::File.join(config[:cookbook_path], "metadata.rb")
      if ! File.exists?(md_path)
        raise "Couldn't find a metadata.rb file. Are you in a cookbook's directory, or did you forget '-P PATH'?"
      end

      if valid_attributes.include?(@name_args[0])
        md = Chef::Cookbook::Metadata.new
        md.from_file(md_path)
        @name_args.each do |attr|
          attribute = {attr.to_sym => md.send(attr.to_sym)}
          ui.output format_for_display(attribute)
        end
      else
        ui.error "You asked for an attribute that isn't allowed in cookbook metadata."
        ui.error "Valid attributes are #{valid_attributes.join(', ')}"
        raise "Invalid argument."
      end

    end
  end
end
