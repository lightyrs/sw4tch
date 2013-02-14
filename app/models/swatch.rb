class Swatch < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :description, :markup
end
