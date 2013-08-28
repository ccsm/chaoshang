class Node
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Mongoid::Tree::Traversal

 
  field :name
  field :summary
  has_many :articles,inverse_of: :node
  belongs_to :section

  index :section_id => 1

  validates_presence_of :name,:section
  validates_uniqueness_of :name

  scope :hots, desc(:articles_count)

  after_save :update_cache_version
  after_destroy :update_cache_version

  def parent_name
   @p =  Node.find self.parent_id
   @p.name
  end

  def traverse_to_list
    node_options = Array.new
    self.traverse(:breadth_first) do |n|
     node_names = Array.new
     n.ancestors_and_self.each do |node|
       node_names << node.name 
     end
     node_options << [self.section.name+">>"+node_names.join(">>"),n.id]
    end
    node_options
  end

  def update_cache_version
    # 记录节点变更时间，用于清除缓存
    CacheVersion.section_node_updated_at = Time.now.to_i
  end

  def self.node_collection
    Rails.cache.fetch("node:node_collection:#{CacheVersion.section_node_updated_at}") do
      Node.all.collect { |n| [n.name,n.id] }
    end
  end  
   
end
