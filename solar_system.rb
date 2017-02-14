# hash for data for each planet
# diameter in km
# mass in Earths
# average distance from sun in millions of km
# orbital period in Earth years

planet_data = {
  :mercury => {
    name: "Mercury",
    diameter: 4879,
    moons: 0,
    moon_names: nil,
    mass: 0.055,
    distance_from_sun: 57.9,
    orbital_period: 0.24
  },
  :venus => {
    name: "Venus",
    diameter: 12104,
    moons: 0,
    moon_names: nil,
    mass: 0.815,
    distance_from_sun: 108.2,
    orbital_period: 0.62
  },
  :earth => {
    name: "Earth",
    diameter: 12742,
    moons: 1,
    moon_names: ["Moon"],
    mass: 1,
    distance_from_sun: 149.6,
    orbital_period: 1
  },
  :mars => {
    name: "Mars",
    diameter: 6779,
    moons: 2,
    moon_names: ["Phobos", "Deimos"],
    mass: 0.815,
    distance_from_sun: 227.9,
    orbital_period: 1.88
  },
  :jupiter => {
    name: "Jupiter",
    diameter: 139822,
    moons: 67,
    moon_names: ["Io", "Europa", "Ganymede", "Callisto"],
    mass: 317.8,
    distance_from_sun: 778.5,
    orbital_period: 11.86
  },
  :saturn => {
    name: "Saturn",
    diameter: 116464,
    moons: 53,
    moon_names: ["Titan", "Iapetus", "Rhea", "Dione", "Tethys", "Mimas", "Enceladus", "Hyperion", "Phoebe"],
    mass: 95,
    distance_from_sun: 1429,
    orbital_period: 29.46
  },
  :uranus => {
    name: "Uranus",
    diameter: 50724,
    moons: 27,
    moon_names: ["Oberon", "Titania", "Ariel", "Umbriel", "Miranda"],
    mass: 15,
    distance_from_sun: 2871,
    orbital_period: 84.01
  },
  :neptune => {
    name: "Neptune",
    diameter: 49244,
    moons: 13,
    moon_names: ["Triton", "Proteus", "Nereid"],
    mass: 15,
    distance_from_sun: 2871,
    orbital_period: 164.8
  },
  :pluto => {
    name: "Pluto",
    diameter: 2374,
    moons: 5,
    moon_names: ["Charon", "Nix", "Styx", "Kerberos", "Hydra"],
    mass: 0.002,
    distance_from_sun: 5900,
    orbital_period: 248
  }
}

class Planet
  attr_reader :name, :diameter, :moons, :moon_names, :mass, :distance_from_sun, :orbital_period

  def initialize (planet_hash)
    @name = planet_hash[:name]
    @diameter = planet_hash[:diameter]
    @moons = planet_hash[:moons]
    @moon_names = planet_hash[:moon_names]
    @mass = planet_hash[:mass]
    @distance_from_sun = planet_hash[:distance_from_sun]
    @orbital_period = planet_hash[:orbital_period]
  end

end

class SolarSystem
  attr_accessor :planets
  def initialize (planet_array)
    @planets = planet_array
    @age = 4_500_000_000
  end

  def add_planet (new_planet)
    @planets << new_planet
  end

  def print_planets
    self.planets.each {|planet| puts planet.name}
  end

  # compares the distance of each planet in the SolarSystem to every other Planet
  def compare_distance_all
    puts "Distances between planets, in millions of kilometers"
    self.planets.each do |planet1|
      puts "#{planet1.name}:"
      self.planets.each do |planet2|
        if planet1 != planet2
          distance = (planet1.distance_from_sun - planet2.distance_from_sun).abs.round(2)
          puts "   Distance from #{planet2.name}: #{distance}"
        end
      end
      puts
    end
  end

  # gives the distance of two specified planets in SolarSystem
  def distance (planet_name1, planet_name2)
    distance1 = 0
    distance2 = 0
    print "Distance from #{planet_name1} to #{planet_name2} in millions of kilometers: "

    self.planets.each do |planet|
      if planet.name == planet_name1
        distance1 = planet.distance_from_sun
      elsif planet.name == planet_name2
        distance2 = planet.distance_from_sun
      end
    end
    puts "#{(distance1 - distance2).abs.round(2)}"
  end

  # calculates and displays local year for all planets in SolarSystem
  def local_year_all
    puts "Local year based on orbits around the sun since year 0"
    self.planets.each do |planet|
      print "#{planet.name}:"
      year = (@age / planet.orbital_period).round(0)
      formatted_year = year.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
      puts "#{formatted_year} #{planet.name}-years"
    end
  end

  # takes a parameter and just displays one planet's local year
  def local_year(planet_name)
    @planet_name = planet_name
    #iterate over planet array to find requested planet
    self.planets.each do |planet|
      if planet.name == @planet_name
        orbital_period = planet.orbital_period
        puts "Local year based on orbits around the sun since year 0"
        print "#{planet.name}:"
        year = (@age / orbital_period).round(0)
        formatted_year = year.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        puts "#{formatted_year} #{planet.name}-years"
      end
    end
  end

end



# initial version: adding a list of planets; calling a method to add a planet
# planet_array = [
#         Planet.new(planet_data[:mercury]),
#         Planet.new(planet_data[:venus]),
#         Planet.new(planet_data[:mars])
#       ]
# my_solar_system.add_planet(Planet.new(planet_data[:earth]))
# my_solar_system.print_planets

# reads in all the planets at once from planet_data hash
planet_array = []
planet_data.keys.each do |planet|
  planet_array << Planet.new(planet_data[planet])
end

my_solar_system = SolarSystem.new(planet_array)
my_solar_system.print_planets
puts

# more verbose version that displays all the interplanetary distances
my_solar_system.compare_distance_all

# gives distance between two specified planets
my_solar_system.distance("Venus", "Uranus")
puts
my_solar_system.local_year("Mercury")
puts
my_solar_system.local_year_all
