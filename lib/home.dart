import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
class AccelerometerData {
  final double value;
  final DateTime timestamp;

  AccelerometerData(this.value, this.timestamp);
}

class TennisGamePage extends StatefulWidget {
  @override
  _TennisGamePageState createState() => _TennisGamePageState();
}

class _TennisGamePageState extends State<TennisGamePage> {
  double accelerationX = 0.0;
  double accelerationY = 0.0;
  double accelerationZ = 0.0;
  double rotationX = 0.0;
  double rotationY = 0.0;
  double rotationZ = 0.0;
  double mass = .210 ; // Mass of the racket in kg
  List<AccelerometerData> zValues = [];
  double maxZValue = 0.0;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        accelerationZ = event.z;
        zValues.add(AccelerometerData(accelerationZ, DateTime.now()));
      });
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        rotationX = event.x;
        rotationY = event.y;
        rotationZ = event.z;
      });
    });
  }

  void startApp() {
    timer = Timer.periodic(Duration(seconds: 4), (_) {
      maxForce();
    });
  }

  void stopApp() {
    timer?.cancel();
  }

  void maxForce() {
    DateTime currentTime = DateTime.now();
    DateTime fourSecondsAgo = currentTime.subtract(Duration(seconds: 4));
    List<double> recentZValues = zValues
        .where((data) => data.timestamp.isAfter(fourSecondsAgo))
        .map((data) => data.value)
        .toList();

    if (recentZValues.isNotEmpty) {
      maxZValue = recentZValues.reduce(max);
      print('Maximum Z Value in the last 4 seconds: $maxZValue');
    } else {
      // If no values were recorded in the last 4 seconds, set maxZValue to 0
      maxZValue = 0.0;
    }

    // Perform any desired operations with the maximum value
  }

  double calculateForce() {
    // Calculate the force using the formula F = m * a
    double force = mass * maxZValue;
    return force;
  }

  double calculateRotationAngle() {
    // Calculate the rotation angle using gyroscope data
    double angle = rotationZ;
    return angle;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text('Tennis Game',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500
        ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height:40),
            Container(
              padding: EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.purple[400],
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: Text(
                'Force : ${calculateForce().toStringAsFixed(2)} N',
                style: TextStyle(fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.purple[400],
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: Text(
                'Rotation Angle : ${calculateRotationAngle().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w500
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap:startApp,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff868541),
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                             'START',
                              style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                              ),
                             ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width:10),
                  Expanded(
                    child: InkWell(
                      onTap: stopApp,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffea6530),
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                             'STOP',
                              style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                              ),
                             ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: maxZValue!=0?startApp:null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff4bd33),
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                             'CONTINUE',
                              style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                              ),
                             ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
                      onTap: (){
                        setState(() {
                           accelerationX = 0.0;
                           accelerationY = 0.0;
                           accelerationZ = 0.0;
                           rotationX = 0.0;
                           rotationY = 0.0;
                           rotationZ = 0.0; 
                           zValues = [];
                           maxZValue = 0.0;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        child: Text(
                        'RESET',
                         style: TextStyle(fontSize: 20,
                         color: Colors.white,
                         fontWeight: FontWeight.w500
                         ),
                        ),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
