/*

Object oriented programming Snow Generator

Laser all snow away!

Controls:
left click: laser
mouse wheel: wind direction
richt click: reset wind

*/



//editable
static final int amountOfRaindrops = 5000;
static final int windowWidth = 800;
static final int windowHeight = 800;
static final int snowSpawnrate = 10; //lower is faster

//do not edit
private Raindrop[] raindrops = new Raindrop[amountOfRaindrops];
private Snow[] snow = new Snow[0];
float maxSnowLayer = 0;
int timer = 0;
int wind = 0;


public void settings() {
    size(windowWidth, windowHeight, P2D);
}


public void setup() {
    background(20);

    //fill raindrop/snowflake array
    for (int i = 0; i < raindrops.length; i++) {
        raindrops[i] = new Raindrop(random(-0.2 * width - 10*abs(wind), 1.2 * width + 10*abs(wind)), random(height*(-1), 0), random(0.1, 5));
        //--optinal: print raindrop/snowflake data
        //println(raindrops[i].getX1() + " | " + raindrops[i].getY1() + " | " + raindrops[i].getSize());
    }
}


public void draw(){

    background(#050017);

    //drawing raindrops/snowflakes
    for (int i = 0; i < raindrops.length; i++) {
        //laser pointer colorizer
        colorize(raindrops[i]);
        //drawRaindrops
        raindrops[i].drawRaindrop();
        //update wind direction
        raindrops[i].updateRaindrop(wind);
        //generate new raindrops whenever out of frame
        if (raindrops[i].getY2() > height){
            raindrops[i] = new Raindrop(random(-0.2 * width - 10*abs(wind), 1.2 * width + 10*abs(wind)), random(height*(-1), 0), random(0.1, 5));
        }
    }

    //spawn snow
    if (timer >= snowSpawnrate){
        //create a random snow particle
        Snow s = new Snow(random(0.0, width), random(height - maxSnowLayer - 10, height - millis()/10000), (int)random(0,3), random(30,60));
        //add it to the snow array
        snow = (Snow[])append(snow, s);
        //reset the timer to then create a snow particle again
        timer = 0;
        //--optional: lyprint snow data
        //println("snow amount: " + snow.length + " | max H: " + (800 - maxSnowLayer) + " | location: " + s.getX() + " : " + s.getY());
        //gradually increase spawning height
        if (s.getY() < 800 - maxSnowLayer){
            if (maxSnowLayer >= 800){
                maxSnowLayer = 800;
            } else {
                maxSnowLayer = 800 - s.getY();
            }
        }
    }

    //draw all snow particles
    for (Snow s : snow){
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
    if (m < 30) {
        r.setColor(color(#ff0000));
    } else if (m < 60) {
        r.setColor(color(#695271));
    } else if (m < 90) {
        r.setColor(color(#695271));
    } else if (m < 150) {
        r.setColor(color(#083051));
    } else {
        r.setColor(color(29, 48, 67, 127 + (r.getSize()/2)*128));
    }
}


//calculate min distance for a line
public float minDistanceToMouse(float x1, float y1, float x2, float y2){
    return min(sqrt(pow((x1 - mouseX), 2) + pow((y1 - mouseY), 2)),sqrt(pow((x2 - mouseX), 2) + pow((y2 - mouseY), 2)));
}


//laser snow away
public void deleteSnow(Snow[] _snow){
    
    //calcualte distance
    for (Snow s : _snow) {
        float m = sqrt(pow((s.getX() - mouseX), 2) + pow((s.getY() - mouseY), 2));
        if (m < 100) {
            //remove by setting size to 0
            s.setSize(0);
        }
    }

}