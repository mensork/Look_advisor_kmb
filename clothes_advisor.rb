if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

current_path = File.dirname(__FILE__)

require_relative 'lib/gear'
require_relative 'lib/wardrobe'
require_relative 'lib/gear_constructor'

menu = "Выберите действие:\n" +
  "1. Добавить шмотку в гардероб\n" +
  "2. Подобрать шмотки под погоду"

input = nil
until [1, 2].include?(input)
  puts menu
  input = STDIN.gets.to_i
end

if input == 1
  parameters = []
  puts 'Введите название шмотки'
  parameters << name = STDIN.gets.chomp
  puts 'Введите тип шмотки(С большой буквы!)'
  parameters << type = STDIN.gets.chomp
  puts "Введите диапазон температур для #{name} в формате '(XX,YY)'"
  parameters << temperature_range = STDIN.gets.chomp
  puts "Введите название файла для #{name} (латиницей и с маленькой буквы!)"
  parameters << file_name = current_path + "/data/#{STDIN.gets.chomp}.txt"

  gear_constructor = GearConstructor.new(parameters)

  if File.exist?(file_name)
    puts 'Такая шмотка уже есть в гардеробе'
  else
    gear_constructor.create_new_gear
    puts 'Шмотка успешно добавлена в гардероб'
  end
else
  wardrobe = Wardrobe.from_dir('data')

  puts 'Сколько градусов за окном? (можно с минусом)'
  temperature = STDIN.gets.to_i
  wardrobe.get_look(temperature)

  puts 'Предлагаем сегодня надеть:'
  puts wardrobe.selected_clothes
end