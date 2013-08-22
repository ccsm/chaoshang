class Dashboard::NodesController < Dashboard::DashboardController  
  def index
    @sections = Section.all
    params[:active] ||= @sections.first.id.to_s
    @node = Node.new

  end

  def new
   @node = Node.new

  end

end
