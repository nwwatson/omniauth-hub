class Membership
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user,         foreign_key: "user_id",         class_name: "User"
  belongs_to :organization, foreign_key: "organization_id", class_name: "User"
  
  # Mass-assignment accessors for associations this object belongs to
  attr_accessible :user, :user_id, :organization, :organization_id
end
