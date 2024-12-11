import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "←",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  int first = 0;
  int second = 0;
  String operation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Display Area
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: Colors.white,
              child: Text(
                _textController.text,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            // Grid of Buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lstSymbols[index] == "="
                          ? Colors.blueGrey
                          : Colors.grey[300],
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      final symbol = lstSymbols[index];
                      setState(() {
                        if (symbol == "C") {
                          _textController.text = "";
                          first = 0;
                          second = 0;
                          operation = "";
                        } else if (symbol == "←") {
                          if (_textController.text.isNotEmpty) {
                            _textController.text = _textController.text
                                .substring(0, _textController.text.length - 1);
                          }
                        } else if (symbol == "+" ||
                            symbol == "-" ||
                            symbol == "*" ||
                            symbol == "/" ||
                            symbol == "%") {
                          first = int.tryParse(_textController.text) ?? 0;
                          operation = symbol;
                          _textController.text = "";
                        } else if (symbol == "=") {
                          second = int.tryParse(_textController.text) ?? 0;
                          int result;
                          switch (operation) {
                            case "+":
                              result = first + second;
                              break;
                            case "-":
                              result = first - second;
                              break;
                            case "*":
                              result = first * second;
                              break;
                            case "/":
                              result = second != 0
                                  ? first ~/ second
                                  : 0; // Avoid division by zero
                              break;
                            case "%":
                              result = first % second;
                              break;
                            default:
                              result = 0;
                          }
                          _textController.text = result.toString();
                        } else {
                          _textController.text += symbol;
                        }
                      });
                    },
                    child: Text(
                      lstSymbols[index],
                      style: TextStyle(
                        fontSize: 24,
                        color: lstSymbols[index] == "="
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
