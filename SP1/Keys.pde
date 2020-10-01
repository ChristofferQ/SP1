class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;
  private boolean upArrowDown = false;
  private boolean leftArrowDown = false;
  private boolean downArrowDown = false;
  private boolean rightArrowDown = false;

  public Keys() {
  }

  public boolean wDown()
  {
    return wDown;
  }

  public boolean aDown()
  {
    return aDown;
  }

  public boolean sDown()
  {
    return sDown;
  }

  public boolean dDown()
  {
    return dDown;
  }
  
  public boolean upArrowDown()
  {
    return upArrowDown;
  }
  
  public boolean leftArrowDown()
  {
    return leftArrowDown;
  }
  
  public boolean downArrowDown()
  {
    return downArrowDown;
  }
  
  public boolean rightArrowDown()
  {
    return rightArrowDown;
  }



  void onKeyPressed(char ch)
  {
    if (ch == 'W' || ch == 'w')
    {
      wDown = true;
    } else if (ch == 'A' || ch == 'a')
    {
      aDown = true;
    } else if (ch == 'S' || ch == 's')
    {
      sDown = true;
    } else if (ch == 'D' || ch == 'd')
    {
      dDown = true;
    }
  }

  void onKeyReleased(char ch)
  {
    if (ch == 'W' || ch == 'w')
    {
      wDown = false;
    } else if (ch == 'A' || ch == 'a')
    {
      aDown = false;
    } else if (ch == 'S' || ch == 's')
    {
      sDown = false;
    } else if (ch == 'D' || ch == 'd')
    {
      dDown = false;
    }
  }
  
    void onKeyPressed(int keyCode)
  {
    if (keyCode == UP)
    {
      upArrowDown = true;
    } else if (keyCode == LEFT)
    {
      leftArrowDown = true;
    } else if (keyCode == DOWN)
    {
      downArrowDown = true;
    } else if (keyCode == RIGHT)
    {
      rightArrowDown = true;
    }
  }
  
    void onKeyReleased(int keyCode)
  {
    if (keyCode == UP)
    {
      upArrowDown = false;
    } else if (keyCode == LEFT)
    {
      leftArrowDown = false;
    } else if (keyCode == DOWN)
    {
      downArrowDown = false;
    } else if (keyCode == RIGHT)
    {
      rightArrowDown = false;
    }
  }
}
