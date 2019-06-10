class Route

  attr_reader :stations

  def initialize(station_of_depart, station_of_arriv)
    @stations = [station_of_depart, station_of_arriv]
  end

  def station_of_depart
    stations.first
  end

  def station_of_arriv
    stations.last
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    return if [station_of_depart, station_of_arriv].include?(station)
    stations.delete(station)
  end

  def show_stations
    stations.each { |station| puts station.name }
  end
end
