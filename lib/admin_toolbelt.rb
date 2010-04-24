module AdminToolbelt
  
  class Grid
    
    def initialize(model, options={})
      @model    = model
      @options  = options
    end
    
    def column(options)
      @columns << options
    end
    
    def output
      html = ''
      @columns.each do |c|
        html << c[:title]
      end
      html
    end
    
  end
  
end