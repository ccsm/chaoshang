class ArticleBody
  include Mongoid::Document
  include Mongoid::Timestamps
 
  belongs_to :article
  
  field :body
  field :formatted_body
  validates :body, :presence => true

end
