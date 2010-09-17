require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should "add company permissions" do
    user    = User.find(1)
    company = Company.find(3)
    user.set_permissions(company, [7,8,9])
    assert_equal( user.permission_ids.sort, [1,2,3,4,5,7,8,9].sort )
  end
  
  should "remove company permissions" do
    user    = User.find(1)
    company = Company.find(1)
    user.set_permissions(company, [1,3])
    assert_equal( user.permission_ids.sort, [1,3,4,5,7].sort )
  end
  
end
