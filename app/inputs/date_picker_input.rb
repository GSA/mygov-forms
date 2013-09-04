class DatePickerInput < FormtasticBootstrap::Inputs::StringInput
  
  def input_html_options
    super.merge(:class => "datepicker form-control", :placeholder => placeholder_text)
  end
  
end
