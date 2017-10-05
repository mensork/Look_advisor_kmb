class GearConstructor
  def initialize(parameters_array)
    @name = parameters_array[0]
    @type = parameters_array[1]
    @temperature_range = parameters_array[2]
    @file_name = parameters_array[3]
  end

  def create_new_gear
      f = File.new(@file_name, 'a:UTF-8')
      f.puts(@name)
      f.puts(@type)
      f.puts(@temperature_range)
      f.close
  end
end