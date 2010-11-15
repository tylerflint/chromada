require 'spec_helper'

describe User do
  
  describe "permissions" do
    
    after(:each) do
      User.collection.remove
      Company.collection.remove
      Action.collection.remove
      Permission.collection.remove
    end
    
    it "only set when they belong to the company that gets passed with the ids array" do
      user      = Fabricate :user
      facebook  = Fabricate :company
      google    = Fabricate :company, :name => 'google'
      manager   = google.permissions.create(:name => 'manager')
      read_only = facebook.permissions.create(:name => 'reader')
      user.set_permissions(google, [manager.id, read_only.id])
      user.permission_ids.should == [manager.id]
    end
    
    it "removes any that may have previously been set, and aren't in the permission array, belonging to the company that is passed" do
      user      = Fabricate :user
      google    = Fabricate :company, :name => 'google'
      manager   = google.permissions.create(:name => 'manager')
      read_only = google.permissions.create(:name => 'reader')
      user.set_permissions(google, [manager.id, read_only.id])
      user.save
      user1 = User.first
      user1.set_permissions(google, [read_only.id])
      user1.permission_ids.should == [read_only.id]
    end
    
    it "will be unique" do
      user      = Fabricate :user
      google    = Fabricate :company, :name => 'google'
      manager   = google.permissions.create(:name => 'manager')
      user.set_permissions(google, [manager.id])
      user.set_permissions(google, [manager.id])
      user.set_permissions(google, [manager.id])
      user.permission_ids.should == [manager.id]
    end
    
    # it "will not persist on the user after being deleted" do
    #   user      = Fabricate :user
    #   google    = Fabricate :company, :name => 'google'
    #   manager   = google.permissions.create(:name => 'manager')
    #   read_only = google.permissions.create(:name => 'reader')
    #   user.set_permissions(google, [manager.id, read_only.id])
    #   user.save
    #   read_only.destroy
    #   user2 = User.first
    #   user2.permission_ids.should == [manager.id]
    # end
    
    it "converts permissions into an array of ids" do
      company = Fabricate :company
      manager = company.permissions.create :name => 'manager'
      admin   = company.permissions.create :name => 'admin'
      company.permission_ids == [manager.id, admin.id]
    end
    
  end
  
end
