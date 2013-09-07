# encoding: utf-8

class GuideImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
   version :guide_view do
          process :resize_to_fit => [420, 300]
   end

    version :guide do
         process :guide_crop
         process :resize_to_fill => [210, 150]
    end

  def guide_crop
    if model.guide_crop_x.present?
      manipulate! do |img|
        x = model.guide_crop_x
        y = model.guide_crop_y
        w = model.guide_crop_w
        h = model.guide_crop_h
        img.resize("420x300")
        crop_params = "#{w}x#{h}+#{x}+#{y}"
        img.crop(crop_params)
        img
      end
    end

  end


   def extension_white_list
     %w(jpg jpeg gif png)
   end

#   def filename
#     "#{secure_token}.#{file.extension}" if original_filename.present?
#   end

  protected
   def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
   end

end
