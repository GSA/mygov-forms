# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


f = Form.create(:title => "U.S. Individual Income Tax Return", :number => 1040, :omb_control_number => "1545-0074")

f.form_fields << FormField.create(:name => 'First Name and Initial', :label => 'Your first name and initial', :is_required => true, :field_type => :string)
f.form_fields << FormField.create(:name => 'Last Name', :label => 'Last name', :is_required => true, :field_type => :string)
f.form_fields << FormField.create(:name => "Social Security Number", :label => "Your social security number", :is_required => true, :field_type => :string)
f.form_fields << FormField.create(:name => "Spouse's First Name and Initial", :label => "If a joint return, spouse's first name and initial", :is_required => false, :field_type => :string)
f.form_fields << FormField.create(:name => "Spouse's Last Name", :label => "Last name", :is_required => false, :field_type => :string)
f.form_fields << FormField.create(:name => "Spouse's Social Security Number", :label => "Your spouse's security number", :is_required => false, :field_type => :string)
f.form_fields << FormField.create(:name => "Home Address", :label => "Home address (number and street). If you have a P.O. box, see instructions", :is_required => true, :field_type => :string)
f.form_fields << FormField.create(:name => "Apt No.", :label => "Apt. no.", )
f.form_fields << FormField.create(:name => "City", :label => "City, town or post office", :is_required => true, :field_type => :string)


f = Form.create(:title => "Fields Type Test", :number => 99999)
types = [ :select, :check_boxes, :radio, :time_zone, :password, :text, :date_select, :datetime_select, :time_select, :boolean, :string, :number, :file, :country, :email, :url, :phone, :search, :hidden, :range ]
types.each { |type| f.form_fields << FormField.create(:name => type, :label => "Field label for #{type}", :is_required => [true, false].sample, :field_type => type) }
