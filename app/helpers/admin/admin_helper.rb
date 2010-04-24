module Admin::AdminHelper
  
  def admin_grid(model, options={})
    grid = AdminToolbelt::Grid.new model, options
    yield grid
    concat grid.output
  end
  
end
