import 'dart:async';

import 'package:flappy_bird/Bird.dart';
import 'package:flappy_bird/barrier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialheight = birdYaxis;
  bool gamehasstarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5 ;

  void jump() {
    setState(() {
      time = 0;
      initialheight = birdYaxis;
    });
  }

  void startGame() {
    gamehasstarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialheight - height;
      });

      if(barrierXone< -1.1){
        barrierXone += 2.2;
      }else(
      barrierXone -=0.05 );




      if (birdYaxis > 1) {
        timer.cancel();
        gamehasstarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (gamehasstarted) {
                        jump();
                      } else {
                        startGame();
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gamehasstarted
                        ? Text("")
                        : Text(
                            "TAP TO PLAY",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone,1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone,-1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo,1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo,-1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 250.0,
                    ),
                  ),
                ],
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "0",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Best",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "10",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
