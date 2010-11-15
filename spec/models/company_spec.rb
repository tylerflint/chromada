require 'spec_helper'

describe Company do
  
  after(:each) do
    Company.collection.remove
    User.collection.remove
  end
  
  it "adds an owner" do
    company = Fabricate(:company)
    owner   = Fabricate(:user)
    company.add_owner(owner)
    company.save
    company2 = Company.where(:name => "google").first
    company2.owners.should == [owner.id]
  end
  
  it "removes an owner" do
    company = Fabricate(:company)
    owner   = Fabricate(:user)
    company.add_owner(owner)
    company.save
    company2 = Company.where(:name => "google").first
    company2.drop_owner(owner)
    company2.save
    company3 = Company.where(:name => 'google').first
    company3.owners.should == []
  end
  
  it "tells me if a user is an owner" do
    company = Fabricate(:company)
    owner   = Fabricate(:user)
    user    = Fabricate(:user, :username => "tyler", :email => 'tyler@cmada.com')
    company.add_owner(owner)
    company.add_user(user)
    company.is_owner?(owner).should == true
    company.is_owner?(user).should == false
  end
  
  it "should not have duplicate owners" do
    company = Fabricate(:company)
    owner   = Fabricate(:user)
    company.add_owner(owner)
    company.add_owner(owner)
    company.add_owner(owner)
    company.save
    company2 = Company.where(:name => "google").first
    company2.owners.should == [owner.id]
  end
  
  it "should not have duplicate admin users" do
    company = Fabricate(:company)
    user    = Fabricate(:user)
    company.add_user(user)
    company.add_user(user)
    company.add_user(user)
    company.save
    company2 = Company.where(:name => "google").first
    company2.user_ids.should == [user.id]
  end
  
  it "adds a user" do
    company = Fabricate(:company)
    user    = Fabricate(:user)
    company.add_user(user)
    company.save
    company2 = Company.where(:name => "google").first
    company2.user_ids.should == [user.id]
  end
  
  it "removes a user" do
    company = Fabricate(:company)
    user    = Fabricate(:user)
    company.add_user(user)
    company.save
    company2 = Company.where(:name => "google").first
    company2.drop_user(user)
    company2.save
    company3 = Company.where(:name => 'google').first
    company3.user_ids.should == []
  end
  
  it "converts permissions into an array of ids" do
    company = Fabricate :company
    manager = company.permissions.create :name => 'manager'
    admin   = company.permissions.create :name => 'admin'
    company.permission_ids == [manager.id, admin.id]
  end
  
end
