module AdminToolbelt
  
  class Grid
    
    def initialize(object, request_params, options={})
      @id           = :"#{object}_grid"
      @object_class = convert_to_class object
      @columns      = []
      
      # let's set some defaults
      @items_per_page = [25, 50, 100]
      
      # let user override some defaults
      options.each do |k, v|
        instance_variable_set "@#{k}", v
      end
      
      # seed session state with request
      init_state(request_params[@id])
      
    end
    
    def column(options)
      @columns << options
    end
    
    def output
      # html = ''
      #       @columns.each do |c|
      #         html << c[:title]
      #       end
      #       html
      "yo"
    end
    
    protected
    
    def init_state(params)
      session = grid_session
      
      params.each { |key, value| set key, value }
      # now lets set defaults if they don't exist
      
      # current page p=1
      set :p, 1 unless get :p
      
      # items per page items=50
      set :items, 50 unless get :items
      
      # order by order=name,desc
      
      
      # filters filter[attribute] = 'some query'
      
    end
    
    # get session state
    def get(key)
      grid_session[key]
    end
    
    # set session state
    def set(key, value)
      grid_session[key] = value
    end
    
    def reset
      grid_session = {}
    end
    
    def grid_session
      session[:"#{@id.to_s}_grid"]
    end
    
    def convert_to_class(name)
      name = name.to_s
      name = name.capitalize
      eval "#{name}"
    end
    
    def convert_to_object(name)
      convert_to_class.new
    end
    
  end
  
end