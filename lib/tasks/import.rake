namespace :mygov do
  namespace :forms do

    desc "Import from JSON"
    task :import_from_json_file, [:json_file] => [:environment] do |t, args|
      if args[:json_file].blank?
        puts "usage: rake mygov:forms:import_from_json_file[json_file]"
      else
        # load form json data
        Form.import_from_json(args[:json_file])
      end
    end
  end
end
