module Admin::AdminHelper
  
  def admin_grid(object, options={})
    grid = AdminToolbelt::Grid.new(object, options)
    yield grid
    concat grid.output
  end
  
end
