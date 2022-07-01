import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getLocWeather() async {
    Location loc = Location();
    await loc.getLocation();

    Networking net = await Networking(
        URL:
            'https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=2da3ecaf92f955653031ab248d4a12ec&units=metric');
    return await net.getData();
  }

  Future<dynamic> getCityWeather(String cityName) async {
    Networking net = await Networking(
        URL:
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=2da3ecaf92f955653031ab248d4a12ec&units=metric');
    var data = await net.getData();
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
