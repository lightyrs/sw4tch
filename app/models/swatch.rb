class Swatch < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :description, :markup

  validates :name, presence: true
  validates :css, presence: true
  validates :scss, presence: true
  validates :stylus, presence: true

  after_initialize  :assign_markup
  before_validation :set_markup


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
    Sass::Engine.new(css, syntax: :scss).to_tree.to_scss
  end

  def scss_to_css
    Sass::Engine.new(scss, syntax: :scss).to_css
  end

  def css_to_stylus
    Stylus.convert(css)
  end

  def stylus_to_css
    Stylus.compile(stylus)
  end

  # def default_css
  #   ".swatch {\r\n\tcolor: red;\r\n}\r\n\r\n.swatch .specimen {\r\n\t\r\n}\r\n\r\n.swatch .specimen::before {}\r\n\r\n.swatch .specimen::after {}"
  # end

  # def default_scss
  #   ".swatch {\r\n\r\n\t.specimen {\r\n\r\n\t\t&:before {}\r\n\r\n\t\t&:after {}\r\n\t}\r\n}"
  # end

  def default_css
    <<-eos.strip_heredoc

    eos
  end

  def default_scss
    <<-eos.strip_heredoc

    eos
  end

  def default_stylus
    <<-eos.strip_heredoc
    .swatch

      .specimen
        display block

        &:before
          content: ''

        &:after
          content: ''
    eos
  end
end
