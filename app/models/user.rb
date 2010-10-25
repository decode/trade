class User < ActiveRecord::Base
  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true, :email_format => true

  acts_as_authentic do |c|
  end
end
