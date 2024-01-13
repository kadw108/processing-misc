// karmaText
// Inspired by Aleph 2 (Max Cooper and Martin Krzywinski) - https://www.youtube.com/watch?v=tNYfqklRehM

int textWidth = 15;

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

KarmaChar[][] genLevelArray(PGraphics main, int level) {
  noiseDetail(0, 0.5);
  int cols = ceil(main.width / textWidth);
  int rows = ceil(main.height / textWidth);
  
  KarmaChar[][] ka = new KarmaChar[rows][cols];
  
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      int sampleY = row * textWidth;
      int sampleX = col * textWidth;
      
      ka[row][col] = new KarmaChar(level, main.get(sampleX, sampleY));
    }
  }
  
  return ka;
}

KarmaChar[][] genKarmaArray(PGraphics main, float noiseSeed) {
  noiseDetail(0, 0.5);
  int cols = ceil(main.width / textWidth);
  int rows = ceil(main.height / textWidth);
  
  KarmaChar[][] ka = new KarmaChar[rows][cols];
  
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      int sampleY = row * textWidth;
      int sampleX = col * textWidth;
      
      ka[row][col] = new KarmaChar(
        (int) (map(uniformNoise.uniformNoise((float) sampleX, (float) sampleY, noiseSeed), 0, 1, 0, 10)),
         main.get(sampleX, sampleY)
      );
    }
  }
  
  return ka;
}

PGraphics createTextScreen(KarmaChar[][] ka, int w, int h) {
  PGraphics returned = createGraphics(w, h);
  returned.beginDraw();
  
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      int sampleY = row * textWidth;
      int sampleX = col * textWidth;
      KarmaChar kc = ka[row][col];
      
      returned.tint(kc.c);
      returned.image(karma[kc.level], sampleX, sampleY, textWidth, textWidth);
    }
  }
  
  returned.endDraw();
  return returned;
}

/* EDIT A SINGLE ARRAY */

KarmaChar[][] kaLevelShift(KarmaChar[][] ka, int num) {
    for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      int newLevel = ka[row][col].level + num;
      if (newLevel <= 9 && newLevel >= 0) {
        ka[row][col].level += num;
      }
    }
  }
  return ka;
}

KarmaChar[][] kaColorShift(KarmaChar[][] ka, float randomSeed) {
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
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
  return ka;
}

/*
* Makes random symbols flicker.
*/
KarmaChar[][] kaFlicker(KarmaChar[][] ka, float randomSeed, float limit, color c) {
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (noise(row, col, randomSeed) < limit) {
        ka[row][col].c = c;
      }
    }
  }
  return ka;
}
KarmaChar[][] kaFlicker(KarmaChar[][] ka, float randomSeed) {
  for (int row = 0; row < ka.length; row++) {
    for (int col = 0; col < ka[0].length; col++) {
      if (noise(row, col, randomSeed) < 0.15) {
        ka[row][col].c = 0;
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
 */
KarmaChar[][] kaStutter(KarmaChar[][] ka) {
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
