import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // app root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Quiz App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.title});

  final String title;
  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Quiz In Progress"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "test",
            ),
            const Text(
              "hello 2",
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageState extends State<HomePage> {
  /*
  void startQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QuizPage(title: "Quiz In Progress")),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Text(
                "Welcome To Math Quiz App",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orangeAccent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(20.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuizPage(title: "Quiz In Progress")));
              },
              child: const Text("Start Quiz",
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
