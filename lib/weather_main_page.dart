import 'dart:developer';

import 'package:app_09/city_page.dart';
import 'package:app_09/geolocator_sevices.dart';
import 'package:app_09/weather_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({Key? key}) : super(key: key);

  @override
  _WeatherMainPageState createState() => _WeatherMainPageState();
}

class _WeatherMainPageState extends State<WeatherMainPage> {
  String? name;
  late String surname;
  Map<String, dynamic> weatherData = {};

  kolaLaypKel1(String akcha) {
    return 'kola';
  }

  kolaLaypKel2([String? akcha]) {
    return 'kola';
  }

  kolaLaypKel3({required String akcha}) {
    return 'kola';
  }

  kolaLaypKel4({String? akcha}) {
    return 'kola';
  }

  @override
  void didChangeDependencies() async {
    log('name - $name');
    await getWeatherByLocation();
    super.didChangeDependencies();

    kolaLaypKel1('1 som');
    kolaLaypKel2('1 som');
    kolaLaypKel2();

    kolaLaypKel3(akcha: '1 som');
    kolaLaypKel4(akcha: '1 som');
    kolaLaypKel4();
  }

  Future<void> getWeatherByLocation() async {
    final position = await GeolocatorServices().getCurrentLocation();

    if (position != null) {
      weatherData = await WeatherServices().getWeatherByLocation(position);

      setState(() {});
    } else {}
  }

  Future<void> getWeatherByCity(String city) async {
    weatherData = await WeatherServices().getWeatherByCityName(city);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/city.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: weatherData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              await getWeatherByLocation();
                            },
                            icon: SvgPicture.asset(
                              'assets/vectors/geo.svg',
                              color: Colors.white,
                              height: 45,
                            ),
                            label: SizedBox(),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              final String result =
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                return CityPage();
                              }));

                              if (result.isNotEmpty) {
                                await getWeatherByCity(result);
                              }
                              log('result - $result');
                            },
                            icon: SvgPicture.asset(
                              'assets/vectors/city.svg',
                              color: Colors.white,
                              height: 45,
                            ),
                            label: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        '${(weatherData['main']['temp'] as double).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 40,
                      ),
                      child: Text(
                        '${(weatherData['weather'][0]['description'])}',
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Text _getTextName() {
    if (name == null) {
      return const Text(
        'null',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      );
    } else {
      return Text(
        name!,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      );
    }
  }
}
