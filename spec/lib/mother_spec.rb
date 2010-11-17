require 'spec_helper'

describe Mother do

  describe "authorization" do
    
    after(:each) do
      Action.collection.remove
      Permission.collection.remove
      Company.collection.remove
      User.collection.remove
    end
    
    it "allows owner to do anything and everything" do
      company = Fabricate :company
      owner   = Fabricate :user
      company.add_owner(owner)
      mother = Mother.new(company, owner)
      mother.may_i?('anything_i_want').should == true
    end

    it "raises exception when child is not set" do
      company = Fabricate :company
      lambda {
        mother = Mother.new(company)
        mother.may_i?('employees/delete')
      }.should raise_error
    end

    it "raises exception when company is not set" do
      user = Fabricate :user
      lambda {
        mother = Mother.new(nil, user)
        mother.may_i?('employees/delete')
      }.should raise_error
    end

    it "raises exception when child does not have id" do
      company = Fabricate :company
      lambda {
        mother = Mother.new(company, 1)
        mother.may_i?('employees/delete')
      }.should raise_error
    end

    it "raises exception when company does not have id" do
      user = Fabricate :user
      lambda {
        mother = Mother.new(1, user)
        mother.may_i?('employees/delete')
      }.should raise_error
    end

    it "allows when have permission" do
      owner   = Fabricate :user
      user    = Fabricate :user, :username => 'user1', :email => 'user1@cmada.com'
      company = Fabricate :company
      read    = Fabricate :action, :path => 'read'
      write   = Fabricate :action, :path => 'write'
      manager = company.permissions.create(:name => 'manager')
      peeon   = company.permissions.create(:name => 'peeon')
      
      manager.actions << write
      manager.actions << read
      peeon.actions << read
      
      company.add_owner(owner)
      company.add_user(user)
      
      user.set_permissions(company, [manager.id])
      
      mother = Mother.new(company, user)
      mother.may_i?('read').should == true
      mother.may_i?('write').should == true
    end

    it "denys when doesn't have permission" do
      owner   = Fabricate :user
      user    = Fabricate :user, :username => 'user1', :email => 'user1@cmada.com'
      company = Fabricate :company
      read    = Fabricate :action, :path => 'read'
      write   = Fabricate :action, :path => 'write'
      manager = company.permissions.create(:name => 'manager')
      peeon   = company.permissions.create(:name => 'peeon')
      
      manager.actions << write
      manager.actions << read
      peeon.actions << read
      
      company.add_owner(owner)
      company.add_user(user)
      
      user.set_permissions(company, [peeon.id])
      
      mother = Mother.new(company, user)
      mother.may_i?('write').should == false
    end
    
  end
  
  describe "config" do
    
    after(:each) do
      Action.collection.remove
    end
    
    it "throws an error if unable to load config" do
      lambda { Mother.load_config("", 'fake.yml') }.should raise_error Errno::ENOENT
    end

    it "doesn't throw an error if able to load config" do
      lambda { Mother.load_config() }.should_not raise_error Errno::ENOENT
    end

    it "returns a flattened array of yaml tree" do
      Mother.get_flat_actions.class.should == Array
    end

    it "separates tree levels with a /" do
      flattened = Mother.get_flat_actions(get_valid_config)
      flattened[1].should == 'employee/create'
    end

    it "doesn't have a leading / on any actions" do
      flattened = Mother.get_flat_actions(get_valid_config)
      count = 0
      flattened.each do |flat|
        count += 1 if flat.match /^\//
      end
      0.should == count
    end

    it "doesn't have a trailing / on any of the actions" do
      flattened = Mother.get_flat_actions(get_valid_config)
      count = 0
      flattened.each do |flat|
        count += 1 if flat.match /\/$/
      end
      0.should == count
    end

    it "maintains an accurate count of flattened actions relative to tree" do
      flattened = Mother.get_flat_actions(get_valid_config)
      13.should == flattened.length
    end

    it "seeds actions table from flattened tree" do
      Mother.seed_actions( get_valid_config )
      13.should == Action.all.length
    end

    it "doesn't remove actions when same" do
      Mother.seed_actions( get_valid_config )
      original_action = Action.where(:path => 'employee/create/delete').first
      Mother.seed_actions( get_valid_config )
      action = Action.where(:path => 'employee/create/delete').first
      original_action.should == action
    end

    it "removes actions not included in the tree" do
      Mother.seed_actions( get_valid_config )
      Mother.seed_actions( get_partial_config )
      0.should == Action.where(:path => 'employee/edit/lastname').length.should
    end

  end
  
  protected
  
  def get_valid_config
    %{
      - employee:
          - create
          - delete
          - view:
              - firstname
              - lastname
          - edit:
              - firstname
              - lastname

      - role:
          - create
          - delete
          - edit
    }
  end

  def get_partial_config
    %{
      - employee:
          - create
          - delete
          - view:
              - firstname
              - lastname
          - edit:
              - firstname

      - role:
          - create
          - delete
          - edit
    }
  end
  
end
