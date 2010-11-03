class InitUserRole < ActiveRecord::Migration
  def self.up
    user = User.create! :name => 'admin', :password => '000000', :password_confirmation => '000000', :email => 'code723@gmail.com' 
    user.has_role! 'admin'
    user = User.create! :name => 'jjh', :password => '000000', :password_confirmation => '000000', :email => 'jjh@mail.com' 
    user.has_role! 'user'
  end

  def self.down
    user = User.find_by_name 'admin'
    user.destroy
    user = User.find_by_name 'jjh'
    user.destroy
    role = Role.find(0)
    role.destroy
  end
end
