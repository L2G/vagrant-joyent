# rubocop:disable Style/FileName

# require_relative 'test/acceptance/base'

def relative_to_me(path)
  File.expand_path(path, File.dirname(__FILE__))
end

Vagrant::Spec::Acceptance.configure do |c|
  c.component_paths << relative_to_me('test/acceptance')
  c.skeleton_paths << relative_to_me('test/acceptance/skeletons')

  c.provider 'joyent',
             features: ['!halt', '!suspend'],
             box: relative_to_me('basebox/joyent-base64.box')
end
