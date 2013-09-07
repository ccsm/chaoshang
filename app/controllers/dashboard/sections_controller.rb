class Dashboard::SectionsController < Dashboard::DashboardController 
  def index
    @sections = Section.all
  end

  def new
    @section=Section.new
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to @section, notice: '模块创建成功。'
    else
      render action: "new"
    end
  end

  def edit
    @section = Section.find(params[:id])
  
  end


  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      redirect_to @section, notice: '模块更新成功。'
    else
      render action: "edit"
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy()
    redirect_to sections_url
  end

  def moveup
    @section = Section.find params[:section_id]
    @section.position -= 1
    @section.save
    redirect_to sections_url
  end

  def movedown
    @section = Section.find params[:section_id]
    @section.position += 1
    @section.save

    redirect_to sections_url
  end



  private
    def section_params
      params.require(:section).permit(:name, :url,:ismenu)
    end

 
 
end
