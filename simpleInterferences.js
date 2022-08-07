//By Fraiolefano

var a=127;
var time=0.0;

var data0=[2*Math.PI/2.0,2*Math.PI/100.0,0,0];  //pulsation,angular wave number,posX,posY
var data1=[data0[0],data0[1],0,0];

var w1;
var w2;
const THICKNESS_RESOLUTION=5; //5 
var ideal_resolution=500  // Per migliorare le prestazioni su cellulare
var y=0;

var nPoints;

var controller=false; //false=controller A,true=controller B
var controllerButton;

var color_mode=0;

function getInputs()
{
  var t11=document.getElementById("t11");
  var t12=document.getElementById("t12");

  var t21=document.getElementById("t21");
  var t22=document.getElementById("t22");
  
  var l21=document.getElementById("l21");
  var l22=document.getElementById("l22");
  controllerButton=document.getElementById("controller");
}

function initInputs()
{

  t11.innerText=2.0;
  t12.innerText=2.0;
  t21.value=2.0;
  t22.value=2.0;


  l21.setAttribute("min",ceil(THICKNESS_RESOLUTION*4));
  l22.setAttribute("min",ceil(THICKNESS_RESOLUTION*4));

  l21.setAttribute("max",ceil(width/2));
  l22.setAttribute("max",ceil(width/2));

  l11.innerText=100;
  l12.innerText=100;
  l21.value=100;
  l22.value=100;

  controllerButton.value="Wave Controller A";
}
function setup()
{

  pixelDensity(1);
  if (ideal_resolution<window_size)
  {
    createCanvas(ideal_resolution,ideal_resolution);
    nPoints=ceil(ideal_resolution*3);
  }
  else
  {
    createCanvas(window_size,window_size);
    nPoints=ceil(window_size*3);
  }

  var c=document.getElementById("defaultCanvas0");
  c.style="width:"+window_size+"px;height:"+window_size+"px;";

  stroke(255);
  strokeWeight(THICKNESS_RESOLUTION); //5
  noFill();
  
  data0[2]=width/2;
  data0[3]=height/2;
  data1[2]=width/2;
  data1[3]=height/2;
  getInputs();
  initInputs();
  generateButtons();
  w1=new Wave(data0);
  w2=new Wave(data1);
}

function draw()
{
  time=millis()/1000.0;
  background(0);
  
  w1.draw();
  w2.draw();

}

function changeData(indexWave)
{
  if (indexWave==0)
  {
    data0[0]=2*Math.PI/t21.value;;
    data0[1]=2*Math.PI/l21.value;;
  }
  else
  {
    data1[0]=2*Math.PI/t22.value;
    data1[1]=2*Math.PI/l22.value;
  }
}

function changeController()
{
  controller=!controller;
  if (!controller)
  {
    controllerButton.value="Wave Controller A";
  }
  else
  {
    controllerButton.value="Wave Controller B";
  }
}
function mousePressed()
{
  positionControl(); 
}

function mouseDragged()
{
  positionControl();
}

function positionControl()
{
  if (mouseY>0 && mouseY<height && mouseX>0 && mouseX<width)
  {
    if (controller)
    {
      data0[2]=mouseX;
      data0[3]=mouseY;
    }
    else
    {
      data1[2]=mouseX;
      data1[3]=mouseY;
    }
  }
}

class Wave
{
  constructor(arrayData) //per passargli i valori by reference
  {
    this.arrayData=arrayData;
    this.v=arrayData[0];
    this.k=arrayData[1];
  }

  draw()
  {
    switch (color_mode)
    {
      case 0:
        for(let x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
        {
          y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
          stroke(y,y,y,50);
          circle(this.arrayData[2],this.arrayData[3],x);
        }
        break;

      case 1:
        for(let x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
        {
          y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
          stroke(y,0,0,50);
          circle(this.arrayData[2],this.arrayData[3],x);
        }
        break;

      case 2:
        for(let x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
        {
          y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
          stroke(0,y,0,50);
          circle(this.arrayData[2],this.arrayData[3],x);
        }
        break;

      case 3:
        for(let x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
        {
          y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
          stroke(0,0,y,50);
          circle(this.arrayData[2],this.arrayData[3],x);
        }
        break;

      case 4:
        for(let x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
        {
          y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
          stroke(0,y,y/2.0,50);
          circle(this.arrayData[2],this.arrayData[3],x);
        }
        break;

      case 5:
        for(let x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
        {
          y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
          stroke(y,y/2,0,50);
          circle(this.arrayData[2],this.arrayData[3],x);
        }
        break;

      case 6:
        for(let x=0;x<nPoints;x+=THICKNESS_RESOLUTION)
        {
          y=127+(a*cos((this.arrayData[0]*time)-(this.arrayData[1]*x)));
          stroke(y,0,y/2,50);
          circle(this.arrayData[2],this.arrayData[3],x);
        }
        break;
    }
  }
}

function generateButtons()
{
  buttonDiv=document.getElementById("colorButtons");
  for(let c=0;c<7;c++)
  {
    divEl=document.createElement("DIV");
    divEl.style="width:13%;display:inline-block;height:50px;";//border:white solid
    radioB=document.createElement("input");
    radioB.setAttribute("type","radio");
    radioB.name="colorations";
    radioB.value=c;
    radioB.onclick=function(){color_mode=c};
    radioB.style="width:50px;height:50px;accent-color:orange;";
    if (c==0){radioB.setAttribute("checked",true); }
    divEl.append(radioB);
    buttonDiv.append(divEl);
  }
}

function saveShot()
{
  nowTime=year()+"_"+month()+"_"+day()+"-"+hour()+"-"+minute()+"-"+second();
  imageName="./imgs/SimpleInterference"+"_"+nowTime+".png";
  save(imageName);
  console.log("Saved : "+imageName);
}
