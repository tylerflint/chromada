module Mother
  
  class << self
  
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