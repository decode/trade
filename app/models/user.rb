class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :name
    #c.validate_login_field = false
  end
  acts_as_authorization_subject

  validates :name,  :presence => true
  validates :email, :presence => true, :uniqueness => true#, :email_format => true
  validates_size_of :name, :password, :within => 6..20

end
