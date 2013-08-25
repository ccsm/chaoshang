class Dashboard::NodesController < Dashboard::DashboardController  
  def index
    @sections = Section.all
    params[:active] ||= @sections.first.id.to_s
    @section_nodes = Hash.new
    Section.all.each do |section|
       @section_nodes["s_"+section.id.to_s]=Array.new
       section.nodes.all.each do |node|
          @section_nodes["s_"+section.id.to_s]<<{:name=>node.name,:id=>node.id,:pid=>node.parent_id||=0,:isParent=>true}
       end
    end   
    gon.nodes = @section_nodes.to_json      
 end

 def new
    @node = Node.new
    @node.section_id = params[:section_id].to_i
    @node.parent_id = params[:parent_id].to_i unless params[:parent_id].nil?
    
 end

 def edit
   @node = Node.find params[:id]
 end

 def destroy
    @node = Node.find(params[:id])
    @node.destroy
    render text: "<script>parent.refresh();</script>"
 end



 def create
    @node = Node.new(node_params)
    if @node.save!
      #redirect_to nodes_path+"?active=#{@node.section_id}", notice: '节点创建成功。'
      render text: "<script>parent.refresh();</script>"
    else
      #redirect_to nodes_path+"?active=#{params[:node][:section_id]}", notice: '节点创建失败。'
      render text: "<script>parent.refresh();</script>"
    end
  end
 
  private
    def node_params
      params.require(:node).permit(:name, :summary,:parent_id,:section_id)
    end

end
