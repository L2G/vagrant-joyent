require "log4r"

module VagrantPlugins
  module Joyent
    module Action
      # This action reads the state of the machine and puts it in the
      # `:machine_state_id` key in the environment.
      class ReadState
        NOT_CREATED_STATES = %w(deleted shutting-down terminated)
        NORMAL_STATES      = %w(provisioning running stopped)

        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_joyent::action::read_state")
        end

        def call(env)
          env[:machine_state_id] = read_state(env[:joyent_compute], env[:machine])

          @app.call(env)
        end

        def read_state(joyent, machine)
          return :not_created if machine.id.nil?

          # Find the machine
          server = joyent.servers.get(machine.id)
          return :not_created if server.nil?

          case server.state
          when *NOT_CREATED_STATES
            # The machine can't be found
            @logger.info("Machine not found or terminated, assuming it got destroyed.")
            machine.id = nil
            return :not_created
          when *NORMAL_STATES
            return server.state.to_sym
          else
            # fall through
          end
          
          raise Errors::StateError.new(machine_id: machine.id,
                                       machine_state: server.state)
        end
      end
    end
  end
end
