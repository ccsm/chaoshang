class Section
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::List
  field :name
  field :url
  has_many :nodes, :dependent => :destroy

  validates_presence_of :name,:url
  validates_uniqueness_of :name,:url


  default_scope asc(:position)

  after_save :update_cache_version
  after_destroy :update_cache_version

  def update_cache_version
    # 记录节点变更时间，用于清除缓存
    CacheVersion.section_node_updated_at = Time.now.to_i
  end

  #def sorted_nodes
  #  self.nodes.sorted
  #end

  def self.section_collection
    Rails.cache.fetch("section:section_collection:#{CacheVersion.section_node_updated_at}") do
      Section.all.collect { |s| [s.name,s.url,s.id] }
    end
  end  


end
