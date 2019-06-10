class Train

  attr_reader :type, :speed, :route, :carriages

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def current_station
    route.stations[@current_station]
  end

  def previous_station
    route.stations[@current_station - 1] unless @current_station == 0
  end

  def next_station
    route.stations[@current_station + 1]
  end

  def speed_up(speed)
    @speed += speed if speed > 0
  end

  def speed_down(speed)
    if @speed - speed < 0
      @speed  = 0
    else
      @speed -= speed
    end
  end

  def stop
    @speed = 0
  end

  def add_carriage
    @carriages += 1 if speed == 0
  end

  def rmv_carriage
    @carriages -= 1 if speed == 0 && carriages > 0
  end

  def set_route(route)
    @route = route
    @current_station = 0
    route.first_station.accept_train(self)
  end

  def to_next_station
    if next_station
      current_station.send_train(self)
      next_station.accept_train(self)
      @current_station += 1
    end
  end

  def to_previous_station
    if previous_station
      current_station.send_train(self)
      previous_station.accept_train(self)
      @current_station -= 1
    end
  end
end
