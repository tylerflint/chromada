class Action < ActiveRecord::Base
  has_and_belongs_to_many :roles
  
  def self.to_tree
    tree = {}
    all(:order => :path).each do |action|
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
  
end
