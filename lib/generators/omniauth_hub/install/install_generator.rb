require 'rails/generators'

module OmniauthEntropi
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path('../templates', __FILE__)
      desc "Install the local User model, migration and OmniAuth initializer"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "migrate/create_users.rb",       "db/migrate/create_users.rb"       unless use_mongoid?
        migration_template "migrate/create_memberships.rb", "db/migrate/create_memberships.rb" unless use_mongoid?
      rescue Exception => e
        puts e.message
      end
      
      def copy_models
        if use_mongoid?
          copy_file "models/mongoid/user.rb",             "app/models/user.rb"
          copy_file "models/mongoid/membership.rb",       "app/models/membership.rb"
        else
          copy_file "models/active_record/user.rb",       "app/models/user.rb"
          copy_file "models/active_record/membership.rb", "app/models/membership.rb"
          copy_file "models/active_record/subscription.rb", "app/models/subscription.rb"
        end
      end
      
      def copy_controllers
        copy_file "controllers/user_sessions_controller.rb", "app/controllers/user_sessions_controller.rb"
        copy_file "controllers/organizations_controller.rb", "app/controllers/organizations_controller.rb"
      end
      
      def copy_config
        copy_file "initializers/omniauth.rb", "config/initializers/entropi_omniauth.rb"
      end
      
    private
      
      def use_mongoid?
        defined?(Mongoid) == "constant" && Mongoid.class == Module
      end
    end
  end
end
