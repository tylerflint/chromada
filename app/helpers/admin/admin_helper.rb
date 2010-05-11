module Admin::AdminHelper
  
  def admin_grid(object, options={})
    grid = AdminGrid.new(self, object, session, params, options)
    yield grid
    concat grid.to_html
  end
  
end
