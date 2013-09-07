class GuideImage
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :image,GuideImageUploader
  belongs_to :article
 
  attr_accessor :guide_crop_x, :guide_crop_y, :guide_crop_w, :guide_crop_h


  after_update :crop_image
  
  def crop_image
    image.recreate_versions! if guide_crop_x.present?
  end
 
  field :image

end
