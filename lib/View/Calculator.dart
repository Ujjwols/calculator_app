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
  List<String> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ujjwols Calculator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // Display Area
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // History
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Text(
                        history[index],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                // Current Input
                Text(
                  _textController.text.isEmpty ? "0" : _textController.text,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Buttons Area
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemCount: lstSymbols.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final symbol = lstSymbols[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          symbol == "=" ? Colors.blueGrey : Colors.white,
                      foregroundColor:
                          symbol == "=" ? Colors.white : Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      setState(() {
                        if (symbol == "C") {
                          _textController.text = "";
                          first = 0;
                          second = 0;
                          operation = "";
                          history.clear();
                        } else if (symbol == "←") {
                          if (_textController.text.isNotEmpty) {
                            _textController.text = _textController.text
                                .substring(0, _textController.text.length - 1);
                          }
                        } else if (["+", "-", "*", "/", "%"].contains(symbol)) {
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
                              result = second != 0 ? first ~/ second : 0;
                              break;
                            case "%":
                              result = first % second;
                              break;
                            default:
                              result = 0;
                          }
                          final calculation =
                              "$first $operation $second = $result";
                          history.insert(0, calculation);
                          _textController.text = result.toString();
                        } else {
                          _textController.text += symbol;
                        }
                      });
                    },
                    child: Text(
                      symbol,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: symbol == "=" ? Colors.white : Colors.black87,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
