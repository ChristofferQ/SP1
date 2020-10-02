import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int player1Life;
  private int player2Life;
  private Dot player1;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;
  private int randomXPosition;
  private int randomYPosition;
  private int maxLife;


  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of food must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player1 = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(0, 0, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    food = new Dot[numberOfFood];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    for (int i = 0; i < numberOfFood; ++i)
    {
      food[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.player1Life = 100;
    this.player2Life = 100;
    this.maxLife = 100;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerOneLife()
  {
    return player1Life;
  }

  public int getPlayerTwoLife()
  {
    return player2Life;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void onKeyPressed(int keyCode)
  {
    keys.onKeyPressed(keyCode);
  }

  public void onKeyReleased(int keyCode)
  {
    keys.onKeyReleased(keyCode);
  }

  public void update()
  {
    updatePlayer1();
    updatePlayer2();
    updateEnemies1();
    updateEnemies2();
    updateFood1();
    updateFood2();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer1()
  {
    //Update player1
    if (keys.wDown() && !keys.sDown())
    {
      player1.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player1.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player1.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player1.moveRight();
    }
  }

  private void updatePlayer2()
  {
    //Update player2
    if (keys.upArrowDown() && !keys.downArrowDown())
    {
      player2.moveUp();
    }
    if (keys.leftArrowDown() && !keys.rightArrowDown())
    {
      player2.moveLeft();
    }
    if (keys.downArrowDown() && !keys.upArrowDown())
    {
      player2.moveDown();
    }
    if (keys.rightArrowDown() && !keys.leftArrowDown())
    {
      player2.moveRight();
    }
  }

  private void updateEnemies1()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx1 = player1.getX() - enemies[i].getX();
        int dy1 = player1.getY() - enemies[i].getY();
        if (abs(dx1) > abs(dy1))
        {
          if (dx1 > 0)
          {
            //Player1 is to the right
            enemies[i].moveRight();
          } else
          {
            //Player1 is to the left
            enemies[i].moveLeft();
          }
        } else if (dy1 > 0)
        {
          //Player1 is down;
          enemies[i].moveDown();
        } else
        {//Player1 is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void updateEnemies2()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx2 = player2.getX() - enemies[i].getX();
        int dy2 = player2.getY() - enemies[i].getY();
        if (abs(dx2) > abs(dy2))
        {
          if (dx2 > 0)
          {
            //Player2 is to the right
            enemies[i].moveRight();
          } else
          {
            //Player2 is to the left
            enemies[i].moveLeft();
          }
        } else if (dy2 > 0)
        {
          //Player2 is down;
          enemies[i].moveDown();
        } else
        {//Player2 is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void updateFood1()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we avoid or move randomly?
      //2 out of 3 we will avoid..
      if (rnd.nextInt(3) < 2)
      {
        //We avoid
        int dx1 = player1.getX() - food[i].getX();
        int dy1 = player1.getY() - food[i].getY();
        if (abs(dx1) > abs(dy1))
        {
          if (dx1 > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy1 > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }

  private void updateFood2()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we avoid or move randomly?
      //2 out of 3 we will avoid..
      if (rnd.nextInt(3) < 2)
      {
        //We avoid
        int dx2 = player2.getX() - food[i].getX();
        int dy2 = player2.getY() - food[i].getY();
        if (abs(dx2) > abs(dy2))
        {
          if (dx2 > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy2 > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert players
    board[player1.getX()][player1.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert food
    for (int i = 0; i < food.length; ++i)
    {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player1.getX() && enemies[i].getY() == player1.getY())
      {
        //We have a collision - decrease playerOne life and "respawn" enemy in a random position
        --player1Life;
        if (player1Life <= 0)
        {
          noLoop();
          println("Player 2 wins");
        }
        //Enable this if you want enemies to "respawn" aswell
        //randomPosition();
        //enemies[i].setX(randomXPosition);
        //enemies[i].setY(randomYPosition);
      }
      if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have a collision - decrease playerTwo life and "respawn" enemy in a random position
        --player2Life;
        if (player2Life <= 0)
        {
          noLoop();
          println("Player 1 wins");
        }
        //Enable this if you want enemies to "respawn" aswell
        //randomPosition();
        //enemies[i].setX(randomXPosition);
        //enemies[i].setY(randomYPosition);
      }
    }
    //Check food collisions
    for (int i = 0; i < food.length; ++i)
    {
      if (food[i].getX() == player1.getX() && food[i].getY() == player1.getY())
      {
        //We have a collision - increase platyer life and "respawn" food in a random position
        ++player1Life;
        randomPosition();
        food[i].setX(randomXPosition);
        food[i].setY(randomYPosition);
        //players maximum life is set to 100
        if (player1Life > maxLife)
        {
          player1Life = maxLife;
        }
      }
      if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY())
      {
        //We have a collision - increase platyer life and "respawn" food in a random position
        ++player2Life;
        randomPosition();
        food[i].setX(randomXPosition);
        food[i].setY(randomYPosition);
        if (player2Life > maxLife)
        {
          player2Life = maxLife;
        }
      }
    }
  }

  private void randomPosition()
  {
    randomXPosition = (int)random(width);
    randomYPosition = (int)random(height);
  }
}
