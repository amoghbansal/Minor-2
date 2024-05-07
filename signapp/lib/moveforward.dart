import 'dart:async';

import 'package:flutter/material.dart';

class MoveForward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move Forward'),
      ),
      body: AlphabetFruitMatch(),
    );
  }
}

class AlphabetFruitMatch extends StatefulWidget {
  @override
  _AlphabetFruitMatchState createState() => _AlphabetFruitMatchState();
}

class _AlphabetFruitMatchState extends State<AlphabetFruitMatch>
    with SingleTickerProviderStateMixin {
  List<String> alphabetList = ['O', 'K', 'C', 'D', 'E'];
  Map<String, String> matches = {
    'O': 'Orange',
    'K': 'Kite',
    'C': 'Cherry',
    'D': 'Dog',
    'E': 'Egg',
  };
  Map<String, String> images = {
    'O': 'orange.png',
    'K': 'kite.png',
    'C': 'cherry.png',
    'D': 'dog.png',
    'E': 'egg.png',
  };
  int score = 0;
  bool showRibbon = false;
  bool showNextStepButton = false; // Flag to control the visibility of the button
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _ribbonTimer;
  late Timer _buttonTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _ribbonTimer.cancel(); // Cancel the ribbon timer when disposing the widget
    _buttonTimer.cancel(); // Cancel the button timer when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: alphabetList
                            .map((alphabet) => Draggable<String>(
                                  data: alphabet,
                                  child: Image.asset(
                                    'images/$alphabet.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                  feedback: Image.asset(
                                    'images/$alphabet.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  childWhenDragging: Container(),
                                ))
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: DragTarget<String>(
                          builder: (context, accepted, rejected) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: matches.entries.map((entry) {
                                return DragTarget<String>(
                                  builder: (context, accepted, rejected) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                      child: accepted == entry.key
                                          ? Image.asset(
                                              'images/${images[entry.key]}',
                                              width: 100,
                                              height: 100,
                                            )
                                          : Draggable<String>(
                                              data: entry.key,
                                              child: Image.asset(
                                                'images/${images[entry.key]}',
                                                width: 100,
                                                height: 100,
                                              ),
                                              feedback: Image.asset(
                                                'images/${images[entry.key]}',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              childWhenDragging: Container(),
                                            ),
                                    );
                                  },
                                  onWillAccept: (data) => true,
                                  onAccept: (data) {
                                    if (matches[data] == entry.value) {
                                      setState(() {
                                        score++;
                                        alphabetList.remove(data);
                                        matches.remove(entry.key);
                                        if (alphabetList.isEmpty) {
                                          _completeGame();
                                        }
                                      });
                                    }
                                  },
                                );
                              }).toList(),
                            );
                          },
                          onWillAccept: (data) => true,
                          onAccept: (data) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showRibbon) RibbonWidget(),
        if (showNextStepButton)
          Positioned(
            bottom: 20,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(108.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Action to perform when button is pressed
                    print('Move to next step!');
                  },
                  child: Text('Move to next step'),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _completeGame() {
    setState(() {
      showRibbon = true;
      showNextStepButton = true; // Set the flag to true when game is completed
    });
    _controller.forward();
    _ribbonTimer = Timer(Duration(seconds: 10), () {
      // Start a timer to hide the ribbon after 10 seconds
      setState(() {
        showRibbon = false;
      });
    });
    _buttonTimer = Timer(Duration(seconds: 20), () {
      // Start a timer to hide the button after 20 seconds
      setState(() {
        showNextStepButton = false;
      });
    });
  }
}

class RibbonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'images/ribbon.gif',
        fit: BoxFit.cover,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MoveForward(),
  ));
}
