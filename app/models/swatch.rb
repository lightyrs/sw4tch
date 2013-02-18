class Swatch < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :description, :markup

  validates :name, presence: true
  validates :markup, presence: true
  validate  :clean_markup

  after_initialize :assign_markup

  def default_markup
    ".swatch {\r\n\t\r\n}\r\n\r\n.swatch .specimen {\r\n\t\r\n}\r\n\r\n.swatch .specimen::before {}\r\n\r\n.swatch .specimen::after {}"
  end

  private

  def assign_markup
    self.markup = default_markup unless markup.present?
  end

  def sanitize_markup
    ActionController::Base.helpers.sanitize_css(markup)
  end

  def clean_markup
    return true if markup.blank?
    return true unless sanitize_markup.blank?
    errors.add(:markup, "must be valid CSS")
  end
end
