module Admin::AdminHelper
  
  def admin_grid(object, options={})
    grid = Grid.new(self, object, session, params, options)
    yield grid
    concat grid.to_html
  end
  
  class Grid < Block
    
    def initialize(helper, object, session, params, options={})
      super helper
      @template     = 'admin/grid'
      @id           = :"#{object}_grid"
      @session      = session
      @object_class = convert_to_class object
      @properties   = {:p => 1, :items => 50, :order => 'id,asc'}
      @columns      = {}
      
      # let's set some defaults
      @items_per_page = [25, 50, 100]
      
      # let user override some defaults
      options.each do |k, v|
        instance_variable_set "@#{k}", v
      end
      
      # seed session state with request
      init_state(params)
    end
    
    def add_column(attribute, options)
      @columns[attribute] = options
    end
    
    def get_row_html(entity)
      row = ''
      @columns.each do |k, v|
        row << GridColumn.new(@helper, entity, k, v).to_html
      end
      row
    end
    
  protected
    
    def init_state(params)
      @properties.each do |k, v|
        # see if we have a param
        value = params[k]
        # see if there's already a value set
        value ||= get k
        # set the default
        value ||= v
        set k, value
      end
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
    
    def get_model
      @object_class.find(:all)
    end
    
    def reset
      grid_session = {}
    end
    
    def grid_session
      key = :"#{@id.to_s}"
      @session[key] ||= {} 
      @session[key]
    end
    
  private
    
    def convert_to_class(name)
      name = name.to_s
      name = name.capitalize
      eval "#{name}"
    end
    
    def convert_to_object(name)
      convert_to_class.new
    end
    
  end
  
  class GridColumn < Block
    
    def initialize(helper, entity, attribute, options)
      super helper
      @entity = entity
      @attribute = attribute
      @options = options
      type = options[:type] ||= 'default'
      @template = 'admin/grid/column/' + type
    end
    
    def get_value
      @entity.send @attribute
    end
    
  end
  
end
