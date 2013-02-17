class Swatch < ActiveRecord::Base

  belongs_to :user

  attr_accessible :name, :description, :markup

  class << self

    def sanitize_markup(markup)
      markup
    end
  end
end
