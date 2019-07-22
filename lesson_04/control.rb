class Control

  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  def control
    loop do
      puts 'Введите цифру:'
      puts '1, чтобы создать станцию'
      puts '2, чтобы создать поезд'
      puts '3, чтобы создать маршрут и управлять станциями в нем (добавлять, удалять)'
      puts '4, чтобы назначить маршрут поезду'
      puts '5, чтобы добавить вагон к поезду'
      puts '6, чтобы отцепить вагон от поезда'
      puts '7, чтобы переместить поезд по маршруту вперед и назад'
      puts '8, чтобы просмотреть список станций'
      puts '9, чтобы просмотреть список поездов на станции'
      puts '0, чтобы завершить работу'
      user_input = gets.chomp.to_i

      case user_input
      when 1
        create_station
      when 2
        create_train
      when 3
        manage_route
      when 4
        assign_route
      when 5
        add_carriage!
      when 6
        rmv_carriage!
      when 7
        move_train
      when 8
        route_stations
      when 9
        trains_on_station
      when 0
        break
      else
        puts 'Вы ввели неверное значение.'
      end
    end
  end

  protected #юзер может только вводить запрашиваемые интерфейсом данные и не должен иметь возможности вызывать методы напрямую

  def show_routes
    print 'Список маршрутов: '
    @routes_list.each.with_index(1) do |route, index|
    puts "#{index}. #{route.station_of_depart.capitalize} - #{route.station_of_arriv.capitalize}."
    end
  end

  def show_trains
    print 'Список поездов: '
    @trains_list.each.with_index(1) do |train, index|
    puts "#{index}. #{train}."
    end
  end

  def show_stations
    print 'Список станций: '
    @stations_list.each.with_index(1) do |station, index|
    puts "#{index}. #{station}."
    end
  end

  def create_station
    print 'Введите название станции: '
    station_name = gets.chomp
    if (@stations_list || '').include?(station_name)
      puts "Станция с указанным названием была создана ранее."
    else
      new_station = Station.new(station_name)
      @stations_list << new_station
      puts "Станция #{station_name} успешно создана."
    end
  end

  def create_train
    print 'Введите 1 для создания пассажирского поезда или 2 - для грузового: '
    type_train = gets.chomp.to_i

    case type_train
    when 1
      print 'Введите номер поезда: '
      number = gets.chomp
      new_pass_train = PassengerTrain.new(number, type_train)
      @trains_list << new_pass_train
      puts "Поезд № #{number} успешно создан."

    when 2
      print 'Введите номер поезда: '
      number = gets.chomp
      new_cargo_train = CargoTrain.new(number, type_train)
      @trains_list << new_cargo_train
      puts "Поезд № #{number} успешно создан."

    else
      puts 'Неверно указан тип поезда.'
    end
  end

  def manage_route
    print 'Введите 1, чтобы создать маршрут, 2 - чтобы добавить станцию в маршрут, 3 - чтобы удалить станцию из маршрута: '
    manage = gets.chomp.to_i

    case manage
    when 1
      print 'Введите начальную станцию маршрута: '
      station_of_depart = gets.chomp
      print 'Введите конечную станцию маршрута: '
      station_of_arriv = gets.chomp
      new_route = Route.new(station_of_depart, station_of_arriv)
      @routes_list << new_route
      puts "Маршрут #{station_of_depart.capitalize} - #{station_of_arriv.capitalize} успешно создан."

    when 2
      show_routes
      print 'Введите номер маршрута: '
      route_number = gets.chomp.to_i
      if route_number > (@routes_list.size + 1) || route_number < 1
        puts 'Неверный запрос.'
      else
        print 'Введите имя добавляемой станции: '
        station_name = gets.chomp
        @routes_list[route_number - 1].add_station(station_name)
        puts "Станция #{station_name.capitalize} успешно добавлена в маршрут."
      end

    when 3
      show_routes
      print 'Введите номер маршрута: '
      route_number = gets.chomp.to_i
      if route_number > (@routes_list.size + 1) || route_number < 1
        puts 'Неверный запрос.'
      else
        print 'Введите имя удаляемой станции: '
        station_name = gets.chomp
        @routes_list[route_number - 1].delete_station(station_name)
        puts "Станция #{station_name} успешно удалена из маршрута."
      end

    else
      puts 'Неверный запрос.'
    end
  end

  def assign_route
    if (@routes_list || '').nil? && (@trains_list || '').nil?
      puts 'Вы не создали ни одного маршрута или поезда.'
    else
      show_routes
      print 'Введите номер маршрута для его назначения: '
      route = gets.chomp.to_i
      if route > (@routes_list.size + 1) || route < 1
        puts 'Неверный запрос.'
      else
        show_trains
        print 'Введите номер поезда, которому будет назначен маршрут: '
        train = gets.chomp.to_i
        if train > (@trains_list.size + 1) || train < 1
          puts 'Неверный запрос.'
        else
          @trains_list[train - 1].set_route(route - 1)
          puts 'Маршрут для поезда успешно назначен.'
        end
      end
    end
  end

  def add_carriage!
  if (@trains_list || '').nil?
    puts 'Вы не создали ни одного поезда.'
  else
    show_trains
    print 'Введите номер поезда: '
    train = gets.chomp.to_i
    if train > (@trains_list.size + 1) || train < 1
      puts 'Неверный запрос.'
    else
      print 'Введите тип вагонов: 1 - если пассажирский, 2 - если грузовой): '
      type_carriage = gets.chomp.to_i
        if type_carriage == 1
          print 'Введите количество вагонов в поезде: '
          carriage = gets.chomp.to_i
          @trains_list[train - 1].add_pass_carriage(carriage)
          puts 'Вагон(-ы) успешно добавлен(-ы) к поезду.'
        elsif type_carriage == 2
          print 'Введите количество вагонов в поезде: '
          carriage = gets.chomp.to_i
          @trains_list[train - 1].add_cargo_carriage(carriage)
          puts 'Вагон(-ы) успешно добавлен(-ы) к поезду.'
        else
          puts 'Вы ввели неверный тип вагона.'
        end
      end
    end
  end

  def rmv_carriage!
    if (@trains_list || '').nil?
      puts 'Вы не создали ни одного поезда.'
    else
      show_trains
      print 'Введите номер поезда: '
      train = gets.chomp.to_i
      if train > (@trains_list.size + 1) || train < 1
        puts 'Неверный запрос.'
      else
        @trains_list[train - 1].rmv_carriage
        puts "Вагон успешно удален у поезда #{train}."
      end
    end
  end

  def move_train
    if (@routes_list || '').nil? && (@trains_list || '').nil?
      puts 'Вы не создали ни одного маршрута или поезда.'
    else
      show_trains
      print 'Введите номер поезда: '
      train_number = gets.chomp.to_i
      if train > (@trains_list.size + 1) || train < 1
        puts 'Неверный запрос.'
      else
        print "Введите 1, чтобы переместить поезд № #{train_number} на следующую станцию, 2 - на предыдущую: "
        input = gets.chomp.to_i

        case input
        when 1
          @trains_list[train_number - 1].to_next_station
          current_station = @trains_list[train_number - 1].current_station
          puts "Поезд успешно перемещен на станцию #{current_station}."

        when 2
          @trains_list[train_number - 1].to_previous_station
          current_station = @trains_list[train_number - 1].current_station
          puts "Поезд успешно перемещен на станцию #{current_station}."

        else
          puts 'Неверный запрос.'
        end
      end
    end
  end

  def route_stations
    if (@routes_list || '').nil?
      puts 'Вы не создали ни одного маршрута.'
    else
      show_routes
      print 'Введите номер маршрута: '
      route = gets.chomp.to_i
      if route > (@routes_list.size + 1) || route < 1
        puts 'Неверный запрос.'
      else
        route_stations = @routes_list[route - 1].show_stations
        puts "Маршрут включает в себя следующие станции: #{route_stations}."
      end
    end
  end

  def trains_on_station
    if (@trains_list || '').nil? && (@stations_list || '').nil?
      puts 'Вы не создали ни одного поезда или станции.'
    else
      show_stations
      print 'Укажите номер станции: '
      station = gets.chomp.to_i
      if station > (@stations_list.size + 1) || station < 1
        puts 'Неверный запрос.'
      else
        show_trains = @stations_list[station - 1].trains
        puts "На станции расположены следующие поезда: #{show_trains}."
      end
    end
  end

end
