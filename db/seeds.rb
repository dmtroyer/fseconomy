# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

aircraft_models_file = Rails.root.join('db', 'seeds', 'aircraft_models.yml')
aircraft_models = YAML::load_file(aircraft_models_file)
AircraftModel.import!(aircraft_models)
