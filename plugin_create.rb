#
# Author: Joshua Timberman <opensource@housepub.org>
# Copyright: 2012, Joshua Timberman
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

require 'chef/knife'

module KnifePlugins
  class PluginCreate < Chef::Knife
    deps do
      require 'fileutils'
    end

    banner "knife plugin create PLUGINNAME"

    def run
      class_name = plugin_class
      # TODO: Make this location configurable
      plugin_dir = File.join(ENV["HOME"], ".chef", "plugins", "knife")
      file_name = File.join(plugin_dir, "#{plugin_file}.rb")
      unless ::File.exists?(file_name)
        FileUtils.mkdir_p(plugin_dir)
        file = ::File.open(file_name, "w")
        file.puts plugin_scaffold(plugin_class)
        ui.info plugin_scaffold(plugin_class)
      else
        ui.info "Plugin #{class_name} already exists at #{file_name}"
      end

    end

    def plugin_class
      # TODO: There's methods for making snake case and camelcase
      # strings, but I couldn't use the internet on the plane.
      class_name = ""
      if @name_args.length > 1
        class_name = @name_args.map{|p| p.capitalize}.join
      else
        class_name = @name_args[0].capitalize
      end
      class_name
    end

    def plugin_file
      @name_args.join("_").downcase
    end

    def plugin_scaffold(plugin_class)
      scaffolding = <<-EOP
# You should replace this comment with a license header
# #{plugin_file}
require 'chef/knife'

module KnifePlugins
  class #{plugin_class} < Chef::Knife
    deps do

    end

    banner "knife "

    def run

    end
  end
end
EOP
return scaffolding
    end
  end
end
