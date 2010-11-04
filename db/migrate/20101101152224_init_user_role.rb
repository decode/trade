class InitUserRole < ActiveRecord::Migration
  def self.up
    user = User.create! :name => 'administrator', :password => '000000', :password_confirmation => '000000', :email => 'code723@gmail.com' 
    user.has_role! 'admin'
    user = User.create! :name => 'jjhome', :password => '000000', :password_confirmation => '000000', :email => 'jjh@mail.com' 
    user.has_role! 'user'
  end

  def self.down
    user = User.find_by_name 'administrator'
    user.destroy
    user = User.find_by_name 'jjhome'
    user.destroy
    role = Role.find(0)
    role.destroy
  end
end
