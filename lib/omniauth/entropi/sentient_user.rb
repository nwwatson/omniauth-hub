module OmniAuth
  module Hub
    module SentientUser
      def self.included(base)
        base.class_eval do
          def self.current
            Thread.current[:user]
          end

          def self.current=(user)
            unless (user.is_a?(self) || user.nil?)
              raise ArgumentError, "Expected an object of class '#{self}', received '#{user.inspect}'"
            end

            Thread.current[:user] = user
          end

          def self.current_organization
            Thread.current[:organization]
          end

          def self.current_organization=(organization)
            unless (organization.is_a?(self) || organization.nil?)
              raise ArgumentError, "Expected an object of class '#{self}', received '#{organization.inspect}'"
            end

            Thread.current[:organization] = organization
          end

          def self.act_as(user, &block)
            original_current = self.current

            begin
              self.current = user
              response = block.call unless block.nil?
            ensure
              self.current = original_current
            end

            response
          end

          def self.act_as_organization(organization, &block)
            original_current_organization = self.current_organization

            begin
              self.current_organization = organization
              response = block.call unless block.nil?
            ensure
              self.current_organization = original_current_organization
            end

            response
          end

          def set_as_current
            Thread.current[:user] = self
          end

          def set_as_current_organization
            Thread.current[:organization] = self
          end

          def current?
            !Thread.current[:user].nil? && self.id == Thread.current[:user].id
          end

          def current_organization?
            !Thread.current[:organization].nil? && self.id == Thread.current[:organization].id
          end
        end
      end
    end
  end
end
