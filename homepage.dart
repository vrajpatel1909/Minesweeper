import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/bomb.dart';
import 'package:minesweeper/numberbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //variables
  int numberOfSquares = 6 * 6;
  int numberInEachRow = 6;

   // number of bombs around , revealed or not
var squareStatus = [];

  //bomb locations

  final List<int> bombLocations = [
    4,7,9,25,33
  ] ;
 bool bombsRevealed = false;
@override
void initState(){
  super.initState();

  for (int i=0; i<numberOfSquares; i++){
    squareStatus.add([0,false]);
  }
  scanBombs();
}

void revealBoxNumbers(int index) {
  // reveal current box if it is num
  if (squareStatus[index][0] != 0) {
    setState(() {
      squareStatus[index][1] = true;
    });
  }
  // if current box is 0
  else if (squareStatus[index][0] == 0){
    // reveal current box, and 8 surrounding box unless you are not on a wall
    setState(() {
      // reveal current box
      squareStatus[index][1] = true;
      // reveal left box , not in first col
      if( index % numberInEachRow != 0){
        //if not revealed and 0
        if(squareStatus[index-1][0] == 0 && squareStatus[index-1][1] == false){
          revealBoxNumbers(index-1);
        }
        // reveal left box
        squareStatus[index-1][1] = true;

      }

      // reveal left top box , not in first col, first row
      if( index % numberInEachRow != 0 && index >= numberInEachRow){
        //if not revealed and 0
        if(squareStatus[index-1-numberInEachRow][0] == 0 &&
            squareStatus[index-1-numberInEachRow][1] == false){
          revealBoxNumbers(index-1-numberInEachRow);
        }
        // reveal left topbox
        squareStatus[index-1-numberInEachRow][1] = true;

      }

      // reveal top box , not in first row
      if(index >= numberInEachRow){
        //if not revealed and 0
        if(squareStatus[index-numberInEachRow][0] == 0 &&
            squareStatus[index-numberInEachRow][1] == false){
          revealBoxNumbers(index-numberInEachRow);
        }
        // reveal top box
        squareStatus[index-numberInEachRow][1] = true;

      }

      // reveal right top box , not in last col, first row
      if( index % numberInEachRow != numberInEachRow-1 && index >= numberInEachRow){
        //if not revealed and 0
        if(squareStatus[index+1-numberInEachRow][0] == 0 &&
            squareStatus[index+1-numberInEachRow][1] == false){
          revealBoxNumbers(index+1-numberInEachRow);
        }
        // reveal right top box
        squareStatus[index+1-numberInEachRow][1] = true;

      }

      // reveal right box , not in last col
      if( index % numberInEachRow != numberInEachRow-1){
        //if not revealed and 0
        if(squareStatus[index+1][0] == 0 &&
            squareStatus[index+1][1] == false){
          revealBoxNumbers(index+1);
        }
        // reveal right box
        squareStatus[index+1][1] = true;

      }
      // reveal bottom right, not in last row, last column
      if( index % numberInEachRow != numberInEachRow-1
      && index >= numberOfSquares-numberInEachRow){
        //if not revealed and 0
        if(squareStatus[index+1+numberInEachRow][0] == 0 &&
            squareStatus[index+1+numberInEachRow][1] == false){
          revealBoxNumbers(index+1+numberInEachRow);
        }
        // reveal bottom right box
        squareStatus[index+1+numberInEachRow][1] = true;

      }
      // reveal bottom box, not in last row
      if(index >= numberOfSquares-numberInEachRow){
        //if not revealed and 0
        if(squareStatus[index+numberInEachRow][0] == 0 &&
            squareStatus[index+numberInEachRow][1] == false){
          revealBoxNumbers(index+numberInEachRow);
        }
        // reveal bottom box
        squareStatus[index+numberInEachRow][1] = true;

      }
      // reveal left bottom, not in last row & first col
      if( index % numberInEachRow != 0
          && index >= numberOfSquares-numberInEachRow) {
        //if not revealed and 0
        if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
            squareStatus[index - 1 + numberInEachRow][1] == false) {
          revealBoxNumbers(index - 1 + numberInEachRow);
        }
        // reveal left bottom box
        squareStatus[index - 1 + numberInEachRow][1] = true;
      }

    });
  }
}
void restartGame(){
  setState(() {
    bombsRevealed = false;
    for (int i=0; i<numberOfSquares; i++){
      squareStatus[i][1] = false;
    }
  });
}
void scanBombs() {
  for (int i =0; i< numberOfSquares; i++){
    // no bombs around initially
    int numberOfBombsAround = 0;

    //check all 8 squares around

    // square to left, if not 1st col
    if (bombLocations.contains(i-1) && i % numberInEachRow !=0){
      numberOfBombsAround++;
    }

    // square to top left, if not in 1st row or column
    if(bombLocations.contains(i-1-numberInEachRow)
        && (i%numberInEachRow !=0)
        && (i>=numberInEachRow)){
        numberOfBombsAround++;
    }
    // square to top, if not in first row
    if(bombLocations.contains(i-numberInEachRow)
    && i>=numberInEachRow){
      numberOfBombsAround++;
    }

    // square to top right, if not in first row and last column
    if(bombLocations.contains(i+1-numberInEachRow)
    && i>=numberInEachRow
    && i%numberInEachRow != numberInEachRow-1){
      numberOfBombsAround++;
    }

    // square to right, if not in last column
    if(bombLocations.contains(i+1)
    && (i%numberInEachRow != numberInEachRow-1)){
      numberOfBombsAround++;
    }

    // square to bottom right , if not last column and last row
    if(bombLocations.contains(i+1+numberInEachRow)
    && (i%numberInEachRow != numberInEachRow-1)
      && (i < numberOfSquares-numberInEachRow)){
      numberOfBombsAround++;
    }
    // square below, not in last row
    if(bombLocations.contains(i+numberInEachRow)
    && (i < numberOfSquares-numberInEachRow)
    ){
      numberOfBombsAround++;
    }
    // square to bottom right, not in last row and first column
    if(bombLocations.contains(i-1+numberInEachRow)
    && i < numberOfSquares-numberInEachRow
      && (i%numberInEachRow != 0)){
      numberOfBombsAround++;
  }
  // add total no of bombs around to square status
    setState(() {
      squareStatus[i][0] = numberOfBombsAround;
    });


  }

}

