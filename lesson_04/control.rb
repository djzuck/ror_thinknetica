class Control

def control
  loop do
    print 'Введите цифру:'
    print '1, чтобы создать станцию'
    print '2, чтобы создать поезд'
    print '3, чтобы создать маршрут и управлять станциями в нем (добавлять, удалять)'
    print '4, чтобы назначить маршрут поезду'
    print '5, чтобы добавить вагон к поезду'
    print '6, чтобы отцепить вагон от поезда'
    print '7, чтобы переместить поезд по маршруту вперед'
    print '8, чтобы переместить поезд по маршруту назад'
    print '9, чтобы просмотреть список станций'
    print '10, чтобы просмотреть список поездов на станции'
    print '0, чтобы завершить работу'
    user_input = gets.chomp.to_i
end

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
  to_next_station!
when 8
  to_previous_station!
when 9
  route_stations
when 10
  trains_on_station
when 0
  break
else
  print 'Вы ввели неверное значение.'
end

@stations_list = []
@trains_list = {}
@routes_list = []
@count_routes = 0

protected

  def show_routes
    @routes_list.each.with_index(1) do |route, index|
      print "#{index}. #{route.name.station_of_depart.capitalize} - #{route.name.station_of_arriv.capitalize}."
    end
  end

  def create_station
    print 'Введите название станции: '
    station_name = gets.chomp
    if @stations_list.include?(station_name)
      print "Станция с указанным названием была создана ранее."
    else
      new_station = Station.new(station_name)
      @stations_list << new_station
      print "Станция #{new_station} успешно создана."
    end
  end

  def create_train
    case create_train
      print 'Введите 1 для создания пассажирского поезда или 2 - для грузового: '
      type_train = gets.chomp.to_i

    when 1
      print 'Введите номер поезда: '
      number = gets.chomp
      if @trains_list.include?(number)
        print "Поезд с указанным номером № #{number} был создан ранее."
      else
        new_passTrain = PassengerTrain.new(number, type_train)
        @trains_list = { :number => type_train }
        print "Поезд № #{number} успешно создан."
      end

    when 2
      print 'Введите номер поезда: '
      number = gets.chomp
      if @trains_list.include?(number)
        print "Поезд с указанным номером № #{number} был создан ранее."
      else
        new_cargoTrain = CargoTrain.new(number, type_train)
        @trains_list = { :number => type_train }
        print "Поезд № #{number} успешно создан."
      end

    else
      print 'Неверно указан тип поезда.'
    end
  end

  def manage_route
    print 'Введите 1, чтобы создать маршрут, 2 - чтобы добавить станцию в маршрут, 3 - чтобы удалить станцию из маршрута: '
    manage = gets.chomp.to_i

    case manage_route
    when 1
      print 'Введите начальную станцию маршрута: '
      station_of_depart = gets.chomp
      print 'Введите конечную станцию маршрута: '
      station_of_arriv = gets.chomp
      new_route = Route.new(station_of_depart, station_of_arriv)
      @routes_list << new_route
      print "Маршрут #{station_of_depart} - #{station_of_arriv} успешно создан."

    when 2
      show_routes
      print 'Введите номер маршрута: '
      number_route = gets.chomp.to_i
      print 'Введите имя добавляемой станции: '
      station_name = gets.chomp
      routes_list[number_route - 1].add_station(station_name)
      print "Станция #{station_name} успешно добавлена в маршрут."

    when 3
      show_routes
      print 'Введите номер маршрута: '
      number_route = gets.chomp.to_i
      print 'Введите имя удаляемой станции: '
      station_name = gets.chomp
      routes_list[number_route - 1].delete_station(station_name)
      print "Станция #{station_name} успешно удалена из маршрута."
    else
      print 'Неверный запрос.'
  end

  def assign_route
    show_routes
    if create_route && create_train
      print 'Укажите номер маршрута для его назначения: '
      route = gets.chomp.to_i
      print 'Укажите номер поезда, которому будет назначен маршрут: '
      train = gets.chomp
      if @trains_list.include?{ |trains| trains == train }
        train.set_route(route - 1)
        print "Маршрут для поезда #{train} успешно назначен."
      else
        print 'Указанный поезд не найден.'
      end
    else
      print 'Вы не создали ни одного маршрута или поезда.'
    end
  end

  def add_carriage!
    if create_train
      print 'Укажите номер поезда: '
      train = gets.chomp
      if @trains_list.include?{ |trains| trains == train }
        train.set_route(route)
        print 'Укажите тип вагонов: 1 - если пассажирский, 2 - если грузовой): '
        type_carriage = gets.chomp.to_i
        if type_carriage == 1
          print 'Укажите количество вагонов в поезде: '
          carriage = gets.chomp
          train.add_pass_carriage(carriage)
          print "Вагон(-ы) успешно добавлен(-ы) к поезду #{train}."
        elsif type_carriage == 2
          print 'Укажите количество вагонов в поезде: '
          carriage = gets.chomp
          train.add_cargo_carriage(carriage)
          print "Вагон(-ы) успешно добавлен(-ы) к поезду #{train}."
        else
          print 'Вы ввели неверный тип вагона.'
        end
      end
    end
  end

  def rmv_carriage!
    if create_train
      print 'Укажите номер поезда: '
      train = gets.chomp
      if @trains_list.include?{ |trains| trains == train }
        train.rmv_carriage
        print "Вагон успешно удален у поезда #{train}."
      else
        print 'Указанный поезд не найден.'
      end
    end
  end

  def to_next_station!
    if create_route && create_train
      print 'Укажите номер поезда: '
      train = gets.chomp
      if @trains_list.include?{ |trains| trains == train }
        train.to_next_station
        current_station = train.current_station
        print "Поезд успешно перемещен на станцию #{current_station}."
      else
        print 'Указанный поезд не найден.'
      end
    else
      print 'Вы не создали ни одного маршрута или поезда.'
    end
  end

  def to_previous_station!
    if create_route && create_train
      print 'Укажите номер поезда: '
      train = gets.chomp
      if @trains_list.include?{ |trains| trains == train }
        train.to_previous_station
        current_station = train.current_station
        print "Поезд успешно перемещен на станцию #{current_station}."
      else
        print 'Указанный поезд не найден.'
      end
    else
      print 'Вы не создали ни одного маршрута или поезда.'
    end
  end

  def route_stations
    show_routes
    if create_route
      print 'Введите номер маршрута: '
      route = gets.chomp.to_i
      route_stations = routes_list[route - 1].show_stations
      print "Маршрут #{route} включает в себя следующие станции: #{route_stations}."
    else
      print 'Вы не создали ни одного маршрута.'
    end
  end

  def trains_on_station
    if create_train && create_station
      print 'Укажите название станции: '
      station = gets.chomp
      if @stations_list.include?{ |stations| stations == station }
        show_trains = station.trains
        puts "На станции #{station} расположены следующие поезда: #{show_trains}."
      else
        print 'Указанная станция не найдена.'
      end
    else
      print 'Вы не создали ни одного поезда или станции.'
    end
  end
end
