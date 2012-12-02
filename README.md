# HashiCorp Puppet Modules

These are the Puppet modules we use for various things at HashiCorp, such as
provisioning CI machines (masters and slaves), installer build machines for
Vagrant, and more.

I'm well aware that having an all-in-one "modules" repo is looked down upon
versus having a repo-per-puppet-module, but I really didn't want to bloat
the HashiCorp organization with a bajillion puppet modules.

## Compatibility

These Puppet modules are written for Puppet 3.0+.

The operating system of choice for servers at HashiCorp is Ubuntu, so
these modules will generally work very well for that.

However, these modules are also expected to set things like CI slaves up
on a variety of platforms, so some cookbooks may work on more than one
platform. Some even run on Windows.

## Using a Module

Using [librarian-puppet](https://github.com/rodjek/librarian-puppet) is
recommended. You can then easily reference a module in the following way:

```
mod "apt",
  :git => "git://github.com/hashicorp/puppet-modules.git",
  :ref => "c22cf73f80bae622537cd43476ccc157f4f7f24f",
  :path => "modules/apt"
```

It is **highly recommended** that you lock your librarian dependencies
against a specific ref (commit, tag, etc.) of this repository.

If you don't use librarian-puppet, then just download this repository
and copy out what you need. This is looked down upon, but you do what you
need to do.

## Contributing

If you use a module and you find a bug or tunable you'd like to contribute
back, then please just fork and submit a pull request. It is as easy as that.

Contributions are highly welcome, thank you!
