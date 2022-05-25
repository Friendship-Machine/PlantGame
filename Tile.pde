/*
Tile class stores location/color data for a tile, used in class TMap.
Tile(float x location, float y location, int ID, color color);

Methods:
  -Tile.display() //displays a 2x2 square of pixels at the tile's location
  -Tile.duplicate(Tile) //copies ID, col, atk, def from another tile
*/

class Tile {
  PVector loc; //location of the Tile
  int ID; //group ID of the Tile
  color col; //color of the Tile
  float atk, def; //attack and defense modifiers, default to -100 
  
  Tile(int x, int y, int i, color c){
    loc = new PVector(x, y);
    ID = i;
    col = c;
    
    atk = -100;
    def = -100;
  } //end of Tile constructor
  
  //displays the tile at the set location, 2x2 pixels, origin @ upper left.
  void display(){
    //noStroke();
    //fill(col);
    set( (int)loc.x, (int)loc.y, col );
    set( (int)loc.x+1, (int)loc.y, col );
    set( (int)loc.x, (int)loc.y+1, col );
    set( (int)loc.x+1, (int)loc.y+1, col );
  } //end of method display()
  
  //Tile.duplicate(Tile) //copies ID, col, atk, def from another tile
  void duplicate(Tile target){
    ID = target.ID;
    col = target.col;
    atk = target.atk;
    def = target.def;
  } //end of method duplicate()
  
} //end of class Tile