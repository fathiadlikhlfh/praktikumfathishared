import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ResultScreen.dart';

void main() => runApp(MaterialApp(home: CalculatorScreen()));

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController _firstNumberController = TextEditingController();
  TextEditingController _secondNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Fathi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _firstNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Masukkan Angka Pertama'),
            ),
            TextField(
              controller: _secondNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Masukkan Angka Kedua'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => _calculate('+'), child: Text('(+)')),
                ElevatedButton(
                    onPressed: () => _calculate('-'), child: Text('(-)')),
                ElevatedButton(
                    onPressed: () => _calculate('*'), child: Text('(x)')),
                ElevatedButton(
                    onPressed: () => _calculate('/'), child: Text('(/)')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _calculate(String operator) async {
    double firstNumber = double.tryParse(_firstNumberController.text) ?? 0.0;
    double secondNumber = double.tryParse(_secondNumberController.text) ?? 0.0;
    double result = 0.0;

    switch (operator) {
      case '+':
        result = firstNumber + secondNumber;
        break;
      case '-':
        result = firstNumber - secondNumber;
        break;
      case '*':
        result = firstNumber * secondNumber;
        break;
      case '/':
        result = firstNumber / secondNumber;
        break;
    }

    // Simpan hasil ke shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('result', result);

    // Tampilkan pesan SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hasil kalkulasi disimpan. Klik Tampilkan untuk melihat hasil.'),
        action: SnackBarAction(
          label: 'Tampilkan',
          onPressed: () {
            // Pindah ke halaman berikutnya
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
