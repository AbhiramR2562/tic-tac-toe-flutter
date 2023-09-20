import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; //the first player is o

  List<String> displayxo = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  // Text style
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 20);

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));

  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "player O",
                        style: myNewFontWhite,
                      ),
                      Text(
                        oScore.toString(),
                        style: myNewFontWhite,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "player X",
                        style: myNewFontWhite,
                      ),
                      Text(
                        xScore.toString(),
                        style: myNewFontWhite,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 147, 147, 147))),
                      child: Center(
                        child: Text(
                          displayxo[index],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'TIC TAC TOE',
                    style: myNewFontWhite,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'CREATOR +_+',
                    style: myNewFontWhite,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayxo[index] == '') {
        displayxo[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayxo[index] == '') {
        displayxo[index] = 'X';
        filledBoxes += 1;
      }

      ohTurn = !ohTurn;
      // check the winner every time
      _checkwinner();
    });
  }

  void _checkwinner() {
    //1st row
    if (displayxo[0] == displayxo[1] &&
        displayxo[0] == displayxo[2] &&
        displayxo[0] != '') {
      _showinDialog(displayxo[0]);
    }

    // check 2nd row
    if (displayxo[3] == displayxo[4] &&
        displayxo[3] == displayxo[5] &&
        displayxo[3] != '') {
      _showinDialog(displayxo[3]);
    }

    // check 3rd row
    if (displayxo[6] == displayxo[7] &&
        displayxo[6] == displayxo[8] &&
        displayxo[6] != '') {
      _showinDialog(displayxo[6]);
    }

    // check 1st column
    if (displayxo[0] == displayxo[3] &&
        displayxo[0] == displayxo[6] &&
        displayxo[0] != '') {
      _showinDialog(displayxo[0]);
    }

    //check 2nd column
    if (displayxo[1] == displayxo[4] &&
        displayxo[1] == displayxo[7] &&
        displayxo[1] != '') {
      _showinDialog(displayxo[1]);
    }

    // check 3rd column
    if (displayxo[2] == displayxo[5] &&
        displayxo[2] == displayxo[8] &&
        displayxo[2] != '') {
      _showinDialog(displayxo[2]);
    }

    // checking 1st diagonal
    if (displayxo[0] == displayxo[4] &&
        displayxo[0] == displayxo[8] &&
        displayxo[0] != '') {
      _showinDialog(displayxo[0]);
    }

    // checking 2nd diagonal
    if (displayxo[6] == displayxo[4] &&
        displayxo[6] == displayxo[2] &&
        displayxo[6] != '') {
      _showinDialog(displayxo[6]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              FilledButton(
                child: Text("Play again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text("Winner is : player " + winner),
            actions: [
              FilledButton(
                  child: Text("Play again"),
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  })
            ],
          );
        });

    if (winner == 'O') {
      oScore += 1;
    } else if (winner == 'X') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayxo[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
