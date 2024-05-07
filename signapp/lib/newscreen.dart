import 'package:flutter/material.dart';
import 'package:signapp/Quizscreen'; // Corrected import statement

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen()), // Define your quiz screen widget here
            );
          },
          child: Container(
            height: 200,
            width: 200,
            child: Card(
              elevation: 4,
              shape: CircleBorder(eccentricity: 0),
              color: Color.fromARGB(255, 159, 255, 183),
              child: Center(
                child: Text(
                  'Learning alphabets',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
