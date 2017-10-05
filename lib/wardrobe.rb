class Wardrobe
  attr_reader :clothes, :selected_clothes

  def self.from_dir(dir)
    files_array = Dir.glob("#{dir}/*.txt")

    clothes = []
    files_array.each_index do |i|
      clothes << Gear.new(files_array[i])
    end
    self.new(clothes)
  end

  def initialize(gear)
    @clothes = gear
  end

  def clothes_types
    @clothes_types = []
    @clothes.each do |item|
      @clothes_types << item.type
    end
    @clothes_types.uniq
  end

  def clothes_of_one_type(type)
    clothes_of_one_type = []
    clothes.each do |item|
      if item.type == type
        clothes_of_one_type << item
      end
    end
    clothes_of_one_type
  end

  def get_hash(temperature)
    hash = {}
    clothes_types.each do |type|
      array = []
      clothes_of_one_type(type).each do |item|
        array << item if item.suitable?(temperature)
      end
      hash[type] = array
    end
    hash
  end

  def get_look(temperature)
    @selected_clothes = []
    get_hash(temperature).each_pair do |key, value|
      if value.empty?
        @selected_clothes << "Из категории '#{key}' ничего подходящего нет"
      else
        @selected_clothes << value.sample
      end
    end
    @selected_clothes
  end

end