require 'sass/css'

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

  def convert_string(from, to)
    instance_eval("#{from}_to_#{to}")
  end

  def css_to_scss
    ::Sass::CSS.new(css).render(:scss)
  end

  def css_to_stylus
    Stylus.convert(css)
  end

  def scss_to_css
    Sass::Engine.new(scss, syntax: :scss).to_css
  end

  def stylus_to_css
    Stylus.compile(stylus)
  end

  def default_css
    <<-eos.strip_heredoc
      .swatch {
        display: block;
      }

      .swatch .specimen {
        display: block;
      }

      .swatch .specimen::before {
        content: '';
      }

      .swatch .specimen::after {
        content: '';
      }
    eos
  end

  def default_scss
    <<-eos.strip_heredoc
      .swatch {

        .specimen {
          display: block;

          &::before {
            content: '';
          }

          &::after {
            content: '';
          }
        }
      }
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
