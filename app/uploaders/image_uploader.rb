class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  if Rails.env.production?
    storage :fog
    def store_dir
      "sample-image/#{model.id}"
    end
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  # process resize_to_fit: [300, 300]
  # def scale(width, height)
  #   # do something
  # end

  def size_range
    1..5.megabytes
  end
  # Create different versions of your uploaded files:
  version :thumb20 do
    process resize_to_fit: [20, 20]
  end

  version :thumb30 do
    process resize_to_fit: [30, 30]
  end

  version :thumb50 do
    process resize_to_fit: [50, 50]
  end

  version :thumb70 do
    process resize_to_fit: [70, 70]
  end

  version :thumb200 do
    process resize_to_fit: [200, 200]
  end

  version :thumb400 do
    process resize_to_fit: [400, 400]
  end

  process resize_to_fill: [400, 400]
  version :gallery do
    process resize_to_fill: [400, 300, "Center"]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
