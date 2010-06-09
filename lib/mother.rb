module Mother
  
  class << self
  
    def get_resources
      YAML.load_file( Rails.root.to_s + '/config/acl.yml' )
    end
    
    def get_flat_resources
      self.unwrap(self.get_resources)
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
              items = items | self.unwrap( value, prefix + delim + key )
            else
              items = items | self.unwrap( value, key )
            end
          end
        end
      end
      
      items
    end
    
    # delete after prototyping
    def print_flat
      self.get_flat_resources.each do |item|
        puts "#{item} \n"
      end
    end
    
  end
  
end