double entryX = 0;
double entryY = 0;
double exitX;
double exitY;
String prevSquare = "0 0";

//[col][row] (col=x,row=y)
int[][] topGrid = new int[8][8];
//int[][] bottomGrid = new int[8][8];

void setup(){
  size(800,800);
}

void draw(){
  background(255);
  fill(255,0,0);
  // draw grid
  for(int i = 1; i<8; i++){
    line(i*100,0,i*100,800);
    line(0,i*100,800,i*100);
  }
  for(int i = 0; i<topGrid.length; i++){
    for(int j = 0; j<topGrid[0].length; j++){
      if(topGrid[i][j]==1){
        rect(i*100,(j*100)+20,100,60);
      }
      //DEBUG print(topGrid[i][j]);
    }
  }
}

void mouseDragged(){
 //str() - turn int, or float to string 
 //round() - round double to int
 //minus from x until divisible by 100 with no remainder
 
 //GET COORDINATES
 int coordx = round(mouseX);
 int coordy = round(mouseY);
 
 //MAKE COORDS DIVISIBLE BY 100
 while(coordx % 100 == 0){
   coordx--;
 }
 while(coordy % 100 == 0){
   coordy--;
 }
 
 //DIVIVE COORDS BY 100 (for position in array)
 coordx = coordx/100;
 coordy = coordy/100;
 
 //CONVERT COORDS TO STRING --> CURRENT SQUARE
 String x = str(coordx);
 String y = str(coordy);
 String currSquare = x+" "+y;
 //DEBUG
 println("CURRENT " + currSquare);
 println("PREV " + prevSquare);
 
 //SET ENTRY & EXIT COORDS
 if(currSquare.equals(prevSquare)){
   //DEBUG
   println("Same");
   if(entryX == 0 && entryY == 0){
     entryX = mouseX;
     entryY = mouseY;
   }else{
     exitX = mouseX;
     exitY = mouseY;
     
     //PUT RAIL IN PREV SQUARE
     //WILL MAKE SEPERATE FUNCTION LATER
     String[] indexes = splitTokens(prevSquare);
     topGrid[int(indexes[0])][int(indexes[1])] = 1;
     
     entryX = 0;
     entryY = 0;
   }
  }
  prevSquare = currSquare;
}
