module Admin::AdminHelper
  class Grid
    
    def initialize
      @columns = []
    end
    
    def column(options)
      @columns << options
    end
    
    def output
      html = ''
      @columns.each do |c|
        html << c[:title]
      end
      html
    end
    
  end
  
  def test_helper_with_session_validation
    grid = Grid.new
    yield grid
    concat grid.output
  end
end
