/*

Designing with Code | Snow Laser

A snow generating Processing app created using object oriented programming.

Laser all snow away!

Controls

* left click: laser
* mouse wheel: wind direction
* right click: reset wind
* mouse move: hide instructions

view on GitHub: https://github.com/meisterhauns/Snow-Laser

*/



//editable constants
static final int amountOfSnowflakes = 25000;
static final int windowWidth = 1280;
static final int windowHeight = 720;
static final int snowSpawnrate = 10; //10 is recommended - higher values spawn less but bigger snow particles, which increases performance
static final int amountOfStars = 15;

//do not edit
Snowflake[] snowflakes = new Snowflake [amountOfSnowflakes];
Snow[] snow = new Snow[0];
float[][] stars;

float maxSnowLayer = 0; //for slowly building up snow to eventually spawn on the whole screen
int timer = 0; //counts up to the snow spawnrate, then a new particle is spawned
int wind = 0;
boolean endInstructions = false;


public void settings() {
    size(windowWidth, windowHeight, P2D);
    //fullScreen();
}


public void setup() {
    background(20);
    noCursor();
    stars = setupStars(amountOfStars);
    snowflakes = setupSnowflakes(snowflakes, wind);
}


public void draw(){

    background(#050017);

    renewSnowflakes(snowflakes, wind);

    if (timer >= snowSpawnrate){
        int counter = 0;
        while (counter < 10){ //spawn 10 at once
            Snow s = generateSnow(maxSnowLayer, snowSpawnrate);
            snow = (Snow[])append(snow, s);
            timer = 0;
            //--optional: print snow data
            println("snow amount: " + snow.length + " | max H: " + (height - maxSnowLayer) + " | location: " + s.getX() + " : " + s.getY());
            maxSnowLayer = checkMaxSnowLayer(s, maxSnowLayer);
        counter++;
        }
    }

    changeCursor();
    wind = mouseActions(snow, wind);

    drawSky(stars);
    drawSnowSnowflakes(snowflakes, snow, wind);
    drawCar();
    drawText(endInstructions);

    timer++;
}