import 'package:json_annotation/json_annotation.dart';

part 'weather_service.g.dart';

@JsonSerializable()
class Location {
  int id;
  String title;
  String locationType;

  Location(this.id, this.title, this.locationType);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}

class WeatherService {

}