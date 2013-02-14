class User < ActiveRecord::Base

  attr_accessible :name

  has_many :identities, :dependent => :destroy
  has_many :swatches

  def avatar
    identities.find(:all, :order => "logged_in_at desc", :limit => 1).first.avatar
  end
end
