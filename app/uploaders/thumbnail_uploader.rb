# encoding: utf-8

class ThumbnailUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    case version_name
    when :medium
      "https://placehold.it/414x114"
    when :small
      "https://placehold.it/375x114"
    when :smaller
      "https://placehold.it/320x114"
    else
      "https://placehold.it/414x114"
    end
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :medium do
    process resize_to_fill: [414, 114]
  end

  version :small, from_version: :medium do
    process resize_to_fill: [375, 114]
  end

  version :smaller, from_version: :small do
    process resize_to_fill: [320, 114]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
