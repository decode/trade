module RolesHelper
  include Acl9Helpers

  access_control :admin? do
    allow :admin
  end
  access_control :manager? do
    allow :manager
  end
  access_control :guest? do
    allow :guest
  end
end
