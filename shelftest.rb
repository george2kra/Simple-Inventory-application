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
      # set all 5 shelves to be empty
      # multi dimensional array, each array value is nil
      @@shelf_array = [ [false, false, 'xxx', false, false], [false, false, false, false, false],
                        [false, false, false, false, false], [false, false, false, false, false],
                        [false, false, false, false, false] ]
      puts "The #{filecheck} did not exist, all shelves set to empty!"
    end  # end of if shelf file exists

    # find the first empty shelf
    pos = @@shelf_array.flatten.index('xxx') # absolute position by flattening the array
    ncols = @@shelf_array.first.size  # determine the number rows per shelf
    shelf = pos / ncols  # shelf id
    row = pos % ncols  # row on shelf
    empty_shelf = puts "From Class: Next Empty shelf #{shelf} row #{row}"
    # return syntax
    return {
      shelf_array: "#{shelf}",
      shelf_row: "#{row}"
    }
  end # end of allocateshelf method
end # end of class

# class method
def self.items
  @@shelf_array
end
@@shelf_array
 menu_action = 2
 if menu_action == 2   # WIP use case instead !!!!
   getemptyshelf = Shelves.new  # create a shelves instance
   nextemptyshelf = getemptyshelf.allocateshelf  # Determine the next empty Shelf and Row
   s = nextemptyshelf[:shelf_array]
   r = nextemptyshelf[:shelf_row]
   aa = @@shelf_array[s][r]
   puts "#{aa}"
 end
