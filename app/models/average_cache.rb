# == Schema Information
#
# Table name: average_caches
#
#  id            :integer          not null, primary key
#  rater_id      :integer
#  rateable_id   :integer
#  rateable_type :string(255)
#  avg           :float            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class AverageCache < ActiveRecord::Base
  belongs_to :rater, :class_name => "Person"
  belongs_to :rateable, :polymorphic => true
end
