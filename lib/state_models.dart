import 'package:flutter/material.dart';
import 'package:weather_app/weather_service.dart';

class City {
  int id;
  String name;

  City(int id, String name) : this.id = id, this.name = name;
}

class WeatherDetails {
  String weatherStateName;
  String weatherStateAbbreviation;
  String windDirection;
  DateTime applicableDate;
  double minTemp;
  double maxTemp;
  double windSpeed;
  double airPressure;
  int humidity;
  double visibility;

  WeatherDetails({required this.weatherStateName,
    required this.weatherStateAbbreviation,
    required this.windDirection,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.windSpeed,
    required this.airPressure,
    required this.humidity,
    required this.visibility
  });
}

class WeatherListItem {
  String weatherStateName;
  String weatherStateAbbreviation;
  double minTemp;
  double maxTemp;
  DateTime applicableDate;

  WeatherListItem({
    required this.weatherStateName,
    required this.weatherStateAbbreviation,
    required this.minTemp,
    required this.maxTemp,
    required this.applicableDate
  });
}

class CityWeather {
  WeatherDetails todaysWeather;
  List<WeatherListItem> nextDaysWeather;

  CityWeather({required this.todaysWeather, required this.nextDaysWeather});
}

class AppState extends ChangeNotifier {
  final _service = WeatherService();

  String searchText = "";
  Future<List<City>> cities = Future.value([]);
  City? selectedCity;
  Future<CityWeather>? cityWeather;

  void changeSearchText(String searchText) {
    this.searchText = searchText;
    cities = _service.searchCities(searchText);
    notifyListeners();
  }

  void setSelectedCity(City city) {
    selectedCity = city;
    cityWeather = _service.getWeather(city.id);
    notifyListeners();
  }
}