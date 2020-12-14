import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Please enter a city name ', textAlign: TextAlign.center,),
      backgroundColor: Colors.redAccent[100],
      
      action: SnackBarAction(
        label: 'Hide',
        onPressed: () {
          _scaffoldKey.currentState.hideCurrentSnackBar();


        },
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    city = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  if (city == '') {
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                    return;
                  }
                  var weatherData = await  WeatherModel().getLocationWeatherByCityName(city);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return LocationScreen(locationWeather: weatherData,);
                  }));
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
