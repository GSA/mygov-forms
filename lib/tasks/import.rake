namespace :mygov do
  namespace :forms do

    desc "Import from JSON"
    task :import_from_json_file, [:json_file] => [:environment] do |t, args|
      if args[:json_file].blank?
        puts "usage: rake mygov:forms:import_from_json_file[json_file]"
      else
        json = File.read(args[:json_file])
        parsed_json = JSON.parse(json)

        form = Form.find_or_create_by_number(parsed_json["form"]["number"],
              :title => parsed_json["form"]["title"],
              :icr_reference_number => parsed_json["form"]["icr_reference_number"],
              :omb_control_number => parsed_json["form"]["omb_control_number"],
              :omb_expiration_date => parsed_json["form"]["omb_expiration_date"],
              :start_content => parsed_json["form"]["start_content"],
              :agency_name => parsed_json["form"]["agency_name"],
              :published_at => Time.now
              )

        print "importing #{form.title}."
        pdf = form.build_pdf(parsed_json["form"]["pdf"]) if parsed_json["form"]["pdf"]
        form.pdf = pdf
        form.form_fields.destroy_all
        parsed_json["form"]["form_fields"].each_with_index do |form_field, index|
          new_form_field = form.form_fields.create!(form_field.reject{|k,v| k == "pdf_field"}.merge(:position => index + 1))
          if form_field["pdf_field"]
            pdf_field = pdf.pdf_fields.new(form_field["pdf_field"].first) if form_field["pdf_field"].is_a?(Array)
            pdf_field = pdf.pdf_fields.new(form_field["pdf_field"]) unless form_field["pdf_field"].is_a?(Array)
            new_form_field.pdf_field = pdf_field
            new_form_field.save!
          end
        end
        puts '..Done'
      end
    end
  end
end
