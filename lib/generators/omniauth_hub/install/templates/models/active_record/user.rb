class User < ActiveRecord::Base
  self.primary_key = "uid"

  has_many :organization_memberships, foreign_key: "user_id",         class_name: "Membership"
  has_many :user_memberships,         foreign_key: "organization_id", class_name: "Membership"

  has_many :organizations, through: :organization_memberships, source: :organization
  has_many :users,         through: :user_memberships,         source: :user

  # Mass-assignment accessors for attributes of this object
  attr_accessible :uid, :email, :name, :status, :is_organization, :is_admin

  # Mass-assignment accessors for associations this object has
  attr_accessible :organization_memberships, :organization_membership_ids, :organizations, :organization_ids, :users, :user_ids

  def self.by_is_organization(is_organization)
    where("is_organization = ?", is_organization)
  end
end
