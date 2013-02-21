require 'sass/css'

class Swatch < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :description, :css, :scss, :stylus

  validates :name, presence: true
  validates :css, presence: true
  validates :scss, presence: true
  validates :stylus, presence: true

  after_initialize  :assign_markup

  def assign_markup
    %w(css scss stylus).each do |attr|
      instance_eval "self.#{attr} ||= default_#{attr}"
    end
  end

  def convert_markup(from, to)
    instance_eval("#{from}_to_#{to}")
  end

  def css_to_scss(_css=nil)
    ::Sass::CSS.new(_css||css).render(:scss)
  end

  def css_to_stylus(_css=nil)
    Stylus.convert(_css||css)
  end

  def scss_to_css(_scss=nil)
    Sass::Engine.new(_scss||scss, syntax: :scss).to_css
  end

  def scss_to_stylus
    css_to_stylus scss_to_css
  end

  def stylus_to_css(_stylus=nil)
    Stylus.compile(_stylus||stylus)
  end

  def stylus_to_scss
    css_to_scss stylus_to_css
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
        display: block;

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
        display block

        .specimen
          display block

          &:before
            content ''

          &:after
            content ''
    eos
  end
end
