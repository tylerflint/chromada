class SimpleListPile < Blockpile::Base

  def build(object, collection, options={})
    @object     = object
    @collection = collection
    @options    = options
    @template   = 'admin/shared/simple_list_container'
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
      @collection = @collection.where("`name` LIKE ?", "%#{params[:search]}%")
    end
    @collection = @collection.limit(10) unless show_all?
    @collection.order(:name)
  end
  
  def item_url(company, item)
    if @options[:item_url]
      eval "#{@options[:item_url]} #{item.id}"
    else
      url_for [:edit, :admin, company, item]
    end
  end
  
  def list
    render( :partial => 'admin/shared/simple_list', :locals => {:p => self} )
  end
  
end
