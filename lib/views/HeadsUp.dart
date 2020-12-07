import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HeadsUpResult.dart';
import '../models/iCueCard.dart';
import '../models/deck.dart';
import 'dart:async';
//import 'package:flutter_sensors/flutter_sensors.dart';
import 'dart:math';
import '../models/root.dart';

class HeadsUp extends StatefulWidget {
  final Root root;
  final Deck deck;
  final String category;
  final String questionNum;
  //final int ori;
  HeadsUp({this.root, this.deck, this.category, this.questionNum});

  @override
  _HeadsUpState createState() => _HeadsUpState(
      root: this.root,
      deck: this.deck,
      category: this.category,
      questionNum: this.questionNum);
}

class _HeadsUpState extends State<HeadsUp> {
  final Root root;
  final Deck deck;
  final String category;
  final String questionNum;
  _HeadsUpState({this.root, this.deck, this.category, this.questionNum});

  //the variable to record the score
  int _score = 0;
  //all the cards stored in this list
  List<iCueCard> cards = new List<iCueCard>();

  //all the cards stored in this list
  List<iCueCard> tmp = new List<iCueCard>();

  //set a time counter for the game
  int _counter = 30;
  Timer _timer;

  //store the wrong guess cards
  List<iCueCard> mistakes = [];
  int index = 0;
  bool isOver = false; //the boolen value which states if the game is over
  int roundNum;

  /*
  //device titling
  bool _accelAvailable = false;
  bool _gyroAvailable = false;
  List<double> _accelData = List.filled(3, 0.0);
  List<double> _gyroData = List.filled(3, 0.0);
  StreamSubscription _accelSubscription;
  StreamSubscription _gyroSubscription;*/

  @override
  void initState() {
    //device titling
    // _checkAccelerometerStatus();
    //_checkGyroscopeStatus();

    super.initState();

    // horizontal view
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    tmp = deck.getCards();
    if (questionNum == "5") {
      roundNum = 5;
    }
    if (questionNum == "10") {
      roundNum = 10;
    }
    if (questionNum == "15") {
      roundNum = 15;
    }
    if (questionNum == "20") {
      roundNum = 20;
    }
    if (questionNum == "20") {
      roundNum = tmp.length;
    }
    if (roundNum >= tmp.length) {
      roundNum = tmp.length;
    }

    int tmplen = tmp.length; //record the current deck size
    //randomly add the question to
    Random random = new Random();
    int ran;
    if (roundNum != tmp.length) {
      for (int i = 0; i < roundNum; i++) {
        ran = random.nextInt(tmplen);
        cards.add(tmp[ran]);
        tmp.removeAt(ran);
        tmplen--;
      }
    } else {
      cards = tmp;
    }

    _startTimer();
    //_startAccelerometer(); //may not be used
  }

  //@override
  /*
  void dispose() {
    _stopAccelerometer();
    _stopGyroscope();
    super.dispose();
  }*/
  /*
  void _checkAccelerometerStatus() async {
    await SensorManager()
        .isSensorAvailable(Sensors.ACCELEROMETER)
        .then((result) {
      setState(() {
        _accelAvailable = result;
      });
    });
  }

  Future<void> _startAccelerometer() async {
    print("titling is invoked");
    if (_accelSubscription != null) return;
    if (_accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_FASTEST,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        setState(() {
          _accelData = sensorEvent.data;
          if(_accelData[2] < -3){
            print("is called correct");
            _correctAnswer();
          }
          if(_accelData[2] > 3){
            print("is called wrong");
            _wrongAnswer();
          }
        });
      });
    }
  }

  void _stopAccelerometer() {
    if (_accelSubscription == null) return;
    _accelSubscription.cancel();
    _accelSubscription = null;
  }

  void _checkGyroscopeStatus() async {
    await SensorManager().isSensorAvailable(Sensors.GYROSCOPE).then((result) {
      setState(() {
        _gyroAvailable = result;
      });
    });
  }

  Future<void> _startGyroscope() async {
    if (_gyroSubscription != null) return;
    if (_gyroAvailable) {
      final stream =
          await SensorManager().sensorUpdates(sensorId: Sensors.GYROSCOPE);
      _gyroSubscription = stream.listen((sensorEvent) {
        setState(() {
          _gyroData = sensorEvent.data;
          if(_accelData[2] < -10){
            print("is called");
            _correctAnswer();
          }
          if(_accelData[2] > 10){
            print("is called");
            _wrongAnswer();
          }
        });
      });
    }
  }

  void _stopGyroscope() {
    if (_gyroSubscription == null) return;
    _gyroSubscription.cancel();
    _gyroSubscription = null;
  }*/

