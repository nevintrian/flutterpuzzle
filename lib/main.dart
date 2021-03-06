import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Puzzle',
        debugShowCheckedModeBanner: false,
        home: _Page());
  }
}

class _Page extends StatefulWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  bool isImage = false;
  bool is16 = false;
  bool isbool4 = false;

  List<List<int>> numberPuzzleFinish9 = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0]
  ];
  List<List<int>> numberPuzzleFinish16 = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 0]
  ];
  List<List<int>> numberPuzzle = [
    [1, 0, 3],
    [4, 2, 6],
    [7, 5, 8]
  ];

  List<List<int>> numberPuzzle9 = [
    [1, 0, 8],
    [5, 2, 7],
    [4, 6, 3]
  ];

  List<List<int>> numberPuzzle16 = [
    [1, 11, 10, 9],
    [7, 2, 0, 14],
    [9, 13, 3, 12],
    [8, 6, 5, 4]
  ];

  int totalPuzzle = 3;
  int xZeroPosition = 0;
  int yZeroPosition = 0;
  int totalClick9 = 0;
  int totalClick16 = 0;
  @override
  void initState() {
    cekZeroPuzzle();
    super.initState();
  }

  void clickBalok(int x, int y) {}
  void cekZeroPuzzle() {
    for (int i = 0; i < numberPuzzle.length; i++) {
      for (int j = 0; j < numberPuzzle[i].length; j++) {
        if (numberPuzzle[i][j] == 0) {
          setState(() {
            yZeroPosition = i;
            xZeroPosition = j;
          });
        }
      }
    }
  }

  void refresh() {
    setState(() {
      isbool4 == false ? totalClick9 = 0 : totalClick16 = 0;
      isbool4 == false
          ? numberPuzzle = [
              [1, 0, 8],
              [5, 2, 7],
              [4, 6, 3]
            ]
          : numberPuzzle = [
              [1, 11, 10, 9],
              [7, 2, 0, 14],
              [9, 13, 3, 12],
              [8, 6, 5, 4]
            ];
    });
  }

  showAlertDialog(BuildContext context, bool success) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        if (success) {
          refresh();
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alertSucess = AlertDialog(
      title: const Text("Congratulation"),
      content: isbool4 == false
          ? Text("You clear this puzzle with $totalClick9, try it again?")
          : Text("You clear this puzzle with $totalClick16, try it again?"),
      actions: [okButton, cancelButton],
    );

    AlertDialog alertFailed = AlertDialog(
      title: const Text("Failed"),
      content: const Text("Try it again to solve this puzzle"),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return success ? alertSucess : alertFailed;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    cekZeroPuzzle();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Flutter Puzzle'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isbool4 == false
                    ? Text(
                        "Click : $totalClick9",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Text(
                        "Click : $totalClick16",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                Row(
                  children: [
                    const Text(
                      'Image Mode :',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Switch(
                        value: isImage,
                        onChanged: (value) {
                          setState(() {
                            isImage = value;
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          refresh();
                        },
                        child: const Text('Start')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          for (int i = 0; i < numberPuzzle.length; i++) {
                            for (int j = 0; j < numberPuzzle[i].length; j++) {
                              if (isbool4 == false) {
                                if (numberPuzzle[i][j] !=
                                    numberPuzzleFinish9[i][j]) {
                                  return showAlertDialog(context, false);
                                }
                              } else {
                                if (numberPuzzle[i][j] !=
                                    numberPuzzleFinish16[i][j]) {
                                  return showAlertDialog(context, false);
                                }
                              }
                            }
                          }
                          return showAlertDialog(context, true);
                        },
                        child: const Text('Finish')),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isbool4 = false;
                            totalPuzzle = 3;
                            numberPuzzle = numberPuzzle9;
                          });
                        },
                        child: const Text('3 x 3')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isbool4 = true;
                            totalPuzzle = 4;
                            numberPuzzle = numberPuzzle16;
                          });
                        },
                        child: const Text('4 x 4')),
                  ],
                ),
              ],
            ),
            Container(
                width: totalPuzzle * 100,
                height: totalPuzzle * 100,
                color: Colors.blueGrey,
                child: Column(
                  children: [
                    for (int i = 0; i < totalPuzzle; i++)
                      Row(
                        children: [
                          for (int j = 0; j < totalPuzzle; j++)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (yZeroPosition == i + 1 &&
                                          xZeroPosition == j ||
                                      yZeroPosition == i &&
                                          xZeroPosition == j + 1 ||
                                      yZeroPosition == i - 1 &&
                                          xZeroPosition == j ||
                                      yZeroPosition == i &&
                                          xZeroPosition == j - 1) {
                                    setState(() {
                                      numberPuzzle[yZeroPosition]
                                          [xZeroPosition] = numberPuzzle[i][j];
                                      numberPuzzle[i][j] = 0;
                                      setState(() {
                                        isbool4 == false
                                            ? totalClick9++
                                            : totalClick16++;
                                      });
                                    });
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: numberPuzzle[i][j] == 0
                                            ? Colors.blueGrey
                                            : Colors.white,
                                        border: Border.all(
                                          color: Colors.blueGrey,
                                        )),
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: !isImage
                                        ? Text(
                                            '${numberPuzzle[i][j]}',
                                            style: const TextStyle(
                                              color: Colors.blueGrey,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: numberPuzzle[i][j] != 0
                                                ? Image.asset(
                                                    'assets/images/$totalPuzzle'
                                                    '_'
                                                    '${numberPuzzle[i][j]}'
                                                    '.png',
                                                  )
                                                : const Text(""))),
                              ),
                            ),
                        ],
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
