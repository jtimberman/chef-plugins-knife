These are some knife plugins I use.

Installation
============

Clone the repository into `~/.chef/plugins/knife`, or clone it somewhere
else and copy it where you like. If you want to share them in a
collaborative chef-repo, `path/to/chef-repo/.chef/plugins/knife` works.

The Plugins
===========

Here's a simple description and sample use for each plugin.

## gem

This plugin will install a gem into the Ruby environment that knife is
executing in. This is handy if you want to install knife plugins that
are gems.

If you have Ruby and Chef/Knife installed in an area where your user
can write:


```
knife gem install knife-config
```

If you're using an Omnibus package install of Chef, or otherwise
require root access to install:

```
knife gem install knife-config
```

**Note** If you're trying to install a gem for _Chef_ to use, you
  should put it in a `chef_gem` resource in a recipe.

## metadata

This plugin prints out information from a cookbook's metadata. It
currently only works with `metadata.rb` files, and not `metadata.json`
files.

In a cookbook's directory, display the cookbook's dependencies:

```
knife metadata dependencies
```

Show the dependencies and supported platforms:

```
knife metadata dependencies platforms
```

Use the `-P` option to pass a path to a cookbook.

```
knife metadata name dependencies -P ~/.berkshelf/cookbooks/rabbitmq-1.6.4
```

## nukular

[I wrote on this blog about this plugin awhile ago](http://jtimberman.housepub.org/blog/2012/02/15/testing-with-fission/).

This plugin cleans up after running `chef-client` on a VMware Fusion machine.

```
knife nukular guineapig base guineapig.int.example.com
```

## plugin_create

This creates a plugin scaffolding in `~/.chef/plugins/knife`. It will
join underscored words as CamelCaseClasses.

For example,

```
knife plugin create awesometown
```

Creates a plugin that is class `Awesometown` that can be executed with:

```
knife awesometown
```

Whereas this,

```
knife plugin create awesome_town
```

Creates a plugin that is class `AwesomeTown` that can be executed
with:

```
knife plugin awesome town
```

Support
=======

These plugins are not supported by Opscode. They are provided in the
hope that you find them useful.

Contributing
============

If you find a bug:

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

License and Author
==================

Unless otherwise mentioned in the comment heading of individual files,
all these plugins are:

- Author: Joshua Timberman <opensource@housepub.org>
- Copyright: 2012, Joshua Timberman

License: Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
