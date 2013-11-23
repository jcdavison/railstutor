#RUBYONRAILSTUTOR.COM - LESSON 2
##BUILDING A BUILDING WITH RUBY OBJECTS

### CLASS FORMAT - DEMONSTRATE, EXPLAIN, REPLICATE

### STRATEGIC LEARNING GOALS
1. Understand create build and manipulate Ruby Objects.

#### SCREENCAST OF STRATEGIC LEARNING GOALS

[![ScreenShot](https://dl.dropboxusercontent.com/u/12834645/railstutor/rubyobjects.jpg)](https://vimeo.com/79154085)

### TACTICAL LEARNING GOALS
1. Build something small. 

  ```ruby

  class Room
    attr_reader :color, :style, :windows
    attr_writer :color, :style, :windows

    def initialize
      @color = nil
      @style = nil
      @windows = nil
    end

    def paint(color)
      @color = color
    end

    def create(style, windows)
      @style = style
      @windows = windows
    end

    def complete?
      if @style == "corner" && @windows == 2
        return true
      elsif @style == "regular" && @windows == 1
        return true
      else
        return false
      end
    end
  end

  class Floor 
    attr_accessor :rooms, :capacity

    def initialize(capacity = nil)
      @rooms = []
      @capacity = capacity 
    end

    def complete?
      return unless @capacity
      if @rooms.length == @capacity
        return true
      else
        return false
      end
    end

    def inspect_room(room)
      if room.complete?
        @rooms.push room
        return @rooms
      else
        return false
      end
    end
  end

  class Building
    attr_accessor :floors, :height
    def initialize(height = nil)
      @floors = []
      @height = height
    end

    def built?
      return unless @height
      if @floors.count == @height
        return true
      else
        return false
      end
    end

    def add_floor(floor)
      if floor.complete?
        @floors.push floor
        return @floors
      else
        return false
      end
    end
  end
  ```
