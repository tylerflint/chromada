module Admin::RolesHelper
  
  def action_tree
    Action.to_tree
  end
  
  def build_action_list_item(key, node, margin=30)
    if node.has_key?(:children)
      sub = ''
      node[:children].each do |k, n|
        sub << build_action_list_item(k, n, margin + 15)
      end
      li = %{<li class="checkbox-group"><input type="checkbox"  class="parent" id="action_#{node[:id]}" name="action_#{node[:id]}" /><label class='parent active' style="margin-left: #{margin - 15}px" ><span class='arrow'></span>#{key.capitalize}</label><ul class="sub">#{sub}</ul></li>}
    else
      li = %{<li class='checkbox-group'><input type="checkbox" id="action_#{node[:id]}" name="action_#{node[:id]}" /><label style="margin-left: #{margin}px">#{key.capitalize}</label></li>}
    end
    raw li
  end
  
end
