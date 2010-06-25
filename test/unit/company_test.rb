require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  should have_many(:employees)
  should have_many(:roles)
end
