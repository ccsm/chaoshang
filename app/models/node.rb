class Node
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::List
 
  field :name
  field :summary
  field :articles_count, :type => Integer, :default => 0

  has_many :articles
  belongs_to :section

  index :section_id => 1

  validates_presence_of :name, :summary, :section
  validates_uniqueness_of :name

  scope :hots, desc(:articles_count)

  after_save :update_cache_version
  after_destroy :update_cache_version

  def update_cache_version
    # 记录节点变更时间，用于清除缓存
    CacheVersion.section_node_updated_at = Time.now
  end

  # 热门节点给 select 用的
  def self.node_collection
    Rails.cache.fetch("node:node_collection:#{CacheVersion.section_node_updated_at}") do
      Node.all.collect { |n| [n.name,n.id] }
    end
  end  
   
end