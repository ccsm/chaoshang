class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::List
  
  belongs_to :node,inverse_of: :articles
  
  has_one :article_body, :dependent => :destroy

  accepts_nested_attributes_for :article_body

  delegate :body,:formatted_body, :to => :article_body


  field :title
  field :short_title 
  field :introduction
  field :author
  field :source
  field :published,:type => Mongoid::Boolean,default:true
  field :status,default:"normal"
  field :hits,:type => Integer,default:0
  field :section_top,:type => Mongoid::Boolean,default:true
  field :node_top,:type => Mongoid::Boolean,default:true

end
