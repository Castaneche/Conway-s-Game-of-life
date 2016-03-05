import java.util.Map;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Set;

int[][] grid = new int[40][40];
int factor = 20;
boolean editMode = true;
float update = 0;
void setup()
{
   size(800,600);
   frameRate(60);
}
void draw()
{
  background(0);
  
  update++;
  
  if(editMode)
    ColGrid(grid);
  if(!editMode && update/60 > 0.1){
    Update();
    update = 0;  
  }
  
  drawGrid(grid);
}
void keyReleased()
{
   if(key == ENTER && editMode == true) editMode = false; 
   else if(key == ENTER && editMode == false) editMode = true; 
}
void ColGrid(int[][] pGrid)
{
  for(int i = 0 ; i < pGrid.length ; i++)
  {
     for(int j = 0 ; j < pGrid[i].length ; j++)
     {
       if(mousePressed)
       {
         if(mouseX > i*factor && mouseX < i*factor + factor && mouseY > j * factor && mouseY < j*factor + factor)
         {
            if(mouseButton == LEFT)
              pGrid[i][j] = 1;
            else if( mouseButton == RIGHT)
              pGrid[i][j] = 0;
         }
       }
     }
  }
}
void Update()
{
  int[][] nextGrid = cloneGrid(grid);
  Map<String,Integer> directions = new HashMap<String,Integer>();
  int compteur = 0; //Number of cells near.
  for(int i = 0 ; i < grid.length ; i++)
  {
     for(int j = 0 ; j < grid[i].length ; j++)
     {
       directions.put("W",0);
       directions.put("NW",0);
       directions.put("N",0);
       directions.put("NE",0);
       directions.put("E",0);
       directions.put("SE",0);
       directions.put("S",0);
       directions.put("SW",0);
       
       if(i != 0)
       {
         if(j != 0)
           directions.put("NW",grid[i - 1][j - 1]);
         if(j != grid.length-1)
           directions.put("SW",grid[i - 1][j + 1]); 
         directions.put("W",grid[i - 1][j]);
       }
       if(i != grid.length-1)
       {
         if(j != 0)
           directions.put("NE",grid[i + 1][j - 1]);
         if(j != grid.length-1)
           directions.put("SE",grid[i + 1][j + 1]);
         directions.put("E",grid[i + 1][j]);  
       }
       if(j != 0)     
         directions.put("N",grid[i][j - 1]);
       if(j != grid.length-1)
         directions.put("S",grid[i][j + 1]);
       
       for(Integer h : directions.values())
       {
          if(h == 1)
          compteur++;
       }
          
       if(grid[i][j] == 1)
       { 
         if(compteur < 2 || compteur > 3)
           nextGrid[i][j] = 0;
       }
       else
       { 
          if(compteur == 3)
            nextGrid[i][j] = 1;
       }
      compteur = 0; 
      directions.clear();
     }  
  }
  grid = nextGrid;
}

void drawGrid(int[][] pGrid)
{
  stroke(70);
  for(int i = 0 ; i < pGrid.length ; i++)
  {
    line(i*factor,0,i*factor,height);
     for(int j = 0 ; j < pGrid[i].length ; j++)
     {
       line(0,j*factor,width,j*factor);
       if(pGrid[i][j] == 1)
       {
         fill(0,180,0,200);
         rect(i*factor,j*factor,factor,factor);
       }  
     }
   }
}
int[][] cloneGrid(int[][] pGrid)
{
   int[][] clone = new int[pGrid.length][pGrid[0].length];
   for(int i = 0 ; i < pGrid.length ; i++)
   {
     for(int j = 0 ; j < pGrid[i].length ; j++)
     {
       clone[i][j] = pGrid[i][j];
     }
     
   }
   return clone;
}
