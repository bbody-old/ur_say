module PagesHelper
	def generate_summary title, image, brand, text, link
		@title = title
		@image = image
		@brand = brand
		@text = text
		@link = link

		render partial: "pages/summary"
	end
end
