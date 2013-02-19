class Swatch < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :description, :markup

  validates :name, presence: true
  validates :css, presence: true
  validates :scss, presence: true
  validates :stylus, presence: true

  validate  :clean_markup

  after_initialize  :assign_markup
  before_validation :set_markup


  private

  def assign_markup
    %w(css scss stylus).each do |attr|
      instance_eval "self.#{attr} ||= default_#{attr}"
    end
  end

  def set_markup

  end

  def compile_string(from, to)

  end

  def css_to_scss
    Sass::Engine.new(css, syntax: :scss).render
  end

  def scss_to_css
    Sass::Engine.new(scss, syntax: :css).render
  end

  def css_to_stylus
    Stylus.convert(css)
  end

  def stylus_to_css
    Stylus.compile(stylus)
  end

  def default_css
    ".swatch {\r\n\t\r\n}\r\n\r\n.swatch .specimen {\r\n\t\r\n}\r\n\r\n.swatch .specimen::before {}\r\n\r\n.swatch .specimen::after {}"
  end

  def default_scss
    ".swatch {\r\n\r\n\t.specimen {\r\n\r\n\t\t&:before {}\r\n\r\n\t\t&:after {}\r\n\t}\r\n}"
  end

  def default_stylus
    ".swatch\r\n\t.specimen\r\n\t&::before\r\n&::after\r\n"
  end
end
