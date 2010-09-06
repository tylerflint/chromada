class SimpleListPile < Blockpile::Base

  def build(object, collection, options={})
    @object     = object
    @collection = collection
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
      @collection.where("name LIKE ?", "%#{params[:search]}%")
    end
    @collection.limit(10) unless show_all?
    @collection.order(@column)
  end
  
  def list
    render( :partial => 'admin/shared/simple_list', :locals => {:collection => collection, :name => object_label, :show_all => show_all?} )
  end
  
end
