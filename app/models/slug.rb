module Slug

  def create_slug(text)
    text.gsub(/\W/, "+")
    text
  end

end
