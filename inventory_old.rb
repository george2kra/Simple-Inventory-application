require 'artii'

class InventoryList  # WIP

=begin
  1. loop items array displaying all items and its quantity. WIP!! sort and filtering
  items.each do | name, sku, quantity, shelf_id, row_id |
    puts "Item #{name} Quantity #{quantity}"
  end

  2. load up the shelves status from shelf class, group volumes as per nil and occupied
=end

end # end of InventoryItems class

class Item  # item list within inventory file

  @@items = []  # collection of instances of item
  # instance methods
  def initialize(name:, sku:, quantity:, shelf_id:, row_id: )
    @name = name
    @sku = sku
    @quantity = quantity
    @shelf_id = shelf_id
    @row_id = row_id
    @@items.push(self) # push names into the items list
  end

  # def method to add item into array

=begin

  filecheck = "itemlist.txt"
  item_file_exists = File.file?("#{filecheck}")  # if file exists

  if item_file_exists
    puts "File #{filecheck} exists"
    # 1. Append pushed item into items file
    filename = File.open("#{filecheck}","a") do |newitem|
    newitem.puts "#{@@items.push(self)}";
    f.close();
  else
    # Create the item file
    File.open("#{filecheck}", 'w') {|f| f.puts(#{@@items.push(self)}) }
  end

=end

end # end of Item class

# class method
def self.items
  @@items
end

class SKU  # The Stock Keeping Unit of manufacturer part_numbers
  def initialize(manufacturer, part_number)
    @manufacturer = manufacturer
    @part_number = part_number
  end
end  # end of SKU class

class Shelves

  def initialize()
    #def initialize(location, space_available)
    @location
    @space_available
  end

  def allocateshelf
    # file? will only return true if shelf file exists in folder
    filecheck = "shelves.txt"
    file_exists = File.file?("#{filecheck}")  # if shelf file exists
    if file_exists
      puts "File #{filecheck} exists"
      # ???? load the shelf values ?????
    else
      # set all 5 shelves to be false (ie empty)
      # multi dimensional array, each array value is nil
      @shelf_array = [ [false, false, false, false, false], [false, false, false, false, false],
                        [false, false, false, false, false], [false, false, false, false, false],
                        [false, false, false, false, false] ]
      #  puts "The #{filecheck} did not exist, all shelves set to empty!"
    end  # end of if shelf file exists

    # find the first empty shelf
    pos = @shelf_array.flatten.index(false) # absolute position by flattening the array
    ncols = @shelf_array.first.size  # determine the number rows per shelf
    shelf = pos / ncols  # het the shelf id
    row = pos % ncols  # get the row id of shelf
    #empty_shelf = @@shelf_array[shelf][row]
    # return syntax
    return {
      shelf_array: shelf,
      shelf_row: row
      # empty_shelf:
    }
  end # end of allocateshelf method

  def additem(item_name,item_sku,quantity,item_length,item_height,item_depth,shelf_id,row_id)
    @sku = sku
    @name = name
  end

=begin
    2. get the next empty shelf from the Shelves class
    3. call class item to add item into @@items array
    4. append new item array into item.txt
=end




end  # end of Shelf class

class ShelfLocation  # WIP
  def initialize(shelf, row_y)
    @shelf = shelf
    @row_y = row_y
  end


end  # end of ShelfLocation class


class MoveRequest
  def initialize(item, shelf, row_y)
    @item = item
    @item_length = item_length
    @item_height = item_height
    @item_depth = item_depth
    @row_y = row_y
  end
end  # end of MoveRequest class

class OutGoing
  def initialize(location, sku, date)
    @location = location
    @sku = sku
    @date = date
  end

#  perform a remove functions

end  # end of Outgoing class

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


#################### main program  ###################
#################### main program  ###################
#################### main program  ###################
logoheader
open_menu = true
while open_menu  # loop the ordering menu until no more customers

  menu_selection = inventory_menu  # calls the menu defined in a method
  menu_select = menu_selection[:menu_action]

  if menu_select == 'X'
    open_menu = false
  else menu_select == 3
    # add item to inventory list
    puts "Enter the item name:"
    item_name = $stdin.gets.chomp
    puts "Enter the item name:"
    item_sku = $stdin.gets.chomp
    puts "Enter the length of package:"
    item_length = $stdin.gets.chomp
    puts "Enter the height of package:"
    item_height = $stdin.gets.chomp
    puts "Enter the depth of package:"
    item_depth = $stdin.gets.chomp


    # append to item array
    getemptyshelf = Shelves.new  # create a shelves instance
    nextemptyshelf = getemptyshelf.allocateshelf  # Determine the next empty Shelf and Row
    add_item = getemptyshelf.additem(item_name,item_sku,item_length,item_height,item_depth,shelf_id,row_id)

    # call Item class to add new item into item array
  end

end  # end of while open_menu loop

=begin

add an item into the items array
1. determine the shelf ID first from the
2. bottles = Item.new(name: "bottle", sku: "bot_123", quantity: 100)
-??? find and a shelf that has the space insert into a file

  move an item from a shelf into another shelf
  to remove an from the items list when shipped OutGoing

=end



# inventory_list
