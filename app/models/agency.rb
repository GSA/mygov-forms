class Agency < ActiveRecord::Base
  attr_accessible :abbreviation, :name
  validates_presence_of :name, :abbreviation
end
