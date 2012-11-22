require 'spec_helper'

describe PdfField do
  it { should belong_to :pdf }
  it { should belong_to :form_field }
end
