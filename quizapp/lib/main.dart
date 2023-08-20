import 'dart:ui';
import 'dart:math';
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
      home: const HomePage(title: 'Math Quiz App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
              // start quiz button
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
                    fontSize: 20,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.title});

  final String title;
  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  // data used for calculation
  int number1 = 0;
  int number2 = 0;
  int operation = 0;
  int answer = 0;
  int submittedAnswer = -9999;

  // to be displayed to the user
  String operationString = "";
  String questionString = "";
  String buttonStr1 = "";
  String buttonStr2 = "";

  // data used to keep track of quiz progress
  int score = 0;
  int numberOfQuestions = 10;
  int currentQuestion = 0;

  // initializes state when quiz first starts
  @override
  void initState() {
    super.initState();
    loadNewQuestion();
  }

  // load a new question
  void loadNewQuestion() {
    setQuestion();
    generateButtonText();
  }

  //method that sets the question string to be displayed to the users
  void setQuestion() {
    randomQuestion();
    setAnswer();
    questionString = number1.toString() + operationString + number2.toString();
  }

  // generates the button text randomly so that answer button placement is always random
  void generateButtonText() {
    final random = Random();
    int r = random.nextInt(2);
    int range = 26;

    //generate a larger fake answer if its multiply
    if (operation == 3) {
      range = 100;
    }
    if (r == 1) {
      buttonStr1 = answer.toString();
      do {
        buttonStr2 = random.nextInt(range).toString();
      } while (buttonStr2 == buttonStr1); // to ensure answers are not the same
    } else {
      buttonStr2 = answer.toString();
      do {
        buttonStr1 = random.nextInt(range).toString();
      } while (buttonStr1 == buttonStr2); // to ensure answers are not the same
    }
  }

  // randomizes the math question
  void randomQuestion() {
    final random = Random();
    number1 = random.nextInt(10) + 1;
    number2 = random.nextInt(10) + 1;
    operation = random.nextInt(3) + 1;
  }

  // sets the answer of the question to the variable
  void setAnswer() {
    switch (operation) {
      case 1:
        answer = number1 + number2;
        operationString = " + ";
        break;
      case 2:
        if (number1 < number2) {
          int temp = 0;
          temp = number1;
          number1 = number2;
          number2 = temp;
        }
        answer = number1 - number2;
        operationString = " - ";
        break;
      case 3:
        answer = number1 * number2;
        operationString = " x ";
        break;
    }
  }

  // handles logic when user taps on one of the answers
  void submitQuestion(int submittedAns) {
    bool correct = false;
    if (submittedAns == answer) {
      correct = true;
    }
    if (correct) {
      score++;
    }
    currentQuestion++;
    if (currentQuestion < numberOfQuestions) {
      // if user hasn't reached total number of questions, continue to load new questions
      setState(() {
        loadNewQuestion();
      });
    } else {
      // else, load results page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                title: "Results",
                score: score,
                totalQuestion: numberOfQuestions)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Question " + (currentQuestion + 1).toString()),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 20),
                  child: Text(
                    "Score : " + score.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: Text(
                  questionString,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 40),
                  child: TextButton(
                    onPressed: () {
                      submitQuestion(int.parse(buttonStr1));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orangeAccent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        buttonStr1,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 40),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orangeAccent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                    onPressed: () {
                      submitQuestion(int.parse(buttonStr2));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        buttonStr2,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  // passes the score and totalQuestions to the result page
  const ResultPage(
      {super.key,
      required this.title,
      required this.score,
      required this.totalQuestion});

  final String title;
  final int score;
  final int totalQuestion;
  @override
  ResultPageState createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  double scorePercentage = 0;

  // calculate the percentage of score when page is initialised
  @override
  void initState() {
    super.initState();
    scorePercentage = widget.score / widget.totalQuestion * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                "Final Score : " +
                    widget.score.toString() +
                    " / " +
                    widget.totalQuestion.toString(),
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Text(
                "Rate : " + scorePercentage.toStringAsFixed(0) + "%",
                style: TextStyle(fontSize: 25),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(20),
                child: const Text(
                  "Home",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
