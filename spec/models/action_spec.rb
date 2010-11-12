require 'spec_helper'

describe Action do
  
  after(:each) do
    Action.collection.remove
  end
  
  it "builds a hierarchial tree" do
    Action.create(:path => "employees")
    Action.create(:path => "employees/create")
    Action.create(:path => "employees/edit")
    Action.create(:path => "employees/delete")
    Action.create(:path => "employees/view")
    Action.create(:path => "employees/view/password")
    Action.create(:path => "billing")
    tree = Action.to_tree
    tree.length.should == 2
    tree['employees'][:children].length.should == 4
    tree['employees'][:children]['view'][:children].length.should == 1
  end
  
end