require 'artii'

## define and set all shelves to empty
@shelf = Hash.new   # defining shelf as a hash ligteral
def default_settings
  # there are 5 racks, each rack has 4 shelves,
    # each shelf can hold one chef pallet
    # Total 20 shelves, hash key r1s1, r1s2, r1s3, etc set to empty
  (1..5).each do |frame|
    rack = "r#{frame}"  # iterate r1 to r5 for rack_id
    (1..4).each do |ledge|
      shelves = "#{rack}s#{ledge}"  # interate for each rack s1 to s4 ir r1s1, r1s2 etc
      @shelf[shelves] = 'empty'  # adding into shelf hash setting their values to empty
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
  empty_shelf_count  #
  puts
  puts "There is #{empty_shelf_count} empty shelves out of #{@shelf.length}"
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

  puts "Your last menu action was at #{Time.now.strftime('%H:%M:%S')}"
  puts
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

## -----------------
default_settings  # set all sjelves to empty
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
    shelf_status  # display the current shelf status and stocked products
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

  elsif menu_select == '4'

    puts "Enter the product name for shipping:"
    product_name = $stdin.gets.chomp

    product_count,shelf_ids = search_for_products(product_name)
    if product_count > 1
      puts
      puts "Product #{product_name} are on shelves: "
      product_count.times { |n| puts shelf_ids[n] }
      puts "Which shelf do you want to ship?"
      shelf_id = $stdin.gets.chomp
    else
      shelf_id = shelf_ids[0]
    end
    puts
    puts "Product #{product_name} has been shipped and shelf #{shelf_id} is now empty"
    @shelf[shelf_id] = 'empty'
    $stdin.gets.chomp
    logoheader

  else
    puts "Menu Option is not available "
    sleep 2
    logoheader
  end

end   # end of while open_menu loop
