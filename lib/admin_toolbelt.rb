module AdminToolbelt
  
  class Grid
    
    def initialize(object, options={})
      @object       = object
      @object_class = convert_to_class object
      @options      = options
      @columns      = []
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
      "output here"
    end
    
    protected
    
    def reset
      grid_session = {}
    end
    
    def grid_session
      session[:"#{@object.to_s}_grid"]
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