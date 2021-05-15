import 'package:flutter/material.dart';

class WeatherProperty extends StatelessWidget {
  IconData icon;
  String propertyName;
  String propertyValue;

  WeatherProperty({required this.icon, required this.propertyName, required this.propertyValue});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(icon, size: 40,),
              ),
              Text(propertyName, style: theme.textTheme.headline5,)
            ],
          ),
          Text(propertyValue, style: theme.textTheme.headline5,)
        ],
      ),
    );
  }
}