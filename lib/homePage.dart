import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _output = '0';
  String _currentValue = '';
  String _operation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // set background color to light grey
      appBar: AppBar(
        title: const Text(
          'Calculator App',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.bottomRight,
            child: Text(
              _output,
              style: const TextStyle(fontSize: 48),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('C'),
              _buildButton('+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('Bench'),
              _buildButton('='),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label) {
    return MaterialButton(
      height: 80,
      minWidth: 80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: label == 'Bench'
          ? _handleBenchPress
          : () {
              _handleInput(label);
            },
      color: Colors.white, // set button color to white
      textColor: Colors.black,
      child: Text(
        label,
        style: const TextStyle(fontSize: 24),
      ), // set text color to black
    );
  }

  void _handleBenchPress() async {
    int r = 500000; // Number of iterations

    Stopwatch stopwatch = Stopwatch()..start(); // start the stopwatch
    num result = 0;
    for (int i = 0; i < r; i++) {
      result = pow(
          ((12345678 * 23456789 * 34567891 * 45678912 * 56789123) / 98765432),
          r);
    }
    stopwatch.stop(); // stop the stopwatch

    setState(() {
      // update the _output variable with the result of the calculation
      _output = result.toString();
    });

    // Show a toast message with the time taken for the operation
    Fluttertoast.showToast(
      msg: "Time taken for the operation: ${stopwatch.elapsedMilliseconds} ms",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void _handleInput(String label) {
    setState(() {
      if (label == 'C') {
        _output = '0';
        _currentValue = '';
        _operation = '';
      } else if (label == '+' || label == '-' || label == '*' || label == '/') {
        _operation = label;
        if (_currentValue != '') {
          _output = _currentValue;
          _currentValue = '';
        }
      } else if (label == '.') {
        if (!_currentValue.contains('.')) {
          _currentValue += label;
          _output = _currentValue;
        }
      } else if (label == '=') {
        if (_operation != '' && _currentValue != '') {
          double num1 = double.parse(_output);
          double num2 = double.parse(_currentValue);
          if (_operation == '+') {
            _output = (num1 + num2).toStringAsFixed(2);
          } else if (_operation == '-') {
            _output = (num1 - num2).toStringAsFixed(2);
          } else if (_operation == '*') {
            _output = (num1 * num2).toStringAsFixed(2);
          } else if (_operation == '/') {
            _output = (num1 / num2).toStringAsFixed(2);
          }
          _currentValue = '';
          _operation = '';
        } else {
          _operation = '';
        }
      } else {
        _currentValue += label;
        _output = _currentValue;
      }
    });
  }
}
