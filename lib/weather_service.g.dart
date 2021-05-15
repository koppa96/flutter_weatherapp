// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['woeid'] as int,
    json['title'] as String,
    json['location_type'] as String,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'woeid': instance.woeid,
      'title': instance.title,
      'location_type': instance.locationType,
    };

ConsolidatedWeather _$ConsolidatedWeatherFromJson(Map<String, dynamic> json) {
  return ConsolidatedWeather(
    json['weather_state_name'] as String,
    json['weather_state_abbr'] as String,
    json['wind_direction_compass'] as String,
    DateTime.parse(json['applicable_date'] as String),
    (json['min_temp'] as num).toDouble(),
    (json['max_temp'] as num).toDouble(),
    (json['wind_speed'] as num).toDouble(),
    (json['air_pressure'] as num).toDouble(),
    json['humidity'] as int,
    (json['visibility'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ConsolidatedWeatherToJson(
        ConsolidatedWeather instance) =>
    <String, dynamic>{
      'weather_state_name': instance.weatherStateName,
      'weather_state_abbr': instance.weatherStateAbbreviation,
      'wind_direction_compass': instance.windDirection,
      'applicable_date': instance.applicableDate.toIso8601String(),
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'wind_speed': instance.windSpeed,
      'air_pressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
    };

LocationWeather _$LocationWeatherFromJson(Map<String, dynamic> json) {
  return LocationWeather(
    (json['consolidated_weather'] as List<dynamic>)
        .map((e) => ConsolidatedWeather.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LocationWeatherToJson(LocationWeather instance) =>
    <String, dynamic>{
      'consolidated_weather': instance.consolidatedWeather,
    };
