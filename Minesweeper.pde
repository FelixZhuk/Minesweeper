

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public static int num_bombs = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int rows = 0; rows < NUM_ROWS; rows++) {
    	for (int cols = 0; cols < NUM_COLS; cols++) {
    		buttons[rows][cols] = new MSButton(rows,cols);
    	}
    }
    
    setBombs();
}
public void setBombs()
{
	if (num_bombs <= 0 ) {

	}
	else {
		int bombX = (int)(Math.random()*NUM_ROWS);
		int bombY = (int)(Math.random()*NUM_COLS);
		System.out.println("Bomb at (" + bombX + "," + bombY + ").");
		if (bombs.contains(buttons[bombX][bombY]) == false) {
			bombs.add(buttons[bombX][bombY]);
		}
		num_bombs --;
		setBombs();
	}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    if (isWon() == false) {
    	buttons[9][9].setLabel("You Lose!");
    	buttons[9][10].setLabel("se!");
    	for (int x = 0; x < NUM_ROWS; x++) {
    		for (int y = 0; y < NUM_COLS; y++) {
    			if (bombs.contains(buttons[x][y])) {
		    		fill(255,0,0);
		    	}
	    	}
    	}
    }
    	noLoop();
}
public void displayWinningMessage()
{

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if (keyPressed == true) {
        	marked = !marked;
        	if (marked == false) {
        		clicked = false;
        	}
        }
    	else if (bombs.contains(this)) {
    		displayLosingMessage();
    	}
    	else if (countBombs(r,c) > 0) {
    		setLabel(Integer.toString(countBombs(r,c)));
    	}
    	else {
    		//Start
        	if(isValid(r,c-1) && (buttons[r][c-1].isClicked() == false)) {
            	buttons[r][c-1].mousePressed();
          	}
          	if(isValid(r,c+1) && (buttons[r][c+1].isClicked() == false)) {
            	buttons[r][c+1].mousePressed();
          	}
          	if(isValid(r-1,c) && (buttons[r-1][c].isClicked() == false)){
           		buttons[r-1][c].mousePressed();
          	}
          	if(isValid(r + 1,c) && (buttons[r + 1][c].isClicked() == false)) {
            	buttons[r+1][c].mousePressed();
          	}
    		//End
    	}
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this)) { 
           	fill(255,0,0);
           	displayLosingMessage();
           }
        else if(clicked) 
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0) {
        	return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
		if(isValid(row,col-1) && bombs.contains(buttons[row][col-1])) {
            numBombs++;
        }
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1])) {
            numBombs++;
        }
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col])){
            numBombs++;
        }
        if(isValid(row + 1,col) && bombs.contains(buttons[row+1][col])) {
            numBombs++;
        }
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1])) {
            numBombs++;
        }
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1])) {
            numBombs++;
        }
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1])){
            numBombs++;
        }
        if(isValid(row + 1,col+1) && bombs.contains(buttons[row+1][col+1])) {
            numBombs++;
        }
        //end of my code
        return numBombs;
    }
}



