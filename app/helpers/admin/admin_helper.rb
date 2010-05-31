module Admin::AdminHelper
  
  def admin_grid(object, options={})
    grid = AdminGrid.new(self, object, session, params, options)
    yield grid
    raw grid.to_html
  end
  
end
