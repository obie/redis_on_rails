module ApplicationHelper
  def enhanced_description(event)
    event.enhanced_description do |description, attributes|
      attributes.each {|a| description.gsub!(a.name, link_to(a.name, url_for(a)))}
      description.html_safe
    end
  rescue
    event.description
  end
end
