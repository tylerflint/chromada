module Admin::RolesHelper
  
  # def action_tree
  #   # {
  #   #   :employee => {
  #   #     :edit => 12
  #   #   },
  #   #   :company => {
  #   #     :create => 1,
  #   #     :edit   => 3,
  #   #     :delete => 4
  #   #   }
  #   # }
  #   tree = {}
  #   Action.order(:path).all.each do |action|
  #     paths = action.path.split "/"
  #     if paths.length > 1
  #       # loop through path popping on
  #       current_node = tree
  #       current_count = 1
  #       paths.each do |path|
  #         if current_count == paths.length
  #           current_node[path] = action.id
  #         else
  #           if !current_node.has_key?(path)
  #             current_node[path] = {}
  #           end
  #           current_node = current_node[path]
  #         end
  #         current_count += 1
  #       end
  #     else
  #       # pop directly onto tree
  #       tree[paths[0]] = action.id
  #     end
  #   end
  #   tree
  # end
  
  def self.action_tree
    tree = {}
    Action.order(:path).all.each do |action|
      paths = action.path.split "/"
      path_count = 1
      current_node = tree
      paths.each do |path|
        first = path_count == 1
        last  = path_count == paths.length
        if (first && last) || last
          current_node[path] = {:id => action.id}
        else
          unless current_node[path].has_key?(:children)
            current_node[path][:children] = {}
          end
          current_node = current_node[path][:children]
        end
        path_count += 1
      end
    end
    tree
  end
  
  def build_action_list_item(key, node)
    if node.class.to_s == 'Hash'
      sub = ''
      node.each do |k, n|
        sub << build_action_list_item(k, n)
      end
      li = %{<li class="checkbox-group"><input type="checkbox" id="action_#{key}" name="action_#{key}" /><label class='parent active'><span class='arrow'></span>#{key.capitalize}</label><ul class="sub">#{sub}</ul></li>}
    else
      li = %{<li class='checkbox-group'><input type="checkbox" id="action_#{node}" name="action_#{node}" /><label>#{key.capitalize}</label></li>}
    end
    raw li
  end
  
end
