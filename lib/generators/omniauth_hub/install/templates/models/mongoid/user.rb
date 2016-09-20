class User
  include OmniAuth::Hub::SentientUser
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid,             type: String
  field :email,           type: String
  field :name,            type: String
  field :status,          type: String
  field :is_organization, type: Boolean, default: false
  field :is_admin,        type: Boolean, default: false

  has_many :organization_memberships, foreign_key: "user_id",         class_name: "Membership"
  has_many :user_memberships,         foreign_key: "organization_id", class_name: "Membership"

  # has_and_belongs_to_many :organizations, class_name: "User", inverse_of: :users
  # has_and_belongs_to_many :users,         class_name: "User", inverse_of: :organizations

  # Mass-assignment accessors for attributes of this object
  attr_accessible :uid, :email, :name, :status, :is_organization, :is_admin

  # Mass-assignment accessors for associations this object has
  attr_accessible :organization_memberships, :organization_membership_ids, :organizations, :organization_ids, :users, :user_ids

  def self.find_by_uid(uid)
    User.find_by(uid: uid)
  rescue
    nil
  end

  def self.by_is_organization(is_organization)
    where("is_organization = ?", is_organization)
  end
end
