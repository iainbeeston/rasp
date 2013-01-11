require 'securerandom'
require 'active_support/callbacks'

module Rasp
  class Aspect
    def self.before method, opts, &block
      klass = opts[:on]
      method = method.to_sym

      create_callback :before, method, klass, &block
    end

    private

    def self.create_callback type, method, klass, &block
      klass.class_eval do
        # set up callbacks
        callback = "rasp_#{method}_callbacks".to_sym
        include ActiveSupport::Callbacks
        define_callbacks callback
        set_callback callback, type, &block

        # wrap the original method, so it will execute the named callback
        original_method = "_#{method}_#{SecureRandom.uuid.gsub('-', '_')}}".to_sym
        alias_method original_method, method
        define_method method do
          run_callbacks callback do
            send original_method
          end
        end
      end
    end
  end
end

  
