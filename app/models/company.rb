class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  embeds_many :employees
end
