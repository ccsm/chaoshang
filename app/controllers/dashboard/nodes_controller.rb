class Dashboard::NodesController < Dashboard::DashboardController  
  def index
    @sections = Section.all
    params[:active] ||= @sections.first.id.to_s

  end
end
