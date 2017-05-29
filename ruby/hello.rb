puts "hello"

ld = 10

def brians(val1, val2)
  ld = 12
  puts ld
  val1 + val2
end

puts brians(23,43)
puts ld

class Space
  attr_accessor :planetname
  def initialize(name)
    @planetname=name
  end
  def planet(xname)
    @planetname=xname
  end
end

p1=Space.new("Jupiter")
puts p1.inspect
p2=Space.new("Pluto")
puts p2.inspect

p1.planet("mars")
p2.planet("venus")

puts p1.inspect
puts p2.inspect

puts p1.planetname
puts p2.planetname
