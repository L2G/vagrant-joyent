$:.unshift File.expand_path("../lib", __FILE__)
require "vagrant-joyent/version"

Gem::Specification.new do |s|
  s.name          = "L2G-vagrant-joyent"
  s.version       = VagrantPlugins::Joyent::VERSION
  s.licenses      = ['Apache-2.0']
  s.platform      = Gem::Platform::RUBY
  s.authors       = "Lawrence Leonard Gilbert and friends"
  s.email         = "larry@L2G.to"
  s.homepage      = "http://www.vagrantup.com"
  s.summary       = "Enables Vagrant to manage machines in Joyent cloud and SDC"
  s.description   = <<-EOF
    vagrant-joyent is a Vagrant provider for various Joyent services. It enables
    Vagrant to manage machines in the Joyent cloud using standard commands like
    'up', 'provision', and 'halt'.
  EOF

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "vagrant-joyent"

  s.add_runtime_dependency "fog", "~> 1.12"

  s.add_development_dependency "rake", "~> 10.1"
  s.add_development_dependency "rspec-core", "~> 2.12"
  s.add_development_dependency "rspec-expectations", "~> 2.12"
  s.add_development_dependency "rspec-mocks", "~> 2.12"

  # The following block of code determines the files that should be included
  # in the gem. It does this by reading all the files in the directory where
  # this gemspec is, and parsing out the ignored files from the gitignore.
  # Note that the entire gitignore(5) syntax is not supported, specifically
  # the "!" syntax, but it should mostly work correctly.
  root_path      = File.dirname(__FILE__)
  all_files      = Dir.chdir(root_path) { Dir.glob("**/{*,.*}") }
  all_files.reject! { |file| [".", ".."].include?(File.basename(file)) }
  gitignore_path = File.join(root_path, ".gitignore")
  gitignore      = File.readlines(gitignore_path)
  gitignore.map!    { |line| line.chomp.strip }
  gitignore.reject! { |line| line.empty? || line =~ /^(#|!)/ }

  unignored_files = all_files.reject do |file|
    # Ignore any directories, the gemspec only cares about files
    next true if File.directory?(file)

    # Ignore any paths that match anything in the gitignore. We do
    # two tests here:
    #
    #   - First, test to see if the entire path matches the gitignore.
    #   - Second, match if the basename does, this makes it so that things
    #     like '.DS_Store' will match sub-directories too (same behavior
    #     as git).
    #
    gitignore.any? do |ignore|
      File.fnmatch(ignore, file, File::FNM_PATHNAME) ||
        File.fnmatch(ignore, File.basename(file), File::FNM_PATHNAME)
    end
  end

  s.files         = unignored_files
  s.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
  s.require_path  = 'lib'
end
