class AdminGrid < Blockpile
  
  # def initialize(helper, object, session, params, options={})
  def build(object, options={})
    @object       = object
    @id           = :"#{object}_grid"
    @title        = @object.to_s.capitalize + "s"
    @use_ajax     = false 
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
  
  def get_edit_url(id)
    if @edit_url
      eval "#{@edit_url.to_s}_url #{@parent.id}, #{id}"
    else
      if @url_prefix
        eval "edit_#{@url_prefix}_#{@object.to_s}_url(#{id})"
      else
        eval "edit_#{@object.to_s}_url(#{id})"
      end
    end
  end
  
  def get_new_url
    
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
    if @parent
      @parent.send @object.to_s.pluralize
    else
      @object_class.where
    end
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