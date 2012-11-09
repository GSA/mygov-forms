class Submission < ActiveRecord::Base
  belongs_to :form
  attr_accessible :data
  serialize :data
end
