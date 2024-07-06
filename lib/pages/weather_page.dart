import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherService weatherService = WeatherService();
  Color textColor = const Color.fromARGB(255, 217, 217, 217);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 27, 34),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 27, 34),
        elevation: 0,
        shadowColor: const Color.fromARGB(255, 24, 27, 34),
        centerTitle: true,
        title: Text(
          'Rain Radar',
          style: TextStyle(
            color: textColor,
            fontFamily: 'Kalameh',
          ),
        ),
      ),
      body: FutureBuilder(
        future: weatherService.getAccuApi(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'Kalameh',
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            weatherService
                                .returnLottieFile(snapshot.data!.mainCondition),
                          ),
                          Text(
                            snapshot.data!.mainCondition,
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'Kalameh',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            snapshot.data!.cityName,
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'Kalameh',
                            ),
                          ),
                          Text(
                            "${snapshot.data!.temprature} °C",
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'Kalameh',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
