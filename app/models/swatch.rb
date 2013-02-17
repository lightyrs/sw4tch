class Swatch < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :description, :markup

  validates :markup, presence: true

  before_validation :sanitize_markup

  def sanitize_markup
    self.markup = ActionController::Base.helpers.sanitize_css(markup)
  end
end
