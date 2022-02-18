import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<Position> _locStream = StreamController();
  late StreamSubscription<Position> locationSubscription;
  late Color textColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    GeolocatorPlatform.instance.requestPermission();
  }

  @override
  void dispose() {
    _locStream.close();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startLocation() {
      final positionStream =
          Geolocator.getPositionStream().handleError((error) {});
      locationSubscription = positionStream.listen((Position position) {
        _locStream.sink.add(position);

        if (textColor == Colors.blue) {
          textColor = Colors.red;
        } else {
          textColor = Colors.blue;
        }
      });
    }

    pauseLocation() async {
      locationSubscription.pause();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: StreamBuilder(
          stream: _locStream.stream,
          builder: (context, snapshot) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                color: Colors.pink.withOpacity(0.3),
                onPressed: () {
                  startLocation();
                },
                child: const Text("press here to know where I'm right now!"),
              ),
              const Spacer(),
              const Text(
                "Hello I'm at",
                style: TextStyle(
                  fontSize: 21,
                ),
                textAlign: TextAlign.center,
              ),
              Center(
                child: Text(
                  snapshot.data == null
                      ? "don't know yet"
                      : snapshot.connectionState == ConnectionState.waiting
                          ? "waiting"
                          : snapshot.data.toString(),
                  style: TextStyle(color: textColor),
                ),
              ),
              FlatButton(
                color: Colors.yellow.withOpacity(0.3),
                onPressed: () {
                  pauseLocation();
                },
                child: const Text("Okay stop watching my location!"),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
