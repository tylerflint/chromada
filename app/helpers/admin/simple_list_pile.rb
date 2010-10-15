class SimpleListPile < Blockpile::Base

  def build(object, collection, options={})
    @object         = object
    @collection     = collection
    @options        = options
    @display_column = options[:display_column] || :name
    @template       = 'admin/shared/simple_list_container'
  end
  
  def show_all?
    params[:show_all] && params[:show_all].eql?('true')
  end
  
  def object
    @object
  end
  
  def object_label
    object.to_s.capitalize
  end
  
  def object_label_plural
    object_label.pluralize
  end
  
  def collection
    if params[:search]
      @collection = @collection.where(@display_column  => /^#{params[:search]}.*/i)
    end
    @collection = @collection.limit(10) unless show_all?
    @collection.asc(@display_column)
  end
  
  def item_url(company, item)
    if @options[:item_url]
      eval "#{@options[:item_url]}('#{item.id}')"
    else
      url_for [:edit, :admin, company, item]
    end
  end
  
  def list
    render( :partial => 'admin/shared/simple_list', :locals => {:p => self} )
  end
  
end
