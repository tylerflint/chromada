class SimpleListPile < Blockpile::Base

  def build(object, collection, options={})
    @object     = object
    @collection = collection
    @template   = 'admin/shared/simple_list_container'
    if options[:column]
      @column   = (options[:column].match(/,/)) ? "CONCAT(#{options[:column]})" : options[:column]
    end
  end
  
  def object
    @object
  end
  
  def object_label
    object.to_s.capitalize
  end
  
  def collection
    if params[:search]
      @collection.where("#{@column} LIKE ?", "%#{params[:search]}%")
    else
      @collection.limit(10)
    end
  end
  
  def list
    render( :partial => 'admin/shared/simple_list', :locals => {:collection => collection, :name => object_label} )
  end
  
end
