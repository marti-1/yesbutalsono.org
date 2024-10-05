module ApplicationHelper
    def error_class(resource, field)
        'is-invalid' if resource.errors[field].any?
    end

    def error_message(resource, field)
        if resource.errors[field].any?
          content_tag(:div, resource.errors[field].first, class: 'invalid-feedback')
        end
    end
end
