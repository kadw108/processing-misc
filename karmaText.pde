// karmaText
// Inspired by Aleph 2 (Max Cooper and Martin Krzywinski) - https://www.youtube.com/watch?v=tNYfqklRehM

int textWidth = 60;

class KarmaChar {
  int level;
  color c;
  
  KarmaChar(int level, color c) {
    this.level = level;
    this.c = c;
  }
}

KarmaChar[][] cloneKA(KarmaChar[][] ka) {
  KarmaChar[][] newKA = new KarmaChar[ka.length][ka[0].length];

    for (int row = 0; row < ka.length; row++) {
      for (int col = 0; col < ka[0].length; col++) {
        KarmaChar kc = ka[row][col];
        newKA[row][col] = new KarmaChar(kc.level, kc.c);
      }
    }
    
  return newKA;
}

/* generate 2d array of karmaChar corresponding to a given PImage
 * by color picking a pixel at the center of each calculated karmaChar location.
 * colors of (0, 0, 0, 0) (completely transparent) are interpreted as null
 * 
 * main: given PImage
 * level: karma level of each karmaChar (from 0 to 9)
 * maskColor: a karmaChar with this color is instead null. useful for masking out
 * a specific color/area (e.g. black). if null, no color masking is used.
 */
KarmaChar[][] genLevelArray(PImage main, int level, color maskColor) {
  int cols = ceil(main.width / textWidth);
  int rows = ceil(main.height / textWidth);
  
  KarmaChar[][] ka = new KarmaChar[rows][cols];
  
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      int sampleY = row * textWidth;
      int sampleX = col * textWidth;

      color pixelColor = main.get(sampleX, sampleY);
      if (maskColor != color(0,0,0,0) && pixelColor == maskColor) {
        ka[row][col] = null;
      }
      else {
        ka[row][col] = new KarmaChar(level, pixelColor);
      }
    }
  }
  
  return ka;
}
KarmaChar[][] genLevelArray(PImage main, int level) {
  return genLevelArray(main, level, color(0,0,0,0));
}
KarmaChar[][] genLevelArray(int wid, int hei, color c, int level) {
  noiseDetail(0, 0.5);
  int cols = ceil(wid / textWidth);
  int rows = ceil(hei / textWidth);
  
  KarmaChar[][] ka = new KarmaChar[rows][cols];

  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      ka[row][col] = new KarmaChar(level, c);
    }
  }
  
  return ka;
}

/* similar to genLevelArray but the karma level
 * of each symbol is determined by noise and noiseSeed
 */
KarmaChar[][] genKarmaArray(PImage main, float noiseSeed, color maskColor) {
  // noiseDetail(0, 0.5);
  int cols = ceil(main.width / textWidth);
  int rows = ceil(main.height / textWidth);
  
  KarmaChar[][] ka = new KarmaChar[rows][cols];
  
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      int sampleY = row * textWidth;
      int sampleX = col * textWidth;

      color pixelColor = main.get(sampleX, sampleY);
      if (maskColor != color(0,0,0,0) && pixelColor == maskColor) {
        ka[row][col] = null;
      }
      else {
        // int karmaLevel = (int) (map(uniformNoise.uniformNoise((float) sampleX, (float) sampleY, noiseSeed), 0, 1, 0, 10));
        int karmaLevel = floor((noise(noiseSeed + 10, sampleX, sampleY) * 31) / 3.0);
        ka[row][col] = new KarmaChar(karmaLevel, pixelColor);
      }
    }
  }
  
  return ka;
}
KarmaChar[][] genKarmaArray(PImage main, float noiseSeed) {
  return genKarmaArray(main, noiseSeed, color(0, 0, 0, 0));
}

PGraphics createTextScreen(KarmaChar[][] ka, int w, int h) {
  PGraphics returned = createGraphics(w, h);
  returned.beginDraw();
  
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (ka[row][col] != null) {
        int sampleY = row * textWidth;
        int sampleX = col * textWidth;
        KarmaChar kc = ka[row][col];
        
        returned.tint(kc.c);
        returned.image(karma[kc.level], sampleX, sampleY, textWidth, textWidth);
      }
    }
  }
  
  returned.endDraw();
  return returned;
}

// each karma symbol on the final screen has a circular background of bg_color
// symbols only, the space around them is still transparent
PGraphics createTextScreen(KarmaChar[][] ka, int w, int h, color bg_color) {
  PGraphics returned = createGraphics(w, h);
  returned.beginDraw();

  returned.noStroke();

  for (int pass = 0; pass <= 1; pass++) {
    for (int row = 0; row < ka.length; row++) {
      for (int col = 0; col < ka[0].length; col++) {
        if (ka[row][col] != null) {
          int sampleY = row * textWidth;
          int sampleX = col * textWidth;
          KarmaChar kc = ka[row][col];

          if (pass == 0) {
            returned.fill(bg_color);
            returned.circle(sampleX + textWidth/2.0, sampleY + textWidth/2.0, textWidth);
          }
          else {
            returned.tint(kc.c);
            returned.image(karma[kc.level], sampleX, sampleY, textWidth, textWidth);
          }
        }
      }
    }
  }
  
  returned.endDraw();
  return returned;
}

