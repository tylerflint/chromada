module Admin::RolesHelper
  
  def action_tree
    Action.to_tree
  end
  
  def build_action_list_item(key, node)
    if node.has_key?(:children)
      sub = ''
      node[:children].each do |k, n|
        sub << build_action_list_item(k, n)
      end
      li = %{<li class="checkbox-group"><input type="checkbox" id="action_#{node[:id]}" name="action_#{node[:id]}" /><label class='parent active'><span class='arrow'></span>#{key.capitalize}</label><ul class="sub">#{sub}</ul></li>}
    else
      li = %{<li class='checkbox-group'><input type="checkbox" id="action_#{node[:id]}" name="action_#{node[:id]}" /><label>#{key.capitalize}</label></li>}
    end
    raw li
  end
  
end
