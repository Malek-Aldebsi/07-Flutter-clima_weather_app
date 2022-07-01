import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherdata;

  LocationScreen(this.weatherdata);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String cityName;
  String icon;
  String message;

  void updateVar(dynamic data) {
    setState(() {
      if (data == null) {
        temperature = 0;
        cityName = '';
        message = 'Unable to get weather data';
        icon = 'Error';
        return;
      }
      double temp = data['main']['temp'];
      temperature = temp.toInt();
      cityName = data['name'];
      int condition = data['weather'][0]['id'];
      icon = weather.getWeatherIcon(condition);
      message = weather.getMessage(temperature);
    });
  }

  @override
  void initState() {
    super.initState();
    updateVar(widget.weatherdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      updateVar(await weather.getLocWeather());
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var city = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (city != null) {
                        dynamic temp = await weather.getCityWeather(city);
                        updateVar(temp);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