/* EDIT A SINGLE ARRAY */

KarmaChar[][] kaChangeColor(KarmaChar[][] ka, color c) {
    for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (ka[row][col] != null) {
        ka[row][col].c = c;
      }
    }
  }
  return ka;
}

KarmaChar[][] kaChangeLevel(KarmaChar[][] ka, int num) {
    if (num < 0 || num > 9) {
      return ka;
    }

    for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (ka[row][col] != null) {
        ka[row][col].level = num;
      }
    }
  }
  return ka;
}

KarmaChar[][] kaLevelShift(KarmaChar[][] ka, int num) {
    for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (ka[row][col] != null) {
        int newLevel = ka[row][col].level + num;
        if (newLevel <= 9 && newLevel >= 0) {
          ka[row][col].level += num;
        }
      }
    }
  }
  return ka;
}

KarmaChar[][] kaColorShift(KarmaChar[][] ka, float randomSeed) {
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (ka[row][col] != null) {
        color c = ka[row][col].c;
        
        // RGB color shift
        int r = c >> 16 & 0xFF;
        int g = c >> 8 & 0xFF;
        int b = c & 0xFF;
        float mag = 15;
        c = color(r + randomGaussian()*mag, g + randomGaussian()*mag, b + randomGaussian()*mag);
          
        // black color shift
        c = lerpColor(c, 0, noise(col, row, randomSeed-0.5)*2.5 - 1.5);
        
        // white color shift
        c = lerpColor(c, #ffffff, noise(col, row, randomSeed+0.5)*3 - 2);
        
        ka[row][col].c = c;
      }
    }
  }
  return ka;
}

/*
* Makes random symbols flicker in color
* or become null, if color is (0, 0, 0, 0).
*
* limit = noise threshold for symbol to flicker; higher = more flicker
*/
KarmaChar[][] kaFlicker(KarmaChar[][] ka, float randomSeed, float limit, color c) {
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (noise(row, col, randomSeed) < limit && ka[row][col] != null) {
        if (c != color(0, 0, 0, 0)) {
          ka[row][col].c = c;
        }
        else {
          ka[row][col] = null;
        }
      }
    }
  }
  return ka;
}
KarmaChar[][] kaFlicker(KarmaChar[][] ka, float randomSeed) {
  return kaFlicker(ka, randomSeed, 0.5, #000000);
}

/*
* Makes random symbols flicker in karma level.
*
* limit = noise threshold for symbol to flicker; higher = more flicker
*/
KarmaChar[][] kaFlickerKarma(KarmaChar[][] ka, float randomSeed, float limit) {
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (noise(row, col, randomSeed) < limit && ka[row][col] != null) {
        int oldLevel = ka[row][col].level;
        int newLevel = floor((noise(randomSeed + 10, row, col) * 31) / 3.0);
        if (newLevel == oldLevel) {
          newLevel = (oldLevel + 2) % 10;
        }
        ka[row][col].level = newLevel;
      }
    }
  }
  return ka;
}

/*
 * Invert colors of ka
 */
KarmaChar[][] kaInvert(KarmaChar[][] ka) {
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      color c = ka[row][col].c;
      int r = c >> 16 & 0xFF;
      int g = c >> 8 & 0xFF;
      int b = c & 0xFF;
      ka[row][col].c = color(255 - r, 255 - g, 255 - b);
    }
  }
  return ka;
}

/*
 * Remove horizontal stripes of ka 
 * 
 * w: width of non-removed stripes
 * skip: width of removed stripes / width between stripes
 * offset: offset of stripes start
 */
KarmaChar[][] kaHorStripe(KarmaChar[][] ka, int w, int skip, int offset) {
  int total = w + skip; // rows of one non-removed stripe + one removed stripe
  
  for (int row = 0; row < ka.length; row++) {
    
    // set row to null if it falls into 'skip' portion of stripes
    if (abs((row + offset) % total) >= w) {
      for (int col = 0; col < ka[0].length; col++) {
        ka[row][col] = null;
      }
    }
  }
  
  return ka;
}

/*
 * Remove vertical stripes of ka 
 * 
 * w: width of non-removed stripes
 * skip: width of removed stripes / width between stripes
 * offset: offset of stripes start
 */
KarmaChar[][] kaVerStripe(KarmaChar[][] ka, int w, int skip, int offset) {
  int total = w + skip; // rows of one non-removed stripe + one removed stripe
  
  for (int col = 0; col < ka[0].length; col++) {
    
    // set col to null if it falls into 'skip' portion of stripes
    if (abs((col + offset) % total) >= w) {
      for (int row = 0; row < ka.length; row++) {
        ka[row][col] = null;
      }
    }
  }
  
  return ka;
}

/*
 * Remove grid pattern of ka
 * 
 * w: width of grid box
 * offsetX, offsetY: offset of stripes start
 */
