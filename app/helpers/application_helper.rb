module ApplicationHelper

  def full_title(page_title="")
    base_tile="Explore The City"
    if page_title.blank?
      base_tile
    else
      "#{page_title} | #{base_tile}"
    end
  end

  def city
    ["kairouan", "tunis", "sousse"]
  end

end
