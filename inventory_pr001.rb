require 'artii'

## define and set all shelves to empty
@shelf = Hash.new   # defining shelf as a hash ligteral
def default_settings(howmany_racks,shelves_perrack)
  # howmany_racks is rack count, shelves_perrack how many shelves per rack
=begin
  # Determine how many shelves currently exist
  current_shelves = @shelf.length
  if @shelf.length == 0
    start_shelf = 1
  else
    start_shelf = @shelf.length + 1
    howmany_racks = start_shelf + howmany_racks
  end
  puts "shelves #{@shelf.length} starting #{start_shelf}"
  $stdin.gets.chomp.upcase
=end
  if @shelf.length == 0
    start_shelf = 1
  end

  # Define the shelves and set them to empty status
  (start_shelf..howmany_racks).each do |frame|
    rack = "r#{frame}"  # iterate r1 to r many
    (1..shelves_perrack).each do |ledge|
      shelves = "#{rack}s#{ledge}"  # interate each rack with suffx s1 to s many
      @shelf[shelves] = 'empty'  # setting each shelf hash key value to empty
    end
  end

end  # end of default_settings

#temporary set up for testing
def add_some_products
  product_name = ["shoes",30000,100,100,100]
  @shelf['r1s1'] = product_name
  product_name = ["socks",10000,100,100,100]
  @shelf['r1s2'] = product_name
  product_name = ["pants",2400,100,100,100]
  @shelf['r2s1'] = product_name
  product_name = ["ties",15000,100,100,100]
  @shelf['r4s2'] = product_name
  product_name = ["socks",200,100,100,100]
  @shelf['r3s4'] = product_name
end



# determine the next empty shelf id
def get_empty_shelf
  @shelf.each do |ledge, status|
    if status == 'empty'
      #?? get the hash id
      @empty_shelf = ledge
      break
    else
      # There are no more empty shelves
      @empty_shelf = 'none'
    end
  end
  @empty_shelf    # puts "empty shelf is #{@empty_shelf}"
end

def shelf_status  # display how many shelves are empty
  empty_shelf_count = 0 # set the empty shelve variable to zero
  @shelf.each do |ledge, status|
    if status == 'empty'
      empty_shelf_count += 1
    end
  end
  empty_shelf_count  # tally of empty shelves
end  # shelf_status

def list_products
  puts
  puts "Current stocked items:"
  @shelf.each do |ledge, status|
    if status != 'empty'
      puts " #{status[0]} #{status[1]} on shelf #{ledge}"
    end
  end
end


def search_for_products(product_name)  # product look up
  product_count = 0
  shelf_ids = Array.new
  @shelf.each do |ledge, status|
    if status[0] == product_name
      puts " There are #{status[1]} #{status[0]} on shelf #{ledge}"
      product_count += 1
      shelf_ids << ledge
    end
  end
  if product_count == 0
    puts "Product #{product_name} was not found. "
    puts
  end
  return product_count, shelf_ids
end  # search_for_products


def logoheader    # method that clears the screen and places the logo
  system "clear" or system "cls"
  logo = Artii::Base.new :font => 'slant'
  puts logo.asciify('Inventory'.ljust(15))
  puts logo.asciify('  Program'.ljust(15))
  puts
end  # end for method: clear

def inventory_menu  # a method for the main menu
  empty_shelf_count = shelf_status
  used_shelf_count = @shelf.length - empty_shelf_count
  puts "Used Shelves as at #{Time.now.strftime('%H:%M:%S')}:- #{used_shelf_count} / #{@shelf.length}"
  puts
  menustring = "Please select function"
  puts "#{menustring}"
  puts "-" * menustring.length
  puts "1 - Shelve status and stocked Products"
  puts "2 - Look for a shelved Product"
  puts "3 - Add a Product into the inventory"
  puts "4 - Ship out a Product"
  # puts "5 - Move a Product onto another shelf"
  # if manager ......
  # puts "6 - Add or Remove shelves"  # for removal check if shelves are empty or move them
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

## -----------------
## WIP if shelf.csv file exists then DO NOT execute default_settings
default_settings(6,4)  # set all sjelves to empty
   add_some_products  # add products onto the shelf
## -----------------






logoheader  # clears screen and places the logo using artii gem
open_menu = true  # menu loop for list, add, delete products
while open_menu

  menu_selection = inventory_menu  # calls the menu defined in a method
  menu_select = menu_selection[:menu_action]

  if menu_select == 'X'
    open_menu = false

  elsif menu_select == '1'  # option 1 is to display the current shelf status and stocked products
    empty_shelf_count = shelf_status  # display the current shelf status and stocked products
    used_shelf_count = @shelf.length - empty_shelf_count
    puts
    puts "There are #{used_shelf_count} used shelves out of #{@shelf.length}"
    list_products
    $stdin.gets.chomp
    logoheader

  elsif menu_select == '2'  # option 2 is to look up a product
    ## look up an item
    puts "Enter the product name for search eg socks:"
    product_name = $stdin.gets.chomp
    search_for_products(product_name)
    $stdin.gets.chomp
    logoheader

  elsif menu_select == '3'  # option 3 is to add new products

    puts "Enter the product name:"
    new_product = $stdin.gets.chomp

    puts "Enter the quantity:"
    quantity = $stdin.gets.chomp

    find_empty = get_empty_shelf  # find the first empty shelf

    product_name = [new_product,quantity,100,100,100]
    @shelf[find_empty] = product_name  # populate shelf with product details

    puts "Place #{new_product} on shelf #{find_empty}"
    $stdin.gets.chomp
    logoheader

  elsif menu_select == '4'  # option 4 ship a product

    puts "Enter the product name for shipping:"
    product_name = $stdin.gets.chomp

    product_count,shelf_ids = search_for_products(product_name)
    if product_count > 1
      puts
      puts "Product #{product_name} are on the following shelves: "
      product_count.times { |n| puts shelf_ids[n] }
      puts "Which shelf do you want to ship?"
      shelf_id = $stdin.gets.chomp
    else
      shelf_id = shelf_ids[0]
    end
    if product_count > 0
      puts
      puts "Product #{product_name} has been shipped and shelf #{shelf_id} is now empty"
      @shelf[shelf_id] = 'empty'
    end
    $stdin.gets.chomp
    logoheader

  elsif menu_select == ''  # refesh the screen menu
    puts "Refeshing screen Menu "
    sleep 2
    logoheader

  else
    puts "Menu Option is not available "
    sleep 2
    logoheader
  end

end   # end of while open_menu loop
