module FormHelpers
  def create_sample_forms
    @sample_form_1 = FactoryGirl.create(:form, title: 'Sample Form 1', number: 'S-1', icr_reference_number: '201305-4040-001', omb_control_number: '4040-0001', omb_expiration_date: DateTime.parse("2016-06-30"))
    @sample_form_2 = FactoryGirl.create(:form, title: 'Sample Form 2', number: 'S-2', omb_expiration_date: nil)

    @sample_form_1.form_fields.create!(field_type: "text", name: 'text_field', label: 'A Text Field', description: 'This is a text field.')
    @sample_form_1.form_fields.create!(field_type: "date", name: 'date_field', label: 'A Date Field', description: 'This is a date field.')
    @sample_form_1.form_fields.create!(field_type: "select", name: 'select_field', label: 'A Select Field', description: 'This is a select field', options: [['Yes', 'Yes'], ['No', 'No']])
  end
end