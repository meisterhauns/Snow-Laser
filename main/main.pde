/*

Object oriented programming Snow Generator

Laser all snow away!

Controls:
left click: laser
mouse wheel: wind direction
right click: reset wind

*/



//editable
static final int amountOfRaindrops = 25000;
static final int windowWidth = 1280;
static final int windowHeight = 720;
static final int snowSpawnrate = 1; //lower is faster but draws more particles

//do not edit
private Raindrop[] raindrops = new Raindrop[amountOfRaindrops];
private Snow[] snow = new Snow[0];
float maxSnowLayer = 0;
int timer = 0;
int wind = 0;


public void settings() {
    size(windowWidth, windowHeight, P2D);
    fullScreen();
}


public void setup() {
    background(20);
    noCursor();

    //fill raindrop/snowflake array
    for (int i = 0; i < raindrops.length; i++) {
        raindrops[i] = new Raindrop(random(-0.2 * width - 10*abs(wind), 1.2 * width + 10*abs(wind)), random(height*(-1), 0), random(0.1, 5));
        //--optinal: print raindrop/snowflake data
        //println(raindrops[i].getX1() + " | " + raindrops[i].getY1() + " | " + raindrops[i].getSize());
    }
}


public void draw(){

    background(#050017);

    drawSky();
    

    if((mouseX > 0 && mouseX < width-1) && (mouseY > 0 && mouseY < height-1)){
        noCursor();
    } else {
        cursor(ARROW);
    }

    //drawing raindrops/snowflakes
    for (int i = 0; i < raindrops.length; i++) {
        //laser coloring
        colorize(raindrops[i]);
        //draw raindrops/snowflakes
        raindrops[i].drawRaindrop();
        //update wind direction
        raindrops[i].updateRaindrop(wind);
        //generate new raindrops/snowflakes whenever out of frame
        if (raindrops[i].getY2() > height){
            raindrops[i] = new Raindrop(random(-0.2 * width - 10*abs(wind), 1.2 * width + 10*abs(wind)), random(height*(-1), 0), random(0.1, 5));
        }
    }

    //spawn snow
    if (timer >= snowSpawnrate){
        //create a random snow particle
        Snow s = new Snow(random(0.0, width), random(height - maxSnowLayer - ((float)snowSpawnrate), height - ((float)snowSpawnrate)), (int)random(0,3), random(5*snowSpawnrate,15*snowSpawnrate));
        //add it to the snow array
        snow = (Snow[])append(snow, s);
        //reset the timer to then create a snow particle again
        timer = 0;
        //--optional: print snow data
        println("snow amount: " + snow.length + " | max H: " + (height - maxSnowLayer) + " | location: " + s.getX() + " : " + s.getY());
        //gradually increase spawning height
        if (s.getY() < height - maxSnowLayer){
            if (maxSnowLayer >= height){
                maxSnowLayer = height;
            } else {
                maxSnowLayer = height - s.getY();
            }
        }
    }

    //draw all snow particles
    for (Snow s : snow){
        colorize(s);
        s.drawSnow();
    }

    //reset wind
    if (mousePressed && (mouseButton == RIGHT)) {
        wind = 0;
    }

    //delete snow
    if (mousePressed && (mouseButton == LEFT)) {
        deleteSnow(snow);
    }

    drawCar();
    if (frameCount > 50 && frameCount < 500){
        drawText();
    }

    timer++;
}

//on mousewheel change wind direction
public void mouseWheel(MouseEvent e){
    wind = e.getCount()*3;
}

//colorize rain/snowflakes to show laserpointer
public void colorize(Raindrop r){

    float m = minDistanceToMouse(r.getX1(), r.getY1(), r.getX2(), r.getY2());

    //different colors for different distances
    if (m < 10) {
        r.setColor(color(#ff0000));
    } else if (m < 20) {
        r.setColor(color(#695271));
    } else if (m < 30) {
        r.setColor(color(#695271));
    } else if (m < 40) {
        r.setColor(color(#083051));
    } else {
        r.setColor(color(29, 48, 67, 127 + (r.getSize()/2)*128));
    }
}

public void colorize(Snow s){
    float m = minDistanceToMouse(s.getX(), s.getY());

    //different colors for different distances
    if (m < 10) {
        s.setColor(color(#ff0000));
    } else if (m < 20) {
        s.setColor(color(#695271));
    } else if (m < 30) {
        s.setColor(color(#695271));
    } else if (m < 40) {
        s.setColor(color(#083051));
    } else {
        if (s.colorEquals(color(#142332))) {
            s.setColor(color(#142332));
        } else if (s.colorEquals(color(#1d3043))) {
            s.setColor(color(#1d3043));
        } else if (s.colorEquals(color(#18222d))) {
            s.setColor(color(#18222d));
        } else if (s.colorEquals(color(#121b25))) {
            s.setColor(color(#121b25));
        } else {
            s.setRandomColor();
        }
    }
}


//calculate min distance for a line
public float minDistanceToMouse(float f1, float f2, float f3, float f4){
    return min(sqrt(pow((f1 - mouseX), 2) + pow((f2 - mouseY), 2)),sqrt(pow((f3 - mouseX), 2) + pow((f4 - mouseY), 2)));
}

public float minDistanceToMouse(float f1, float f2){
    return sqrt(pow((f1 - mouseX), 2) + pow((f2 - mouseY), 2));
}


//laser snow away
public void deleteSnow(Snow[] _snow){
    
    //calcualte distance
    for (Snow s : _snow) {
        float m = sqrt(pow((s.getX() - mouseX), 2) + pow((s.getY() - mouseY), 2));
        if (m < 40) {
            //remove by setting size to 0
            s.setSize(0);
        }
    }

}

public void drawCar(){
    stroke(#616875);
    strokeWeight(min(width, height)/10);
    noFill();
    circle(width/2,1.25*height,1.25*height);
}

public void drawSky(){
    //moon
    fill(#fffee6);
    noStroke();
    circle(width*0.8, height*0.15, min(width, height)*0.2);
    fill(#bfe5ff);
    circle(width*0.1, height*0.36, min(width, height)*0.01);
    circle(width*0.22, height*0.28, min(width, height)*0.01);
    circle(width*0.46, height*0.15, min(width, height)*0.01);
    circle(width*0.68, height*0.43, min(width, height)*0.01);
    circle(width*0.77, height*0.59, min(width, height)*0.01);
}

public void drawText(){
    fill(#fffee6);
    textSize((int)(min(width, height)*0.03));
    text("Your windshield wipers are broken and a layer of snow is slowly building up.", width*0.02, height*0.05);
    text("Use your laser to remove the snow.", width*0.02, height*0.10);
    text("Left click to use laser. Change the wind direction with your mouse wheel.", width*0.02, height*0.15);
    text("To reset the wind direction right click.", width*0.02, height*0.20);
}