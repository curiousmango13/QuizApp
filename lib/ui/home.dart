import 'package:flutter/material.dart';
import 'package:quizz_app/model/question.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {

  int _currentQuestionIndex = 0;
  List questionBank =[
    Question.name("The U.S Declaration of Independence was adopted in 1776.", true),
    Question.name ("The Mayflower was  the name of the Pilgrims’ ship", true),
    Question.name("American flag has 15 stripes", false),
    Question.name("Neil Armstrong was the first president of the United States ", false),
    Question.name("Thomas Edison invented the light bulb", true)
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citizen"),
        centerTitle: true,
          backgroundColor: Colors.blueGrey,
      ),
     backgroundColor: Colors.blueGrey,
      body:Builder(
        builder:(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset('images/flag.png',
              width:250,
              height: 180,),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration:BoxDecoration(
                  color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14.4),
                  border: Border.all(
                    color:Colors.blueGrey.shade400,
                    style:BorderStyle.solid
                  )
                ),
                height:120 ,
                child: Center(child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(questionBank[_currentQuestionIndex].questionText, style: TextStyle(
                    fontSize: 16.9,
                    color: Colors.white
                  )),
                ))),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                RaisedButton(onPressed: ()=> _prevQuestion(),
                  color: Colors.blueGrey.shade900,
                  child: Icon(Icons.arrow_back, color:Colors.white),
                ),

                RaisedButton(onPressed: ()=> _checkAnswer(true, context),
                    color: Colors.blueGrey.shade900,
                  child: Text("True", style:TextStyle(color:Colors.white)),
                ),

                RaisedButton(onPressed: ()=> _checkAnswer(false, context),
                  color: Colors.blueGrey.shade900,
                  child: Text("False", style:TextStyle(color:Colors.white),)

                ),
                RaisedButton(onPressed: ()=> _nextQuestion(),
                  color: Colors.blueGrey.shade900,
                  child: Icon(Icons.arrow_forward, color:Colors.white),
                )

              ],
            ),
            Spacer(),
          ],
        )
      )
    ));
  }

  _updateQuestion(){
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex +1) % questionBank.length;
    });
  }
  _nextQuestion() {
     _updateQuestion();

  }


  _checkAnswer( bool userChoice, BuildContext context) {

    if (userChoice == questionBank[_currentQuestionIndex].isCorrect)
      {
        final snackbar =  SnackBar(

            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 500),
            content:Text("You are correct!"));
        //correct answer
        debugPrint("Yes Correct!");
        Scaffold.of(context).showSnackBar(snackbar);
        setState(() {
          _updateQuestion();
        });

      }else {
      debugPrint("Incorrect!");
      final snackbar =  SnackBar(
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 500),
          content:Text("You are wrong!"));
      Scaffold.of(context).showSnackBar(snackbar);
      _updateQuestion();
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  _prevQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex - 1) % questionBank.length;
      debugPrint("Index: $_currentQuestionIndex");
    });
  }
}


