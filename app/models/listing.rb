class Listing < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "100x100>", :thumb => "100x100>" }, :default_url => "no_image_available.jpeg"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
