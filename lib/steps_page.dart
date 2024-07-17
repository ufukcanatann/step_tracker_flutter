import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:lottie/lottie.dart';
import 'database_helper.dart';

class StepsPage extends StatefulWidget {
  @override
  _StepsPageState createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  late Stream<StepCount> _stepCountStream;
  String _steps = '0';
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  int _currentSteps = 0;
  int _stepGoal = 10000;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _loadInitialStepCount();
  }

  void onStepCount(StepCount event) async {
    setState(() {
      _steps = event.steps.toString();
      _currentSteps = event.steps;
    });
    await _databaseHelper.insertStep(event.steps);
  }

  void onStepCountError(error) {
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  Future<void> _loadInitialStepCount() async {
    int initialStepCount = await _databaseHelper.getLatestStepCount();
    setState(() {
      _steps = initialStepCount.toString();
      _currentSteps = initialStepCount;
    });
  }

  void _incrementSteps() async {
    setState(() {
      _currentSteps++;
      _steps = _currentSteps.toString();
    });
    await _databaseHelper.insertStep(_currentSteps);
  }

  @override
  Widget build(BuildContext context) {
    double progress = _currentSteps / _stepGoal;
    return Scaffold(
      appBar: AppBar(
        title: Text('Adımlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset('assets/walk_animation.json', height: 200),
            SizedBox(height: 20),
            CircularProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 10,
            ),
            SizedBox(height: 20),
            Text(
              'Attığınız Adım Sayısı:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_steps / $_stepGoal',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementSteps,
              child: Text('Adım At'),
            ),
          ],
        ),
      ),
    );
  }
}
