module ApplicationHelper

  def error_messages_for(object)
    return if object.errors.empty?
    header_message = pluralize(object.errors.size, "error") + (object.errors.size > 1 ? " require" : " requires") + " your attention"
    content_tag(:div, class: "alert alert-danger") do
      concat(content_tag(:h4, header_message, class: "alert-heading"))
      concat(content_tag(:ul) do
        object.errors.full_messages.each do |message|
          concat(content_tag(:li, message))
        end
      end)
    end
  end

  def flash_messages
    return if flash.empty?
    html = ""
    flash.each do |key, value|
      style_class = case key
        when :notice ; "alert alert-success"
        when :alert ; "alert alert-danger"
      end
      html += content_tag(:div, value, class: style_class)
    end
    return html.html_safe
  end

end
