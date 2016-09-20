class Subscription < ActiveRecord::Base
  attr_accessible :canceled_at, :plan_id, :plan_key, :plan_name, :started_at, :uid
end
