module FormsHelper

  def form_title(form)
    "#{form.title} (#{form.number})"
  end

  def form_input(f, form_field)
    f.input form_field.name.to_sym,
      :as => form_field.formtastic_field_type.to_sym,
      :collection => form_field.options,
      :hint => form_field.description,
      :label => form_field.label || form_field.name.humanize,
      :required => form_field.is_required,
      :input_html => { :title => form_field.tool_tip_text}
  end

  def omb_info(form)
    link_to "Form Approved OMB##{form.omb_control_number} | Expires at #{form.omb_expiration_date}", "http://www.reginfo.gov/public/do/PRAViewICR?ref_nbr=#{form.icr_reference_number}"
  end
end
