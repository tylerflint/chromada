module Mother
  
  @company  = nil
  @child    = nil
  @actions  = []
  @is_owner = false
  
  class << self
  
    def may_i?(action)
      raise "no child present" if !@child
      raise "no company present" if !@company
      # @actions.include?(action)
      true
    end
    
    def set_company(company)
      @company = company
    end
    
    def set_child(child)
      @child = child
      # determine_ownership if @child
      # prepare_actions if !@is_owner
    end
    
    def determine_ownership
      company_user = @child.company_users.find_by_company_id(@company.id)
      if company_user.is_owner == 1
        @is_owner = true
      end
    end
    
    def prepare_actions
      @actions = []
      Action.select(:path).joins(:permissions => [ :users ]).where(:permissions => {:company_id => @company.id}, :users => {:id => @child.id}).each do |action|
        @actions << action[:path]
      end
    end
    
    def load_config(yaml=nil, file=nil)
      file ||= 'mother.yml'
      config = YAML.load(yaml) if yaml
      config ||= YAML.load_file( Rails.root.to_s + '/config/' + file )
      raise "Unable to load configuration for Mother" unless config != ""
      config
    end
    
    def get_flat_actions(yaml=nil)
      self.unwrap self.load_config(yaml)
    end
    
    def unwrap(list, prefix='')
      items = []
      delim = "/"
      
      # array
      if list.class == Array
        list.each do |item|
          if item.class == String
            if prefix != ''
              items << prefix + delim + item
            else
              items << item
            end
          else
            items = items | self.unwrap( item, prefix )
          end
        end
      end
      
      # hash
      if list.class == Hash
        list.each do |key, value|
          if value.class == String
            if prefix != ''
              items << prefix + delim + value
            else
              items << value
            end
          else
            if prefix != ''
              items << prefix + delim + key
              items = items | self.unwrap( value, prefix + delim + key )
            else
              items << key
              items = items | self.unwrap( value, key )
            end
          end
        end
      end
      
      items
    end
    
    # def seed_actions(yaml=nil)
    #   actions = self.get_flat_actions(yaml)
    #   Action.destroy_all(["path NOT IN (?)", actions])
    #   actions.each do |action|
    #     Action.find_or_create_by_path(action)
    #   end
    # end
    
    def seed_actions(yaml=nil)
      actions = self.get_flat_actions(yaml)
      Action.destroy_all(["path NOT IN (?)", actions])
      actions.each do |action|
        Action.find_or_create_by_path(action)
      end
    end
    
    # delete after prototyping
    def print_flat
      self.get_flat_actions.each do |item|
        puts "#{item} \n"
      end
    end
    
  end
  
end
