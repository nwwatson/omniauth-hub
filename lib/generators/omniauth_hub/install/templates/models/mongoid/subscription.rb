class Subscription < ActiveRecord::Base
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :uid,                 type: String
  field :plan_id,             type: String
  field :plan_key,            type: String
  field :plan_name,           type: String
  field :started_at,          type: Date
  field :canceled_at,         type: Date
  
  attr_accessible :canceled_at, :plan_id, :plan_key, :plan_name, :started_at, :uid
end
