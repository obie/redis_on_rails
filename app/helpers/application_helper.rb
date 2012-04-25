module ApplicationHelper
  def enhanced_description(event)
    event.description.tap do |d|
      d.gsub!(event.conference.name, link_to(event.conference.name, url_for(event.conference)))
      d.gsub!(event.attendee.name, link_to(event.attendee.name, url_for(event.attendee)))
    end.html_safe
  rescue
    event.description
  end
end