  //this function is called when the player get the correct answer
  void _correctAnswer() {
    setState(() {
      _score++;
      //index++;
      int length = cards.length; //check point is at length-1
      _startTimer();
      print("length is $length");
      if (index == length - 1) {
        isOver = true;
        _timer.cancel();
        // _stopAccelerometer();
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  HeadsUpResult(root: root, score: _score, mislst: mistakes)),
        );
      }
      index++;
    });
  }

  //this function is called when the player get the wrong answer

  void _wrongAnswer() {
    setState(() {
      mistakes.add(cards[index]);
      //index++;
      int length = cards.length; //check point is at length-1
      _startTimer();
      if (index == length - 1) {
        //determine if the game is over
        isOver = true;
        _timer.cancel();
        // _stopAccelerometer();
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  HeadsUpResult(root: root, score: _score, mislst: mistakes)),
        );
      }
      index++;
    });
  }

  void _startTimer() {
    //_startAccelerometer();
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          if (index < cards.length) {
            _wrongAnswer();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (index >= cards.length) {
      //this if means checking when the index is out of range, reset into the range
      index = 0;
    }
    var _keyword;
    _keyword = cards[index].getFront();
    //_startTimer();
    return new Scaffold(
      appBar: new AppBar(
          automaticallyImplyLeading: false, title: new Text("Heads Up Game")),
      body: Center(
        child: Column(
          children: [
            Text(
              "$_keyword",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50.0,
                //color:Colors.yellow,
              ),
            ),
            Text(
              '00:' + '$_counter',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        //two botton for count correct/wrong Answer

        children: [
          FloatingActionButton.extended(
            label: Text('Correct!!!'),
            icon: Icon(Icons.done),
            backgroundColor: Colors.green,
            tooltip: 'correct answer',
            onPressed: () {
              _correctAnswer();
              //_startTimer();
            },
            heroTag: "first",
          ),
          FloatingActionButton.extended(
            label: Text('Get Wrong!!!'),
            icon: Icon(Icons.clear),
            backgroundColor: Colors.pink,
            tooltip: 'wrong answer',
            onPressed: () {
              _wrongAnswer();
              //_startTimer();
            },
            heroTag: "second",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    // TODO: implement build
    //please add the navigation on main page, do not need to edit the code above
    //throw UnimplementedError();
  }
  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Sensors Example'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          alignment: AlignmentDirectional.topCenter,
          
          child: Column(
            children: <Widget>[
              Text(
                "Accelerometer Test",
                textAlign: TextAlign.center,
              ),
              Text(
                "Accelerometer Enabled: $_accelAvailable",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[0](X) = ${_accelData[0]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[1](Y) = ${_accelData[1]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[2](Z) = ${_accelData[2]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: Text("Start"),
                    color: Colors.green,
                    onPressed: _accelAvailable != null
                        ? () => _startAccelerometer()
                        : null,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    child: Text("Stop"),
                    color: Colors.red,
                    onPressed: _accelAvailable != null
                        ? () => _stopAccelerometer()
                        : null,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "Gyroscope Test",
                textAlign: TextAlign.center,
              ),
              Text(
                "Gyroscope Enabled: $_gyroAvailable",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[0](X) = ${_gyroData[0]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[1](Y) = ${_gyroData[1]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[2](Z) = ${_gyroData[2]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: Text("Start"),
                    color: Colors.green,
                    onPressed:
                        _gyroAvailable != null ? () => _startGyroscope() : null,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    child: Text("Stop"),
                    color: Colors.red,
                    onPressed:
                        _gyroAvailable != null ? () => _stopGyroscope() : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
