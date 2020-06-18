class GameOfLife
  attr_accessor :world, :neighborhood

  def initialize(size)
    @size = size
    @world = Array.new(size){Array.new(size)} 
    @neighborhood  = Array.new(size){Array.new(size)}
  end

  def populate
    size.times do |row|
      size.times do |col|
        world[row][col] = ['_', '1'].sample
        neighborhood[row][col] = 0
      end
    end
  end

  def print_world
    world.each { |elem| puts "#{elem}" }
  end

  def print_neighborhood
    neighborhood.each { |elem| puts "#{elem}" }
  end

  def next_step(values = (1..size-2).to_a)
    values.each do |row|
      values.each { |col| rules(row, col) }
    end
  end

  def rules(row, col, counter=0)
    counter += 1 unless world[row-1][col] == '_'
    counter += 1 unless world[row-1][col-1] == '_'
    counter += 1 unless world[row-1][col+1] == '_'
    counter += 1 unless world[row][col-1] == '_'
    counter += 1 unless world[row][col+1] == '_'
    counter += 1 unless world[row+1][col-1] == '_'
    counter += 1 unless world[row+1][col+1] == '_'
    counter += 1 unless world[row+1][col] == '_'

    neighborhood[row][col] = counter
  end

  def find_life
    size.times do |row|
      size.times { |col| world[row][col] = still_alive?(row, col) ? '1' : '_' }
    end  
  end

  private
    attr_reader :size

    def still_alive?(row, col)
      neighborhood[row][col] == 2 || neighborhood[row][col] == 3
    end
end 

game = GameOfLife.new(10)
game.populate
game.print_world
idx = 1

while(idx <= 20) do
  game.next_step
  puts "\n\n_____________________ iteration: #{idx}"
  puts 'Neighborhood Matrix'
  game.print_neighborhood
  puts '---------------------'
  puts 'Next generation'
  game.find_life
  game.print_world
  idx += 1
end