import 'package:geolocator/geolocator.dart';
import 'package:weather/models/weather_model.dart';
import 'package:dio/dio.dart';

class WeatherService {
  final Dio dio = Dio();
  String firstUrl =
      'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search';
  String apiKey = 'RwjEvfBaNI9jCsj5iH1Xd02OiuJGxhmI';
  String secondUrl = 'http://dataservice.accuweather.com/currentconditions/v1/';
  String returnLottieFile(String mainCondition) {
    String condition = mainCondition.toLowerCase();
    List<String> sunList = ['sunny','mostly sunny'];
    List<String> cloudyDay = ['partly sunny','hazy sunshine'];
    List<String> cloud = ['cloudy','dreary(overcast)','fog','mostly cloudy','intermittent clouds'];
    List<String> rain = ['showers','t-storms','rain'];
    List<String> rainyDay = ['mostly cloudy w/ showers','partly sunny w/ showers','mostly cloudy w/ t-storm','partly sunny w/ t-storm'];
    List<String> rainyNight = ['partly cloudy w/ showers','mostly cloudy w/ showers','partly cloudy w/ t-storms','mostly cloudy w/ t-storm'];
    List<String> windy = ['flurries','windy','mostly cloudy w/ flurries'];
    List<String> windyDay = ['mostly cloudy w/ flurries','partly sunny w/ flurries'];
    List<String> snow = ['sleet','freezing rain','rain and snow','mostly cloudy w/ snow'];
    List<String> clear = ['clear','mostly clear'];
    List<String> clearCloudy = ['partly cloudy','hazy moonlight'];
    if(sunList.contains(condition)) {
      return 'assets/lottie/sunny.json';
    } else if(cloudyDay.contains(condition)) {
      return 'assets/lottie/cloudy_day.json';
    } else if(cloud.contains(condition)) {
      return 'assets/lottie/cloudy.json';
    } else if(rain.contains(condition)) {
      return 'assets/lottie/rain.json';
    } else if(rainyDay.contains(condition)) {
      return 'assets/lottie/rainy_day.json';
    } else if(rainyNight.contains(condition)) {
      return 'assets/lottie/rainy_night.json';
    } else if(windy.contains(condition)) {
      return 'assets/lottie/windy.json';
    } else if(windyDay.contains(condition)) {
      return 'assets/lottie/windy_day.json';
    } else if(snow.contains(condition)) {
      return 'assets/lottie/snow.json';
    } else if(clear.contains(condition)) {
      return 'assets/lottie/clear.json';
    } else if(clearCloudy.contains(condition)) {
      return 'assets/lottie/cloudy_night.json';
    }
    return 'assets/lottie/sunny.json';
  }

  Future<Weather> getAccuApi() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final Response response = await dio.get(
        "$firstUrl?q=${position.latitude},${position.longitude}&apikey=$apiKey");
    if (response.statusCode == 200) {
      String key = response.data['Key'];
      String cityName = response.data['LocalizedName'];
      final Response newResponse =
          await dio.get("$secondUrl$key?apikey=$apiKey");
      if (newResponse.statusCode == 200) {
        double temprature =
            newResponse.data[0]['Temperature']['Metric']['Value'].toDouble();
        String weatherText = newResponse.data[0]["WeatherText"];
        return Weather(
          cityName: cityName,
          mainCondition: weatherText,
          temprature: temprature,
        );
      }
    }
    throw Exception("Failed to load data");
  }
}
