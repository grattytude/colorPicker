import ketai.sensors.*;
KetaiSensor sensor;
PVector accelerometer = new PVector();
PVector paccelerometer = new PVector();
float r, b, g;
int num = 8;
color[] pallete = new color[num];
int palleteIndex = 0;
void setup(){
  orientation(PORTRAIT);
  sensor = new KetaiSensor(this);
  textAlign(CENTER);
  textSize(36);
  sensor.start();
}

void draw(){
  r = map(accelerometer.x, -10, 10, 0, 255);
  g = map(accelerometer.y, -10, 10, 0, 255);
  b = map(accelerometer.z, -10, 10, 0, 255);
  background(r,g,b);
  text("tap to save color & rotate and shake to change color",width/4,height/4);
  fill(0);
  for(int i = 0;i < num;i++){
    fill(pallete[i]);
    rect(i*width/num,height/2,width/num,height/2);
  }
   
  float delta = PVector.angleBetween(accelerometer, paccelerometer);
  if(delta > 45){
    shake();
  }
 paccelerometer.set(accelerometer);
}

void onAccelerometerEvent(float x, float y, float z){
  accelerometer.x = x;
  accelerometer.y = y;
  accelerometer.z = z;
}

void mousePressed(){
  if(mouseY < height/2){
    pallete[palleteIndex] = color(r,g,b);
    if(palleteIndex < num-1){
      palleteIndex++;
    }else{
      palleteIndex = 0;
    }
  }
}
void shake(){
  for(int i = 0; i<num;i++){
   pallete[i] = color(0);
  }
  palleteIndex = 0;
}