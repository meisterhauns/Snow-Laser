class Raindrop{

    float x1;
    float y1;
    float x2;
    float y2;
    float size;
    float speed;
    color c;    

    Raindrop(){
        this.x1 = 0;
        this.y1 = 0;
        this.x2 = 0;
        this.y2 = 0;
        this.size = 0.1;
        this.speed = 0.1;
        this.c = color(255);
    }

    Raindrop(float x, float y, float speed){
        this.x1 = x;
        this.y1 = y;
        this.x2 = x;
        this.y2 = y;
        this.size = speed;
        this.speed = speed;
        this.c = color(255);
    }

    public float getX1() {
        return this.x1;
    }
    
    public void setX1(float x1) {
        this.x1 = x1;
    }

    public float getX2() {
        return this.x2;
    }

    public float getY1() {
        return this.y1;
    }

    public void setY1(float y1) {
        this.y1 = y1;
    }

    public float getY2() {
        return this.y2;
    }

    public void setColor(color c) {
        this.c = c;
    }

    public float getSpeed() {
        return this.speed;
    }

    public float getSize() {
        return this.size;
    }
    

    public void updateRaindrop(float wind){
        if (this.y1 >= 0){
            this.x1 += wind;
            this.x2 += wind;
        }
        this.y1 += speed;
        this.y2 += speed * 0.99;
        if (this.speed < 20 && this.y1 >= 0){
            this.speed += this.speed*0.05;
        }
        this.size = speed*0.1;
    }

    public void drawRaindrop(){
        stroke (this.c);
        strokeWeight(this.size); 
        line(this.x1, this.y1, this.x2, this.y2);
    }
}