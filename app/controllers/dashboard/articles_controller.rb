class Dashboard::ArticlesController < Dashboard::DashboardController

  def index
    @articles = Article.all
  end
 
  def new
    @article = Article.new
    @article_body = @article.build_article_body
    @nodes = Array.new
    Section.all.each do |section|
      @nodes<<section.nodes_list
    end 
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      redirect_to @article, notice: '模块更新成功。'
    else
      render action: "edit"
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      @article.article_body.update_attribute(:article_id,@article.id)
      redirect_to @article,notice: "文章创建成功！" 
    else
      render :action=>"new"  
    end
  end

  def edit
    @article=Article.find(params[:id])
    @nodes = Array.new
    Section.all.each do |section|
      @nodes<<section.nodes_list
    end 
    @article.guide_image ||= GuideImage.new
  end

  def show
    @article=Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy()
    redirect_to articles_url
  end


  private
    def article_params
      params.require(:article).permit(:node_id,:title, :short_title,:introduction,:author,:source,:published,:status,:section_top,:node_top,:tags,article_body_attributes:[:article_id,:body],guide_image_attributes:[:article_id,:image,:guide_crop_x,:guide_crop_y,:guide_crop_w,:guide_crop_h])
    end

end
