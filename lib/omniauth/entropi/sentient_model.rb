# This module can be included in to models which
# you want to scope for a certain user scope. This can
# become helpful when segregatign data for a Sentient User.
# This model sets up the proper default scope, creates the
# belongs to relationship with a user, and add a before_filter
# to set the owning user.
#
# Example Usage
#
# class Contact < ActiveRecord::Base
#   include OmniAuth::Hub::SentientModel
# end
#
module OmniAuth
  module Hub
    module SentientModel
      def self.included(base)
        # Set Default Scope correctly segregate data for current user
        base.default_scope do
          if User.current_organization
            base.where("user_id = ?", User.current_organization.id)
          else
            base.where("user_id = ?", User.current ? User.current.id : nil)
          end
        end

        # Creates a relationship with the owning user.
        base.belongs_to :user

        # Ensure that the current user is set before the model is saved.
        base.before_create :set_user
      end

      private

        # Sets the current user so that
        def set_user
          self.user = User.current_organization ? User.current_organization : User.current
        end
    end
  end
end