KarmaChar[][] kaRemoveGrid(KarmaChar[][] ka, int w, int offsetX, int offsetY) {
  int total = w + w;
      
  for (int col = 0; col < ka[0].length; col++) {
      for (int row = 0; row < ka.length; row++) {
        
        if ((row + offsetY) % total >= w) {
          if (abs((col + offsetX) % total) >= w) {
            ka[row][col] = null;
          }
        }
        
        else if ((row + offsetY) % total < w) {
          if (abs((row + offsetY) % total) < w) {
            ka[row][col] = null;
          }
        }
      }
  }
  
  return ka;
}

/*
 * Remove checkerboard pattern of ka
 * 
 * w: width of grid box
 * offsetX, offsetY: offset of stripes start
 */
KarmaChar[][] kaCheckerboard(KarmaChar[][] ka, int w, int offsetX, int offsetY) {
  int total = w + w;
      
  for (int col = 0; col < ka[0].length; col++) {
      for (int row = 0; row < ka.length; row++) {
        
        if ((row + offsetY) % total >= w) {
          if (abs((col + offsetX) % total) >= w) {
            ka[row][col] = null;
          }
        }
        
        else if ((row + offsetY) % total < w) {
          if (abs((col + offsetX) % total) < w) {
            ka[row][col] = null;
          }
        }
      }
  }
  
  return ka;
}

/*
 * Randomly shift glyph positions of ka
 * TODO
 */
KarmaChar[][] kaStutter(KarmaChar[][] ka) {
  return ka;
}

/*
 * Make a rectangular section of ka into null
 * the rectangle is either on the top, bottom, left or right
 *
 * cutSize: size of cut area as percentage of height/width (0 <= cutSize <= 1)
 * cutDirection: side where section will be removed. 0 = bottom, 1 = top, 2 = left, 3 = right
 */
KarmaChar[][] kaCutDirection(KarmaChar[][] ka, float cutSize, int cutDirection) {

  int kaHeight = ka.length;
  int kaWidth = ka[0].length;

  float realHeight = ceil(cutSize * kaHeight);
  float realWidth = ceil(cutSize * kaWidth);

  for (int col = 0; col < kaWidth; col++) {
      for (int row = 0; row < kaHeight; row++) {
        
        if (
          (cutDirection == 0 && row > realHeight) ||
          (cutDirection == 1 && row < kaHeight - realHeight) ||
          (cutDirection == 2 && col < realWidth) ||
          (cutDirection == 3 && col > kaWidth - realWidth)
        ) {
          ka[row][col] = null;
        }

      }
  }
  
  return ka;

}

/* MERGE FUNCTIONS FOR MERGING 2 ARRAYS */

/*
 * Returns ka1, with ka2 layered over it (where ka2 has an existing value)
 */
KarmaChar[][] kaMerge(KarmaChar[][] ka1, KarmaChar[][] ka2) {
  for (int row = 0; row < ka1.length; row++) {
    for (int col = 0; col < ka1[0].length; col++) {
      if (ka2[row][col] != null) {
        ka1[row][col] = ka2[row][col];
      }
      // else ka1[row][col] remains the same
    }
  }
  return ka1;
}

/*
* Returns ka, with every element of ka1 after num replaced with ka2 equivalent (as long as the ka2 equivalent isn't null)
* Num iterates in row major or col major order.
*/
KarmaChar[][] kaMergeRowMajor(KarmaChar[][] ka1, KarmaChar[][] ka2, int num) {
  for (int row = 0; row < ka1.length; row++) {
    for (int col = 0; col < ka1[0].length; col++) {
      if (ka1[row][col] == null && ka2[row][col] != null) {
        ka1[row][col] = ka2[row][col];
      }
      else if (row * ka1[0].length + col > num && ka2[row][col] != null) {
        ka1[row][col] = ka2[row][col];
      }
      // else ka1[row][col] remains the same
    }
  }
  return ka1;
}
KarmaChar[][] kaMergeColMajor(KarmaChar[][] ka1, KarmaChar[][] ka2, int num) {
  for (int row = 0; row < ka1.length; row++) {
    for (int col = 0; col < ka1[0].length; col++) {
      if (ka1[row][col] == null && ka2[row][col] != null) {
        ka1[row][col] = ka2[row][col];
      }
      else if (col * ka1.length + row > num && ka2[row][col] != null) {
        ka1[row][col] = ka2[row][col];
      }
      // else ka1[row][col] remains the same
    }
  }
  return ka1;
}


/*
 * Returns base, but wherever mask has a black karma cell or null, base will have null
 * Non-black cells in mask are treated as normal
 */
KarmaChar[][] kaMask(KarmaChar[][] mask, KarmaChar[][] base) {
  for (int row = 0; row < base.length; row++) {
    for (int col = 0; col < base[0].length; col++) {
      if (mask[row][col] == null || mask[row][col].c == #000000) {
        base[row][col] = null;
      }
      else {
        base[row][col] = base[row][col];
      }
    }
  }
  return base;
}