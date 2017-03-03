require 'artii'

class InventoryList  # item list within inventory file
  # a multi dimensional array of 5 racks with 5 shelves each
  def initialize()
    @shelf_array = [  Rack.new(), Rack.new(),
                      Rack.new(), Rack.new(),
                      Rack.new() ]
  end

  def update_shelf(rack_x, shelf_y, product_record)
    rack = @shelf_array[rack_x]
    puts "from update_shelf rack var: #{rack}"
    #rack[shelf_y] = product_record
    rack.update_shelf(shelf_y, product_record)
  end

  def listproducts  # list the racks
    @shelf_array.each do |shelves_array|
        puts shelves_array
      end
  end  # listproducts

  def get_next_available
    rack_x = nil
    shelf_y = nil
    @shelf_array.each_with_index do |rack, row|
      index = rack.next_shelf_available
      if index != nil # We found an available spot
        rack_x = row
        shelf_y = index
        puts "rack: #{rack_x} shelf_y: #{shelf_y} "
        break
      end
    end
    return {
      rack_x: rack_x,
      shelf_y: shelf_y
    }
  end

end  # InventoryList class





# is called by class InventoryList
class Rack
  def initialize
     @rack_array = [nil, nil, nil, nil, nil]
  end
  def next_shelf_available
    found_index = @rack_array.index(nil)
    return found_index
  end

  def update_shelf(shelf_y, product_record)
    @rack_array[shelf_y] = product_record
  end

end  # end of rack class





class InventoryRecord
  def initialize(name, quantity, length = 100, height = 100, depth = 100)
    @name = name
    @quantity = quantity
    @length = length
    @height = height
    @depth = depth
  end

  def nextemptyshelf
    # determine the next empty shelf ?????
    pos = @rack_array.flatten.index(nil) # absolute position by flattening the array
    ncols = @rack_array.first.size  # determine the number rows per shelf
    rack_x = pos / ncols  # get the rack id
    shelf_y = pos % ncols  # get the shelf id of rack
    return {
      rack_x: rack_x,
      shelf_y: shelf_y
    }
  end

end  # InventoryRecord

def logoheader    # method that clears the screen and places the logo
  system "clear" or system "cls"
  logo = Artii::Base.new :font => 'slant'
  puts logo.asciify('Inventory'.ljust(15))
  puts logo.asciify('  Program'.ljust(15))
  puts
end  # end for method: clear

def inventory_menu  # a method to list the main menu

  puts "GK inventory program"
  menustring = "Please select function"
  puts "#{menustring}"
  puts "-" * menustring.length
  puts "1 - Shelve status and items list"
  puts "2 - Look up or update an item"
  puts "3 - Add an item into inventory"
  puts "4 - ship out (delete) an item"
  # puts "5 - Move an item onto another shelf"
  puts
  puts "x - To exit out of menu"

  menu_action = $stdin.gets.chomp.upcase
  # customer order is returned as a hash
  return {
    menu_action: menu_action
  }
end   # end of game_menu

### main ###
### Body ###

# creates a new inventory instance executed once only
inventory_list = InventoryList.new()

logoheader  # clears screen and places the logo using artii gem
open_menu = true  # menu loop for list, add, delete products
while open_menu

  menu_selection = inventory_menu  # calls the menu defined in a method
  menu_select = menu_selection[:menu_action]

  if menu_select == 'X'
    open_menu = false
  elsif menu_select == '3'  # option 3 is to add new products
    # get the product name and quantity details
    # puts "Enter the product name:"
    # new_product = $stdin.gets.chomp
    new_product = "table tennis"
    quantity = 1000

    # creating a new instance of InventoryRecord
    product_record = InventoryRecord.new(new_product, quantity)

    # 1. get next empty shelf rack_x and shelf_y
    next_available = inventory_list.get_next_available  # get next shelf available
    rack_x = next_available[:rack_x]
    shelf_y = next_available[:shelf_y]
    # Adds the new product to product_inventory array
    inventory_list.update_shelf(rack_x, shelf_y, product_record)
    # inventory_list.listproducts

    puts inventory_list.inspect

  else
    puts "Option not available yet"
    sleep 2
    logoheader
  end

end   # end of while open_menu loop
