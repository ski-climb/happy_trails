class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    'public/uploads'
  end

  process resize_to_fit: [700, 7000]

  # Create different versions of your uploaded files:
  version :medium do
    process resize_to_fit: [500, 5000]
  end

  version :small do
    process resize_to_fit: [300, 3000]
  end

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
