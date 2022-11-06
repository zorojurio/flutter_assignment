import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => HomePage(),
  );
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Light Sensor"),
            FutureBuilder<bool?>(
                future: LightSensor.hasSensor,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final bool? hasSensor = snapshot.data;
                    if (hasSensor == null) {
                      return const Text('Unable to find out if there is a lightsensor');
                    } else if (hasSensor) {
                      return StreamBuilder<int>(
                          stream: LightSensor.lightSensorStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text('Running on: ${snapshot.data} LUX');
                            } else {
                              return const Text('Running on: unknown');
                            }
                          });
                    } else {
                      return const Text("Your device doesn't have a light sensor");
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}