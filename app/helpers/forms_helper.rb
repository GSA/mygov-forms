module FormsHelper

  def form_title(form)
    "#{form.title} (#{form.number})"
  end
  
  def form_input(f, form_field)
    f.input form_field.name.to_sym, 
      :as => form_field.formtastic_field_type.to_sym, 
      :label => form_field.label || form_field.name.humanize, 
      :collection => form_field.options, 
      :required => form_field.is_required,
      :hint => form_field.description
  end  
end
