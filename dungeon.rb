=begin
code does not have error checking, and lacks items, inventory,
but has operational group of objects that represent a dungeon,
and can be navigated in a basic fashion

to be revisited at a later date
=end

class Dungeon
  attr_accessor :player

  def initialize(player_name)
    #to store player and rooms
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  #finds room based on player's location, prints description of location
  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  #iterates through @rooms array and picks out room whose reference matches current location
  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }

  #takes reference related to direction's connection on current room..returns reference of destination room
  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  #makes navigating possible, takes direction and uses it to change location to room that's in that direction
  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end
  end


end

#Create the main dungeon object
my_dungeon = Dungeon.new("Vaughn Antonyan")

#Add rooms to the Dungeon
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", { :west => :smallcave })
my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", { :east => :largecave })

#Start the dungeon by placing the player in the large cave
my_dungeon.start(:largecave)
