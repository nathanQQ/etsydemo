class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "100x100>", :thumb => "100x100>" }, :default_url => "no_image_available.jpeg"
	else	
		has_attached_file :image, :styles => { :medium => "100x100>", :thumb => "100x100>" }, :default_url => "no_image_available.jpeg",
		    			:storage => :dropbox,
    					:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
						:path => ":style/:id_:filename"
	end
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :name, :price, :description, presence: true
	validates :price, numericality:{greater_than: 0}
	belongs_to :user
	has_many :orders
	paginates_per 4

end
