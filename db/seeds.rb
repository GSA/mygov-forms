# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

json_seeds = Dir.glob(File.join(Rails.root, 'db/json/*.json'))
json_seeds.map {|seed| Rake::Task["mygov:forms:import_from_json_file"].execute({:json_file=> seed})}