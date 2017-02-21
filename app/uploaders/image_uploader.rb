class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    'public/uploads'
  end

  # process resize_to_fit: [800, 800]

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def content_type_whitelist
    /image\//
  end

  def filename
    "#{model.issue.category}-#{DateTime.now}".parameterize
  end
end
