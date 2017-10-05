class Gear
  attr_reader :name, :type, :temperature_range

  def initialize(file_name)
    f = File.new(file_name, 'r:UTF-8')
    array = f.readlines
    f.close
    @name = array[0].chomp
    @type = array[1].chomp
    @temperature_range = get_range(array[2])
  end

  def get_range(string)
    array = string.gsub(/[() ]/, '').split(',')
    array[0].to_i..array[1].to_i
  end

  def suitable?(temperature)
    @temperature_range.include?(temperature)
  end

  def to_s
    "#{@name}(#{@type}) #{@temperature_range}"
  end
end