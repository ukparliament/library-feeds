require 'csv'

# # A task to import publishers.
task :import_publishers => :environment do
  puts "importing publishers"
  CSV.foreach( 'db/data/publishers.csv' ) do |row|
    publisher = Publisher.new
    publisher.name = row[0]
    publisher.save
  end
end