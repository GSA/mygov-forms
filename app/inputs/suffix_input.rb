class SuffixInput < Formtastic::Inputs::SelectInput
  include Formtastic::Inputs::Base
  include FormtasticBootstrap::Inputs::Base::Labelling
  include FormtasticBootstrap::Inputs::Base::Wrapping
  
  def to_html
    bootstrap_wrapping do
      options[:group_by] ? grouped_select_html : select_html
    end
  end
 
  def wrapper_html_options
    super.tap do |options|
      options[:class] << " select"
      options[:class] << " has-error" if errors?
    end
  end
  
  def input_html_options
    result = {}
    result[:class] = 'form-control'
    result[:validate] = options[:validate] if options[:validate]

    result.merge(super)
  end
  
  def collection
    [
      ['Jr.'],
      ['Sr.'],
      ['M.D.'],
      ['Ph.D.']
    ]
  end
end