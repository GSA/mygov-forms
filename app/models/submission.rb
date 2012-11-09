class Submission < ActiveRecord::Base
  belongs_to :form
  attr_accessible :data
  validates_presence_of :form_id
  serialize :data
end
