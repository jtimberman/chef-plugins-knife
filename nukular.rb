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
