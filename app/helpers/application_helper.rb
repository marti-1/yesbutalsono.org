module ApplicationHelper
  def error_class(resource, field)
    'is-invalid' if resource.errors[field].any?
  end

  def error_message(resource, field)
    if resource.errors[field].any?
      content_tag(:div, resource.errors[field].first, class: 'invalid-feedback')
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, footnotes: true)
    markdown.render(text).html_safe
  end
end
