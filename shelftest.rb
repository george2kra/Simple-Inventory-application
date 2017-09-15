require 'csv'

=begin
1. If the reck file exists, determine the latest rack defined and use that ID
to add new racks and shelves.
2. WIP: Freeze racks for removal, this will stop shelf allocation for stocking
 - Frozen racks are excluded from product shelf placement
 - Any products remaining on frozen shelfs will be moved onto other shelves
 - Once shelves are free from all products, they can be removed.

Array set up, [location_id, rack_id, rack_number, shelf_id, shelf_number, latest_update, shelf_status ]
  - the shelf_status will either be 'empty', 'frozen', product details

=end

start_shelf = 1
shelf_legth = 120 # default length 120 cm
shelf_depth = 120 # default length 120 cm
shelf_height = 180 # default length 180 cm
shelf_ids = Array.new
filename = "shelves.csv"

# if the rack csv file exists
if File.exists?(filename)
  puts "#{filename} exists"
end

puts "What is the location of the racks, eg blda - for biulding A?"
rack_location = $stdin.gets.chomp
puts "Rack definition, please enter the rack id prefix? eg R"
rack_id = $stdin.gets.chomp.upcase
puts "How many racks do you wish to add?"
racks_add = $stdin.gets.chomp
puts "How many shelves are there pre rack?"
shelves_perrack = $stdin.gets.chomp
puts "How tall is each shelfs in centimeters? eg 180"
shelf_height = $stdin.gets.chomp
puts "Shelf definition, please enter the shelf id prefix? eg S"
shelf_id = $stdin.gets.chomp.upcase

# empty a file
CSV.open(filename, "w+") {|header| header << ['rack_location','rack_id','rack_number','shelf_id','shelf_number','latest_update','shelf_status'] }

  # Define the shelves and set them to empty status
  (start_shelf..racks_add.to_i).each do |frame|  # rack_id iteration
    rack_location = 'doma'  # location if racks
    rack_id = 'r'
    shelf_id = 's'
    timestamp=Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    (1..shelves_perrack.to_i).each do |ledge|
      # interate each rack and shelf suffx s1 to s many
      CSV.open(filename, "a+") do |shelf|
        shelf << [rack_location, rack_id, frame, 's', ledge, timestamp, 'empty']
      end # loop for writing to csv file
    end
  end  # end of (start_shelf..racks_add).each do ...

  CSV.foreach(filename, headers: true) do |row| # read line by line
    puts "CSV line: #{row} "  # row[2] display's the third comma delimited element
  end
