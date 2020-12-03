String text1 = "Hello, Make this a typewriter.";
PFont font;
int counter = 0;
boolean isPressed = false;

void setup() {
  background(150);
  size(400, 400);
  //frameRate(20);
  smooth();
  font = createFont("Arial", 48);
  textFont(font, 20);
}

void draw() {
  //if (mousePressed) {
  isPressed = true;
  background(150);
  fill(255);

  if (counter < text1.length()) {
    counter++;
    println(counter + " " + text1.length());
  } else if (counter >= text1.length()) {
    delay(3000);
    text1 = "PogChamp"; 
    counter = 0;
  } 
  text(text1.substring(0, counter), 0, 40, width, height);
  //}
}

void keyPressed() {
  text1 = "PogChamp"; 
  counter = 0;
}
