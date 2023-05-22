import 'package:flutter/material.dart';
import 'package:mobile_computing_project/home.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

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
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

      InkWell(
        onTap: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (BuildContext)=>TennisGamePage(),)
        );
          },
        child: Container(
        width: double.infinity,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
        color: Colors.purple[400],
         borderRadius: BorderRadius.all(Radius.circular(16))
           ),
                        child: Text(
                        'Go to play',
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