class UserListPile < SimpleListPile
  
  def build(object, collection, options={})
    super(object, collection, options)
    @template = 'admin/users/simple_list_container'
  end
    
  def collection
    if params[:search]
      @collection = @collection.where(@display_column  => /^#{params[:search]}.*/i)
    end
    @collection = @collection.where(:username.ne => current_user.username)
    @collection = @collection.limit(10) unless show_all?
    @collection.asc(@display_column)
  end
    
  def list
    render( :partial => 'admin/users/simple_list', :locals => {:p => self} )
  end
  
end