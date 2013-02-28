class Swatchbook < ActiveRecord::Base

  attr_accessible :description

  belongs_to :user

  has_and_belongs_to_many :swatches
end