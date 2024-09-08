//NEED FIX IF MOUSE GOES OFF THE SCREEN EDGE SQUARE IS ADDED RAIL
//MAKE SURE CORNER ISN'T DRAW IF FIRST MOUSE POS IS CENTER - Unless corner is wanted

//FOR NOW RAILS EQUAL:
//0 is straight up (green)
//1 is straight across (red)
//2 is bottom left corner
//3 is bottom right corner
//4 is top left corner
//5 is top right corner
//6 is for empty tiles

float entryX;
float entryY;
float exitX;
float exitY;
String prevSquare;
String currSquare;

//[col][row] (col=x,row=y)
int[][] topGrid = new int[8][8];
int[][] bottomGrid = new int[8][8];

void setup(){
  size(800,800);
  for(int i = 0; i<topGrid.length; i++){
    for(int j = 0; j<topGrid[0].length; j++){
      topGrid[i][j] = 6;
      bottomGrid[i][j] = 6;
    }
  }
}

void draw(){
  background(255);
  // draw grid
  for(int i = 1; i<8; i++){
    line(i*100,0,i*100,800);
    line(0,i*100,800,i*100);
  }

  //DRAW BOTTOM RAILS
  for(int i = 0; i<bottomGrid.length; i++){
    for(int j = 0; j<bottomGrid[0].length; j++){
      if(bottomGrid[i][j]==0){ // straight up
        fill(0,255,0);
        rect((i*100)+20,j*100,60,100);
      }else if(bottomGrid[i][j]==1){ // straight across
        fill(255,0,0);
        rect(i*100,(j*100)+20,100,60);
      }else if(bottomGrid[i][j]==2){ // bottom left
        fill(0,0,255);
        rect(i*100,(j*100)+50,50,50);
      }else if(bottomGrid[i][j]==3){ //bottom right
        fill(0,0,255);
        rect((i*100)+50,(j*100)+50,50,50);
      }else if(bottomGrid[i][j]==4){ //top left
        fill(0,0,255);
        rect(i*100,j*100,50,50);
      }else if(bottomGrid[i][j]==5){ //top right
        fill(0,0,255);
        rect((i*100)+50,j*100,50,50);
      }
    }
  }
  
  //DRAW TOP RAILS
  fill(255,0,0);
  for(int i = 0; i<topGrid.length; i++){
    for(int j = 0; j<topGrid[0].length; j++){
      if(topGrid[i][j]==0){ // straight up
        fill(0,255,0);
        rect((i*100)+20,j*100,60,100);
      }else if(topGrid[i][j]==1){ // straight across
        fill(255,0,0);
        rect(i*100,(j*100)+20,100,60);
      }else if(topGrid[i][j]==2){ // bottom left
        fill(0,0,255);
        rect(i*100,(j*100)+50,50,50);
      }else if(topGrid[i][j]==3){ //bottom right
        fill(0,0,255);
        rect((i*100)+50,(j*100)+50,50,50);
      }else if(topGrid[i][j]==4){ //top left
        fill(0,0,255);
        rect(i*100,j*100,50,50);
      }else if(topGrid[i][j]==5){ //top right
        fill(0,0,255);
        rect((i*100)+50,j*100,50,50);
      }
    }
  }
}

void mousePressed(){
   prevSquare = pointToSquare();
   entryX = mouseX;
   entryY = mouseY;
}

void mouseDragged(){
 currSquare = pointToSquare();
 
 //SET ENTRY & EXIT COORDS
 if(!currSquare.equals("") && !prevSquare.equals("") && !currSquare.equals(prevSquare)){
   exitX = mouseX;
   exitY = mouseY;
   //NEED METHOD TO FIGURE OUT RAIL TYPE
   addRail(railType());
   entryX = exitX;
   entryY = exitY;
   prevSquare = currSquare;
 }
}

void addRail(int rail){
  String[] indexes = splitTokens(prevSquare);
  int col = int(indexes[0]);
  int row = int(indexes[1]);
  
  if(topGrid[col][row] == 6){
    topGrid[col][row] = rail;
  } else if(bottomGrid[col][row] == 6 && topGrid[col][row] != rail){
    bottomGrid[col][row] = topGrid[col][row]; 
    topGrid[col][row] = rail;
  }
}

String pointToSquare(){
 //GET COORDINATES
 int coordx = round(mouseX);
 int coordy = round(mouseY);
 
 //STOP ERROR IF MOUSE OFF SCREEN - ALLOWS RAILS TO BE DRAWN
 if(coordx >= 800){
   coordx = 700;
 }
 if(coordx < 0){
   coordx = 0;
 }
 if(coordy >= 800){
   coordy = 700;
 }
 if(coordy < 0){
   coordy = 0;
 }
 
 //MAKE COORDS DIVISIBLE BY 100
 while(coordx % 100 != 0){
   coordx--;
 }
 while(coordy % 100 != 0){
   coordy--;
 }
 
 //DIVIVE COORDS BY 100 (for position in array)
 coordx = coordx/100;
 coordy = coordy/100;
 
 //CONVERT COORDS TO STRING --> CURRENT SQUARE
 String x = str(coordx);
 String y = str(coordy);
 String square = x+" "+y;
 return square;
}

int railType(){
  String[] indexes = splitTokens(prevSquare);
  int col = int(indexes[0]);
  int row = int(indexes[1]);
  
  //LINE 1 - Should work
  float x0 = col*100;
  float y0 = (row*100)+99;
  float x1 = (col*100)+99;
  float y1 = row*100;
  
  float a = y0 - y1;
  float b = x1 - x0;
  float c = x0*y1 - x1*y0;
  float entryK = a*(entryX +1)+b*(entryY+0.5)+c;
  float exitK = a*(exitX +1)+b*(exitY+0.5)+c;
  
  if(entryK < 0 && exitK < 0){
    return 4;
  }
  if(entryK > 0 && exitK > 0){
    return 3;
  }
  
  //LINE 2 - not sure if it will work
  x0 = col*100;
  y0 = row*100;
  x1 = (col*100)+99;
  y1 = (row*100)+99;
  
  a = y0 - y1;
  b = x1 - x0;
  c = x0*y1 - x1*y0;
  entryK = a*(entryX +1)+b*(entryY+0.5)+c;
  exitK = a*(exitX +1)+b*(exitY+0.5)+c;
  
  if(entryK < 0 && exitK < 0){
    return 5;
  }
  if(entryK > 0 && exitK > 0){
    return 2;
  }
  
  if(abs(exitX-entryX) > abs(exitY-entryY)){
    return 1;
  }
  if(abs(exitX-entryX) < abs(exitY-entryY)){
    return 0;
  }
  
  return 6;
}
