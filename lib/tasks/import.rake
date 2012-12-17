namespace :mygov do
  namespace :forms do
    
    desc "Import from JSON"
    task :import_from_json_file, [:json_file] => [:environment] do |t, args|
      if args.json_file.blank?
        Rails.logger.error "usage: rake mygov:forms:import_from_json_file[json_file]"
      else
        json = File.read(args.json_file)
        parsed_json = JSON.parse(json)
        form = Form.find_or_create_by_number(parsed_json["form"]["number"], :title => parsed_json["form"]["title"])
        pdf = form.build_pdf(parsed_json["form"]["pdf"]) if parsed_json["form"]["pdf"]
        form.form_fields.destroy_all
        parsed_json["form"]["form_fields"].each do |form_field|
          new_form_field = form.form_fields.create!(form_field.reject{|k,v| k == "pdf_field"})
          if form_field["pdf_field"]
            pdf_field = pdf.pdf_fields.create!(form_field["pdf_field"].first) if form_field["pdf_field"].is_a?(Array)
            pdf_field = pdf.pdf_fields.create!(form_field["pdf_field"]) unless form_field["pdf_field"].is_a?(Array)
            new_form_field.pdf_field = pdf_field
            new_form_field.save!
          end
        end
      end
    end
  end
end
          