Tmap tm;

boolean togglebg; //toggles the background

void setup(){
  //size(600,500);
  fullScreen(2);
  background(255);
  
  tm = new Tmap(width, height, 2000);
  
  togglebg = false;
}

void draw(){
  if(togglebg){
    background(0);
  }
  
  tm.update();
  
  //check the number of ID's every 50 frames, if total ID's is < 1, reset
  if(frameCount % 50 == 0 ){
    if( tm.idTotal() == 1 ){
      tm = new Tmap(width, height, 200);
    }
  }
} //end of draw()

void keyPressed(){
  switch(key){
    case 'r':
      tm = new Tmap(width, height, 2000);
      break;
    case 't':
      togglebg = !togglebg;
      break;
    case 'y':
      tm.display();
      break;
  }
} //end of keyPressed()

void mousePressed(){
  println( "---------- Frame: " + frameCount + " --- Framerate: " + frameRate + " ----------" );
  println( tm.idCount(tm.tileMap[mouseX/2][mouseY/2].ID) + " of ID " + tm.tileMap[mouseX/2][mouseY/2].ID );
  
  println( "Total unique IDs remaining: " + tm.idTotal() ); //returns total number of IDs
} //end of mousePressed()
