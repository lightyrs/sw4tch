class Swatchbook < ActiveRecord::Base

  attr_accessible :name, :description

  belongs_to :user

  has_and_belongs_to_many :swatches, uniq: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
