class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorization_subject

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true#, :email_format => true

end
