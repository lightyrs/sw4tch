require 'sass/css'
require 'compass'

class Swatch < ActiveRecord::Base

  belongs_to :user

  has_and_belongs_to_many :swatchbooks, uniq: true

  attr_accessible :name, :description, :css, :scss, :stylus, :tag_list

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :css, presence: true
  validates :scss, presence: true
  validates :stylus, presence: true

  after_initialize  :assign_markup
  before_validation :assign_latest

  acts_as_taggable

  def to_image

  end

  def assign_markup
    %w(css scss stylus).each do |attr|
      instance_eval "self.#{attr} ||= default_#{attr}"
    end
  end

  def assign_latest
    self.scss = css_to_scss
    self.stylus = css_to_stylus
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
    _scss ||= scss
    _scss = import_compass(_scss) if _scss.include? '@include'
    Sass::Engine.new("#{_scss}", sass_options).to_css
  end

  def scss_to_stylus
    css_to_stylus scss_to_css
  end

  def stylus_to_css(_stylus=nil)
    _stylus ||= stylus
    _stylus = import_nib(_stylus)
    Stylus.compile("#{_stylus}")
  end

  def stylus_to_scss
    css_to_scss stylus_to_css
  end

  def sass_options
    Compass.configuration.to_sass_engine_options.merge(syntax: :scss, line_comments: false)
  end

  def import_nib(markup)
    Stylus.use :nib
    "@import 'nib';#{markup}"
  end

  def import_compass(markup)
    "@import 'compass/css3';#{markup}"
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
