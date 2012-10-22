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
