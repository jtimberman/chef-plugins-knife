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
#
# I wrote about this plugin on my blog:
#
# http://jtimberman.housepub.org/blog/2012/02/15/testing-with-fission/

require 'chef/knife'

module KnifePlugins
  class Nukular < Chef::Knife
    deps do
      require 'fission'
      require 'chef/node'
      require 'chef/api_client'
    end

    banner "knife nukular VM SNAPSHOT [NODE]"

    def run
      vm, snapshot = @name_args
      node = @name_args[2].nil? ? vm : @name_args[2]
      Fission::Command::SnapshotRevert.new(args=[vm, snapshot]).execute
      Fission::Command::Start.new(args=[vm]).execute
      begin
        Chef::Node.load(node).destroy
        ui.msg "Deleted node #{node}"
      rescue
        ui.msg "Could not find node #{node}"
      end
      begin
        Chef::ApiClient.load(node).destroy
        ui.msg "Deleted client #{node}"
      rescue
        ui.msg "Could not find client #{node}"
      end
    end
  end
end
