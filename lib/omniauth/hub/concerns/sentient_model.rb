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
      extend ActiveSupport::Concern

      included do
        belongs_to :user

        scope :for_user, ->(user_id) { where(user_id: user_id)}
      end

    end
  end
end
