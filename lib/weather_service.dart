import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart';

import 'state_models.dart';

part 'weather_service.g.dart';

@JsonSerializable()
class Location {
  int woeid;
  String title;

  @JsonKey(name: "location_type")
  String locationType;

  Location(this.woeid, this.title, this.locationType);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}

@JsonSerializable()
class ConsolidatedWeather {
  @JsonKey(name: "weather_state_name")
  String weatherStateName;

  @JsonKey(name: "weather_state_abbr")
  String weatherStateAbbreviation;

  @JsonKey(name: "wind_direction_compass")
  String windDirection;

  @JsonKey(name: "applicable_date")
  DateTime applicableDate;

  @JsonKey(name: "min_temp")
  double minTemp;

  @JsonKey(name: "max_temp")
  double maxTemp;

  @JsonKey(name: "wind_speed")
  double windSpeed;

  @JsonKey(name: "air_pressure")
  double airPressure;

  int humidity;
  double visibility;

  ConsolidatedWeather(
    this.weatherStateName,
    this.weatherStateAbbreviation,
    this.windDirection,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.windSpeed,
    this.airPressure,
    this.humidity,
    this.visibility
  );

  Map<String, dynamic> toJson() => _$ConsolidatedWeatherToJson(this);
  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) => _$ConsolidatedWeatherFromJson(json);
}

@JsonSerializable()
class LocationWeather {
  @JsonKey(name: "consolidated_weather")
  List<ConsolidatedWeather> consolidatedWeather;

  LocationWeather(this.consolidatedWeather);

  Map<String, dynamic> toJson() => _$LocationWeatherToJson(this);
  factory LocationWeather.fromJson(Map<String, dynamic> json) => _$LocationWeatherFromJson(json);
}

class WeatherService {
  final String baseUrl;

  const WeatherService({this.baseUrl = "www.metaweather.com"});

  Future<List<City>> searchCities(String searchText) async {
    try {
      var response = await get(Uri.https(baseUrl, "api/location/search", { "query": searchText }));
      if (response.statusCode >= 200 || response.statusCode < 300) {
        Iterable jsonDecoded = jsonDecode(response.body);
        return jsonDecoded.map((e) => Location.fromJson(e))
            .map((location) => City(location.woeid, location.title))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    return <City>[];
  }

  Future<CityWeather> getWeather(int cityId) async {
    var response = await get(Uri.https(baseUrl, "api/location/$cityId"));
    if (response.statusCode >= 200 || response.statusCode < 300) {
      var jsonDecoded = jsonDecode(response.body);
      var locationWeather = LocationWeather.fromJson(jsonDecoded);
      var todaysWeather = locationWeather.consolidatedWeather[0];
      return CityWeather(
        todaysWeather: WeatherDetails(
          weatherStateName: todaysWeather.weatherStateName,
          weatherStateAbbreviation: todaysWeather.weatherStateAbbreviation,
          windDirection: todaysWeather.windDirection,
          windSpeed: todaysWeather.windSpeed,
          applicableDate: todaysWeather.applicableDate,
          minTemp: todaysWeather.minTemp,
          maxTemp: todaysWeather.maxTemp,
          airPressure: todaysWeather.airPressure,
          humidity: todaysWeather.humidity,
          visibility: todaysWeather.visibility
        ),
        nextDaysWeather: locationWeather.consolidatedWeather.skip(1)
          .map((e) => WeatherListItem(
            weatherStateName: e.weatherStateName,
            weatherStateAbbreviation: e.weatherStateAbbreviation,
            minTemp: e.minTemp,
            maxTemp: e.maxTemp,
            applicableDate: e.applicableDate)
          ).toList(),
      );
    }

    throw new Exception("Failed to load weather.");
  }
}