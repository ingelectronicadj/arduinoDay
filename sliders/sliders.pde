/**
* Deslizadores horizontales y verticales,
* Con marcas, sin marcas y comportamiento de ajuste.
*/

import controlP5.*;
//import java.io.FileWriter;
import java.io.BufferedWriter;
//import java.util.*;

ControlP5 JAM;
int miColor = color(0,0,0);

int sHorizontal = 120;
int sVertical = 80;
int mHorizontal = 30;

PrintWriter output;
BufferedWriter writer;
//Mod 1
int unPWMfacil = 27; //--gpio 4,17,18,27,21,22,23,24,25...

/* Tipo de datos para almacenar imágenes .gif, .jpg, .tga, .png */
PImage img;

void setup() {
  size(600,400);
  noStroke();
  img = loadImage("../arduinoDay.png");
  JAM = new ControlP5(this);
  
  JAM.addSlider("sHorizontal")
     .setPosition(100,50)
     .setRange(0,100)
     ;
  
  JAM.addSlider("sVertical")
     .setPosition(100,120)
     .setSize(20,120)
     .setRange(0,100)
     .setNumberOfTickMarks(5)
     ;
     
     
  JAM.addSlider("sliderJAM")
     .setPosition(100,305)
     .setSize(200,20)
     .setRange(0,255)
     .setValue(0)
     ;
  //Controlador de ajuste para el PWM
  JAM.getController("sliderJAM").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  JAM.getController("sliderJAM").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  

  JAM.addSlider("mHorizontal")
     .setPosition(100,370)
     .setWidth(400)
     .setRange(255,0)
     .setValue(130)
     .setNumberOfTickMarks(7)
     .setSliderMode(Slider.FLEXIBLE)  //der-izq
     ;
}

void setPWM(int pin, float duty) {
  output = createWriter("/dev/pi-blaster");
  output.println(pin+"="+duty);
  output.flush();
  output.close();
}

void draw() {
  background(sVertical);
  image(img, 160, 100);// img ,posicion x, posicion y
    
  fill(sHorizontal);
  rect(0,0,width,100);
  
  fill(miColor);
  rect(0,280,width,70);
  
  fill(mHorizontal);
  rect(0,350,width,50);
}

void sliderJAM(int valor) {
  miColor = color(valor);
  println("Evento del slider --> PWM = "+ valor);
  float duty = valor/255.0;
  println("Ciclo util de la senal= " + duty);
  setPWM(unPWMfacil,duty);
}