void playerLost() {
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Center(child: Text('Game Over')),
          actions: [
            MaterialButton(
                color: Colors.red,
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
              child: Icon(Icons.refresh),
          )],

        );
      });
}

void playerWon(){
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.grey[700],
          title: Center(child: Text('You Won')),
          actions: [
            MaterialButton(
              color: Colors.green,
              onPressed: () {
                restartGame();
                Navigator.pop(context);
              },
              child: Icon(Icons.refresh),
            )],

        );
      });
}
void checkWinner(){
  // check how many buttons revealed
  int unrevealedBox = 0;
    for(int i=0; i<numberOfSquares; i++){
      if( squareStatus[i][1] == false){
        unrevealedBox++;
      }
    }
    //if no equals player won
  if (unrevealedBox == bombLocations.length){
    playerWon();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          //Game stats and menu
          Container(
            height: 70,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //display no. of bombs
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(bombLocations.length.toString(), style: TextStyle(fontSize: 40)),
                    Text('B O M B S'),
                  ],

                ),
                //reset button
                GestureDetector(
                  onTap: restartGame,
                  child: Card(
                    child: Icon(Icons.refresh, color: Colors.white, size: 40),
                    color: Colors.grey[600],
                  ),
                ),
                //timer
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('0', style: TextStyle(fontSize: 40)),
                    Text('T I M E')

                  ],
                ),
              ],
            ),
          ),
          //Grid
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInEachRow),
                itemBuilder: (context,index){
                  if (bombLocations.contains(index)){
                    return MyBomb(

                      revealed: bombsRevealed,
                      function: (){
                        // tapped bomb then loses
                        setState(() {
                          bombsRevealed = true;
                          playerLost();
                        });

                      },
                    );

                  }else{
                    return MyNumberBox(
                      child: squareStatus[index][0],
                      revealed: squareStatus[index][1],
                      function: (){
                        // reveal current box
                        revealBoxNumbers(index);
                        checkWinner();
                      },
                    );
                  }
                }),
          ),

          //branding
          Padding(
              padding: const EdgeInsets.only(bottom: 2.0)),
              Text('CREATED BY VRAJ')
        ],
      ),

    );
  }
}
