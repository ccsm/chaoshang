class Dashboard::NodesController < Dashboard::DashboardController  
  def index
    @nodes = Node.all

  end
end
