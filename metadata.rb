# You should replace this comment with a license header
# metadata
require 'chef/knife'

module KnifePlugins
  class Metadata < Chef::Knife
    deps do
      require 'chef/cookbook/metadata'
    end

    banner "knife metadata ATTRIBUTE"

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

      if ! File.exists?("metadata.rb")
        raise "Couldn't find a metadata.rb file. Are you in a cookbook's directory?"
      end

      if valid_attributes.include?(@name_args[0])
        md = Chef::Cookbook::Metadata.new
        md.from_file("metadata.rb")
        @name_args.each do |attr|
          attribute = {attr.to_sym => md.send(attr.to_sym)}
          ui.output format_for_display(attribute)
        end
      else
        raise "You asked for an attribute that isn't allowed in cookbook metadata."
      end

    end
  end
end
