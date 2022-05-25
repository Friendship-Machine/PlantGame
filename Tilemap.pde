/*
Tmap class, stores/displays a grid of Tile objects. Can preform operations on Tiles using atk/def values.
Tmap(int grid width, int grid height, int unique ID count);

Methods:
  -void display() //displays all Tiles stored in the Tmap regardless of if it has been updated
  -void Tmap.update() //computes attack/defense actions. Updates and draws results
  -int idTotal() //returns a count of total count of unique ID's still active - returns(int)
  -int idCount(int) //returns a count of a total count of a specific ID still active - returns(int)
*/

class Tmap {
  int mapX, mapY; //dimensions of the grid
  Tile[][] tileMap; //2D array of the tiles in the grid
  
  Tmap(int x, int y, int idcount){
    mapX = x/2;
    mapY = y/2;
    
    tileMap = new Tile[mapX][mapY];
    for(int i=0; i<mapX;i++){
      for(int j=0; j<mapY;j++){
        tileMap[i][j]= new Tile(i*2, j*2, 0, color(0) );
        tileMap[i][j].display();
      }
    }
    
    for(int i=0; i<idcount; i++){
      int rX = (int)random(0, mapX);
      int rY = (int)random(0, mapY);
      float atk = random(0,1);
      float def = random(30, 50);
      color col = color(random(0,255), random(0,255), random(0,255) );
      tileMap[rX][rY].ID = i+1;
      tileMap[rX][rY].col = col;
      tileMap[rX][rY].atk = atk;
      tileMap[rX][rY].def = def;
      
      tileMap[rX][rY].display();
    }
  } //end of Tmap constructor
  
  void display(){ //displays all Tiles stored in the Tmap regardless of if it has been updated
    for(int i=0; i<mapX;i++){ //loop i
      for(int j=0; j<mapY;j++){ //loop j
        tileMap[i][j].display();      
      }
    }
  } //end of method display()
  
  //computes attack/defense actions. Updates and draws results
  void update(){
    int buff = 100; //Compensates for vertical bias in the computation of the array by buffing up and left attacks - Still under testing
    for(int i=0; i<mapX;i++){ //loop i
      for(int j=0; j<mapY;j++){ //loop j
        //int rside = (int)(random(0,1)*4); //roll for random direction to attack
        int rside = (int)random(-0.5, 3.5);
        float roll = random(0, 100) + tileMap[i][j].atk; //roll random attack value
        
        switch(rside) {
          case 0: //up (j-1)
            if( j-1 > -1 ){
              if( roll > tileMap[i][j-1].def ){
                if(tileMap[i][j].ID != tileMap[i][j-1].ID ){ //do not attack same ID
                  tileMap[i][j-1].duplicate(tileMap[i][j]);
                  tileMap[i][j-1].display();
                }
              }
            } else {
              if( roll > tileMap[i][mapY-1].def){
                if( tileMap[i][j].ID != tileMap[i][mapY-1].ID ){ //do not attack same ID
                  tileMap[i][mapY-1].duplicate(tileMap[i][j]);
                  tileMap[i][mapY-1].display();
                }
              }
            }
            break;
          case 1: //right (i+1)
            if( i+1 < mapX ){
              if( roll > tileMap[i+1][j].def ){
                if( tileMap[i][j].ID != tileMap[i+1][j].ID ){ //do not attack same ID
                  tileMap[i+1][j].duplicate(tileMap[i][j]);
                  tileMap[i+1][j].display();
                }
              }
            } else{
              if( roll > tileMap[0][j].def){
                if( tileMap[i][j].ID != tileMap[0][j].ID ){ //do not attack same ID
                  tileMap[0][j].duplicate(tileMap[i][j]);
                  tileMap[0][j].display();
                }
              }
            }
            break;
          case 2: //down (j+1)
            if( j+1 < mapY ){
              if( roll > tileMap[i][j+1].def ){
                if( tileMap[i][j].ID != tileMap[i][j+1].ID ){ //do not attack same ID
                  tileMap[i][j+1].duplicate(tileMap[i][j]);
                  tileMap[i][j+1].display();
                }
              }
            } else{
              if( roll > tileMap[i][0].def ){
                if( tileMap[i][j].ID != tileMap[i][0].ID ){ //do not attack same ID
                  tileMap[i][0].duplicate(tileMap[i][j]);
                  tileMap[i][0].display();
                }
              }
            }
            break;
          case 3: //left (i-1)
            if( i-1 > -1 ){
              if( roll+buff > tileMap[i-1][j].def ){
                if( tileMap[i][j].ID != tileMap[i-1][j].ID ){ //do not attack same ID
                  tileMap[i-1][j].duplicate(tileMap[i][j]);
                  tileMap[i-1][j].display();
                }
              }
            } else {
              if( roll > tileMap[mapX-1][j].def ){
                if( tileMap[i][j].ID != tileMap[i][j].ID ){ //do not attack same ID
                  tileMap[mapX-1][j].duplicate(tileMap[i][j]);
                  tileMap[mapX-1][j].display();
                }
              }
            }
        } //end of switch
      } //end of loop j
    } //loop i
  } //end of method update()
  
  //returns a count of total count of unique ID's still active - returns(int)
  int idTotal(){
    int idArray[] = new int[mapX*mapY]; //Array containing list of all tile IDs
    int b = 0; //stores place on idArray while stepping through 2D array
    for(int i=0; i<mapX;i++){
      for(int j=0; j<mapY;j++){
        idArray[b] = tileMap[i][j].ID;
        b++;
      }
    }
    java.util.Arrays.sort(idArray); //sort the array into numerical order (e.g. 4,1,56,4 --> 1,4,4,56)
    int dif = 0;
    int pid = 0;
    for(int i=0; i < idArray.length; i++){ //generate a count of each different type of ID in the list
      if(idArray[i] != pid ){
        dif++;
      }
      pid = idArray[i];
    }
    return(dif);
  } //end of method idCount()
  
  //int idCount(int) //returns a count of a total count of a specific ID still active - returns(int)
  int idCount(int id){
    int idArray[] = new int[mapX*mapY]; //Array containing list of all tile IDs
    int b = 0; //stores place on idArray while stepping through 2D array
    for(int i=0; i<mapX;i++){
      for(int j=0; j<mapY;j++){
        idArray[b] = tileMap[i][j].ID;
        b++;
      }
    }
    int count = 0;
    for ( int i=0; i < idArray.length; i++) {
      if ( idArray[i] == id ) {
        count++;
      }
    }
    return( count );
  } //end of method idCount()
  
} //end of class Tmap