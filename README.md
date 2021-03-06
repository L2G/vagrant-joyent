# vagrant-joyent Vagrant plugin

vagrant-joyent is a Vagrant provider for the Joyent Cloud and SmartDatacenter.

## Installation

vagrant-joyent is packaged as a gem on the [central RubyGems
repository](https://rubygems.org/gems/vagrant-joyent), so it can just be
installed with:

    $ vagrant plugin install vagrant-joyent

Chances are, you'll also want to install the basebox for one of the
Joyent images. Currently, only the [base64 13.4.0](http://wiki.joyent.com/wiki/display/jpc2/SmartMachine+Base#SmartMachineBase-13.4.0)
image is supported. It can be installed with:

    $ vagrant box add apetresc/joyent-base64

## Usage

Once the plugin and basebox is installed, you can create a new
Vagrantfile to use with Joyent:

    $ vagrant init apetresc/joyent-base64

Change the configuration as appropriate (see "Configuration" section).

To launch a new instance, use:

    $ vagrant up --provider=joyent

## Configuration

You may add Joyent-specific configuration to your Vagrantfile like this:

```ruby
    config.vm.provider :joyent do |joyent|
      joyent.username = 'my_example_account'
      joyent.api_url = 'https://us-east-1.api.joyentcloud.com'
    end
```

Some variables are required, others are optional. Most of them (including the
required one) may be set in your environment as environment variables (they are
shown below in all caps: `LIKE_THIS`).

### username
  * _required_ (no default value)
  *  The Joyent account to create instances on behalf of.

### api_url
  * _optional_ (default: `JOYENT_API_URL`, `SDC_URL`, or
    "https://us-east-1.api.joyentcloud.com")
  * Corresponds to the Joyent region the instances will be created in.

### keyfile
  * _optional_ (default: value of `JOYENT_SSH_PRIVATE_KEY_PATH` or `SDC_KEY`
  * A local path to the private SSH key file
    corresponding to a public key associated with the Joyent account. If it's
    not specified, you will probably be unable to SSH into a newly-launched
    instance.

### keyname
  * _optional_ (default: value of `SDC_KEY_ID`)
  * The ID of the SSH key, if there is more than
    one associated with your Joyent account. In reality, this is the SSH
    key's fingerprint (16 octets, hexadecimal, comma-delimited:
    xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx).

### password
  * _not recommended_ (default: `JOYENT_PASSWORD`; environment variable is
    preferable for obvious security reasons)
  * The Joyent account password. Only required if `keyfile` is not provided.

## Contributing

### Adding translations

Our translation project is managed on [Locale](http://www.localeapp.com/) and is
open to all.

1. Edit the translations directly on the [vagrant-joyent](http://www.localeapp.com/projects/public?search=vagrant-joyent) project on Locale.
2. **That's it!**
3. The maintainer will then pull translations from the Locale project and push to GitHub.

### Hacking the code

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run `bundle install` to set up a local Vagrant for development
4. Test your changes manually with `bundle exec vagrant up --provider=joyent`
5. (optional) Try the acceptance tests using `bundle exec vagrant-spec`
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request

