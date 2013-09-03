class DatePickerInput < Formtastic::Inputs::StringInput
  include Formtastic::Inputs::Base
  include FormtasticBootstrap::Inputs::Base::Labelling
  include FormtasticBootstrap::Inputs::Base::Placeholder
  include FormtasticBootstrap::Inputs::Base::Wrapping

  def to_html
    bootstrap_wrapping do
      builder.text_field(method, input_html_options)
    end
  end

  def controls_wrapping(args = {}, &block)
    template.content_tag(:div,
      [template.capture(&block), error_html].join("\n").html_safe,
      controls_wrapper_html_options(args)
    )
  end
   
  def input_html_options
    super.merge(:class => "datepicker form-control", :placeholder => placeholder_text)
  end
  
end
