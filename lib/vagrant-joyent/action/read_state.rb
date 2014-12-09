require "log4r"

module VagrantPlugins
  module Joyent
    module Action
      # This action reads the state of the machine and puts it in the
      # `:machine_state_id` key in the environment.
      class ReadState
        NOT_CREATED_STATES = %w(shutting-down terminated)

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
          if server.nil? || NOT_CREATED_STATES.include?(server.state)
            # The machine can't be found
            @logger.info("Machine not found or terminated, assuming it got destroyed.")
            machine.id = nil
            return :not_created
          end

          # Return the state
          return server.state.to_sym
        end
      end
    end
  end
end
