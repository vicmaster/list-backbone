class List < ActiveRecord::Base
  attr_accessible :description, :name
  validates_presence_of :description, :name
end
