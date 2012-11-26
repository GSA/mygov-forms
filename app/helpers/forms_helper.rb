module FormsHelper

  def form_title(form)
    "#{form.title} (#{form.number})"
  end
  
  def form_input(f,form_field)
    f.input form_field.name.to_sym, 
      :as => form_field.field_type.to_sym, 
      :label => form_field.label || form_field.name.humanize, 
      :collection => form_field.options, 
      :required => form_field.is_required,
      :hint => form_field.description
  end
  
  def form_input_types
    {
      "Yes/No"        => "boolean",
      "Check Boxes"   => "check_boxes",
      "Country"       => "country",
      "Date"          => "date_select",
      "Date and Time" => "datetime_select",
      "E-Mail"        => "email",
      "Number"        => "number",
      "Phone"         => "phone",
      "Radio Buttons" => "radio",
      "Range"         => "range",
      "Search"        => "search",
      "Dropdown"      => "select",
      "Text (small)"  => "string",
      "Text (large)"  => "text",
      "Time"          => "time_select",
      "Time Zone"     => "time_zone",
      "URL"           => "url"
    }
  end
end
