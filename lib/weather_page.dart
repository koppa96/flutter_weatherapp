import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/state_models.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_property.dart';
import 'package:weather_app/weather_service.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = const WeatherService();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(state.selectedCity!.name),
      ),
      body: FutureBuilder(
        future: state.cityWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data as CityWeather;
              var theme = Theme.of(context);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Today's weather", style: theme.textTheme.headline4, textAlign: TextAlign.start,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: SvgPicture.network("https://www.metaweather.com/static/img/weather/${data.todaysWeather.weatherStateAbbreviation}.svg"),
                              ),
                              Text(data.todaysWeather.weatherStateName, style: theme.textTheme.headline5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${data.todaysWeather.maxTemp.toStringAsFixed(1)} ºC", style: theme.textTheme.headline6,),
                                  Text("${data.todaysWeather.minTemp.toStringAsFixed(1)} ºC", style: theme.textTheme.headline6,)
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 32, bottom: 32),
                            child: Column(
                              children: [
                                WeatherProperty(
                                    icon: Icons.north_east,
                                    propertyName: "Wind direction",
                                    propertyValue: data.todaysWeather.windDirection
                                ),
                                WeatherProperty(
                                  icon: Icons.speed,
                                  propertyName: "Wind speed",
                                  propertyValue: "${data.todaysWeather.windSpeed.toStringAsFixed(1)} km/h",
                                ),
                                WeatherProperty(
                                  icon: Icons.compress,
                                  propertyName: "Air pressure",
                                  propertyValue: "${data.todaysWeather.airPressure.toStringAsFixed(1)} hPa",
                                ),
                                WeatherProperty(
                                  icon: Icons.cloud,
                                  propertyName: "Humidity",
                                  propertyValue: "${data.todaysWeather.humidity}%",
                                ),
                                WeatherProperty(
                                  icon: Icons.visibility,
                                  propertyName: "Visibility",
                                  propertyValue: "${data.todaysWeather.visibility.toStringAsFixed(1)} km",
                                ),
                              ],
                            ),
                          ),
                          Text("Next day's weather", style: theme.textTheme.headline4,),
                        ],
                      ),
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: SvgPicture.network("https://www.metaweather.com/static/img/weather/${data.nextDaysWeather[index].weatherStateAbbreviation}.svg"),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("${data.nextDaysWeather[index].maxTemp.toStringAsFixed(1)} ºC", style: theme.textTheme.headline6,),
                                      Text("${data.nextDaysWeather[index].minTemp.toStringAsFixed(1)} ºC", style: theme.textTheme.headline6,),
                                    ],
                                  ),
                                ],
                              ),
                              Text(data.nextDaysWeather[index].weatherStateName, style: theme.textTheme.headline5,),
                              Text(DateFormat("E").format(data.nextDaysWeather[index].applicableDate), style: theme.textTheme.headline6,),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: data.nextDaysWeather.length
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("An error occurred."),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
