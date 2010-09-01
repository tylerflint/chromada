class SimpleListPile < Blockpile::Base

  def build(object, options={})
    @object = object
    @template = 'admin/shared/simple_list_container'
  end
  
  def object
    @object
  end
  
  def object_class
    eval "#{@object.to_s.classify}"
  end
  
  def collection
    # collection = object_class
    if params[:search]
      object_class.where("firstname LIKE ? OR lastname LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      object_class.all
    end
    # collection.limit(10)
  end
  
  def list
    render( :partial => 'admin/shared/simple_list', :locals => {:collection => collection} )
  end
  
end