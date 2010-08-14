module Admin::RolesHelper
  
  def action_tree
    # {
    #   :employee => {
    #     :edit => 12
    #   },
    #   :company => {
    #     :create => 1,
    #     :edit   => 3,
    #     :delete => 4
    #   }
    # }
    tree = {}
    Action.order(:path).all.each do |action|
      paths = action.path.split "/"
      if paths.length > 1
        # loop through path popping on
        current_node = tree
        current_count = 1
        paths.each do |path|
          if current_count == paths.length
            current_node[path] = action.id
          else
            current_node = create_or_fetch_node(current_node, path)
          end
          current_count += 1
        end
      else
        # pop directly onto tree
        tree[paths[0]] = action.id
      end
    end
    tree
  end
  
  def create_or_fetch_node(tree, path)
    if tree.has_key?(path)
      tree[path]
    else
      tree[path] = {}
    end
  end
  
end
