class Quadrilateral

    attr_reader :sides, :side_length
    def initialize(side_length = 0, side_width=0)
        @sides = 4
        @side_length = side_length
        @side_width = side_width
    end

    def perimeter
    	@sides * @side_length
    end
end

class Rectangle < Quadrilateral
	def initialize(side_length=0, side_width=0)
		super
	end

	def perimeter
		return ((@side_length * 2) + (@side_width * 2))
	end
	
	def area
		@side_length * @side_width
	end
end

class Square < Rectangle
	def initialize(side_length=0)
		super
		@side_length = side_length
	end

	def length
		@side_length
	end

	def perimeter
		@side_length * 4
	end

	def area
		@side_length * side_length
	end
end

class Trapezoid < Quadrilateral
	def initialize(side_length1=0, side_length2=0, side_length3=0, side_length4=0)
		super()
		@side_length1 = side_length1
		@side_length2 = side_length2
		@side_length3 = side_length3
		@side_length4 = side_length4	
	end

	def perimeter
		@side_length1 + @side_length2 + @side_length3 + @side_length4
	end
end

class Rhombus < Trapezoid
	def initialize(side_length=0)
		super
		@side_length = side_length
	end

	def length
		@side_length
	end
end

def test

	puts "Square Tests:"
	square = Square.new(1)
	puts square.is_a? Rectangle
	puts square.is_a? Quadrilateral
	puts square.perimeter == 4
	puts square.area == 1
	puts square.length == 1

	puts "Rectangle Tests:"
	rect = Rectangle.new(2, 3)
	puts rect.is_a? Quadrilateral
	puts rect.is_a? Square
	puts rect.perimeter == 10
	puts rect.area == 6

	puts "Trapezoid tests:"
	trap = Trapezoid.new(2, 4, 4, 10)
	puts trap.is_a? Quadrilateral
	puts trap.perimeter == 20

	puts "Rhombus tests:"
	rhom = Rhombus.new(5)
	puts rhom.is_a? Quadrilateral
	puts rhom.is_a? Trapezoid
	puts rhom.length == 5


end

test