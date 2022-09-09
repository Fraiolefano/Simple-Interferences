int a=127;
float time=0.0;

float[] data0={(float)(2*Math.PI/2.0),(float)(2*Math.PI/100.0),450,450};  //pulsation,angular wave number,posX,posY
float[] data1={(float)(2*Math.PI/2.0),(float)(2*Math.PI/100.0),50,50};

Wave w1;
Wave w2;
int THICKNESS_RESOLUTION=5; //5 
int ideal_resolution=500;  // Per migliorare le prestazioni su cellulare
float y=0;

int nPoints;

int color_mode=6;
color selectedColor;

int heightPos=0;
WindowSection main,menu;

Slider sliderWaveL;
Slider sliderWaveL2;
Slider sliderPeriod;
Slider sliderPeriod2;
Radio colorRadio;

void settings()
{
  size(ideal_resolution*2,ideal_resolution,P3D);
  pixelDensity(1);
}
void setup()
{
  frameRate(24);
  background(0);
  textAlign(CENTER);
  initWindows();
  setOptions();

  nPoints=ceil(ideal_resolution*3);

  stroke(255);
  strokeWeight(THICKNESS_RESOLUTION); //5
  noFill();

  w1=new Wave(data0);
  w2=new Wave(data1);
}

void draw()
{
  time=millis()/1000.0;
  onChange();
  background(0);
  
  w1.draw();
  w2.draw();
  translate(0,0,1);
  menu.draw();

  strokeWeight(THICKNESS_RESOLUTION); //5
  noFill();
}

void positionControl()
{
   if (mouseY>0 && mouseY<height && mouseX>0 && mouseX<ideal_resolution)
   {
     if (mousePressed && mouseButton==LEFT)
     {
       data0[2]=mouseX;
       data0[3]=mouseY;
     }
     else if (mousePressed && mouseButton==RIGHT)
     {
       data1[2]=mouseX;
       data1[3]=mouseY;
     }
   }
}

class Wave
{
   float[] arrayData;
   float v;  //angular velocity
   float k;  //wave number
   public Wave(float[] arrayData) //per passargli i valori by reference
   {
     this.arrayData=arrayData;
     this.v=arrayData[0];
     this.k=arrayData[1];
   }

   void draw()
   {
     switch (color_mode)
     {
       case 0:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(y,y,y,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
       case 1:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(y,0,0,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
       case 2:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(0,y,0,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
       case 3:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(0,0,y,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
       case 4:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(y,y/2,0,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
       case 5:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(y,0,y/2,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
       case 6:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(0,y,y/2.0,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
       case 7:
         for(int x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
         {
           y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
           stroke(0,y/2.0,y,50);
           circle(this.arrayData[2],this.arrayData[3],x);
         }
         break;
     }
   }
}

void saveShot()
{
  // nowTime=year()+"_"+month()+"_"+day()+"-"+hour()+"-"+minute()+"-"+second();
  // imageName="./imgs/SimpleInterference"+"_"+nowTime+".png";
  // save(imageName);
  // console.log("Saved : "+imageName);
}

void initWindows()
{
  main=new WindowSection(new PVector(0,0),new PVector(ideal_resolution,ideal_resolution));
  menu=new WindowSection(new PVector(ideal_resolution,0),new PVector(width-ideal_resolution,ideal_resolution));
  menu.stepSize=ideal_resolution/20.0;
  menu.scrollRange=new PVector(-25*menu.stepSize,0);
  
  main.bgColor=color(0);
  menu.bgColor=color(0);
}

void setOptions()
{
  float centerX=menu.size.x/2.0;
  float barW=menu.size.x-menu.stepSize;
  TextElem title_o=new TextElem("Digital Ondoscope",new PVector(centerX,menu.stepSize));
  title_o.fontSize=30;
  
  TextElem author_o=new TextElem("By "+"Fraiolefano",new PVector(centerX,menu.stepSize*1.5));
  author_o.fontSize=15;

  sliderWaveL=new Slider("Lunghezza d'onda 1",new PVector(centerX,menu.stepSize*4),new PVector(50,200,100),1,barW);
  sliderWaveL2=new Slider("Lunghezza d'onda 2",new PVector(centerX,menu.stepSize*7),new PVector(50,200,100),1,barW);
  sliderWaveL.textPos.y-=10;
  sliderWaveL2.textPos.y-=10;
  
  sliderPeriod=new Slider("Periodo 1",new PVector(centerX,menu.stepSize*10),new PVector(0.1,10,2),0.1,barW);
  sliderPeriod2=new Slider("Periodo 2",new PVector(centerX,menu.stepSize*13),new PVector(0.1,10,2),0.1,barW);
  sliderPeriod.textPos.y-=10;
  sliderPeriod2.textPos.y-=10;
  
  colorRadio=new Radio("Color mode",new PVector(centerX,menu.stepSize*16),new PVector(8,color_mode));
  colorRadio.boxDist=menu.size.x/colorRadio.values.x;

  menu.windowElements.add(title_o);
  menu.windowElements.add(author_o);
  
  menu.windowElements.add(sliderWaveL);
  menu.windowElements.add(sliderWaveL2);

  menu.windowElements.add(sliderPeriod);
  menu.windowElements.add(sliderPeriod2);
  
  menu.windowElements.add(colorRadio);

  menu.initElements();
}

void mousePressed()
{
  positionControl(); 
  menu.mousePressed();
}
void mouseReleased()
{ 
  menu.mouseReleased();
}
void mouseDragged()
{
  positionControl();
}
void onChange()
{
  if(menu.onChange().value)
  { 
    if (menu.changed.el==sliderWaveL)
    {
      data0[1]=2*PI/( (float)(sliderWaveL.range.z) );
    }
    else if (menu.changed.el==sliderWaveL2)
    {
      data1[1]=2*PI/( (float)(sliderWaveL2.range.z) );
    }

    else if (menu.changed.el==sliderPeriod)
    {
     data0[0]=2*PI/ ( (float)(sliderPeriod.range.z) );
    }
    else if (menu.changed.el==sliderPeriod2)
    {
      data1[0]=2*PI/ ( (float)(sliderPeriod2.range.z) );
    }
    else if (menu.changed.el==colorRadio)
    {
      color_mode=(int)colorRadio.values.y;
    }
  }
}
