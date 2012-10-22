require 'chef/knife'

module KnifePlugins
  class GemInstall < Chef::Knife
    deps do
      require 'chef/mixin/shell_out'
      include Chef::Mixin::ShellOut
    end

    banner "knife gem install GEMNAME"

    def run
      knife_gem = shell_out("#{Gem.bindir}/gem install #{name_args[0]}")
      ui.info knife_gem.stdout
    end
  end
end
