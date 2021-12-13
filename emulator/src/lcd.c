/*
 * Troy's HBC-56 Emulator - LCD module
 *
 * Copyright (c) 2021 Troy Schrapel
 *
 * This code is licensed under the MIT license
 *
 * https://github.com/visrealm/hbc-56/emulator
 *
 */
 
#include "lcd.h"
#include <memory.h>

static const size_t scale = 8;

static const size_t borderX = 10;
static const size_t borderY = 5;
static const size_t TEX_BPP = 3;


static const lcdColors[3][3] = { {0x7d, 0xbe, 0x00},  /* no pixel */
                                {0x5f, 0xa9, 0x00},  /* off */
                                {0x1c, 0x14, 0x00} }; /* on */

LCDWindow* lcdWindowCreate(LCDType lcdType) {

  LCDWindow* lcdw = (LCDWindow*)malloc(sizeof(LCDWindow));
  if (lcdw != NULL)
  {
    switch (lcdType)
    {
      case LCD_1602:
        lcdw->lcd = vrEmuLcdNew(16, 2, EmuLcdRomA00);
        break;

      case LCD_2004:
        lcdw->lcd = vrEmuLcdNew(20, 4, EmuLcdRomA00);
        break;

      case LCD_GRAPHICS:
        lcdw->lcd = vrEmuLcdNew(128, 64, EmuLcdRomA00);
        break;
      
      default:
        free(lcdw);
        return NULL;
    }

    size_t nativeWidth = vrEmuLcdNumPixelsX(lcdw->lcd);
    size_t nativeHeight = vrEmuLcdNumPixelsY(lcdw->lcd);

    size_t pixelsWidth = (nativeWidth + (borderX * 2)) * scale;
    size_t pixelsHeight = (nativeHeight + (borderY * 2)) * scale;


    Uint32 windowFlags = 0;
    lcdw->window = SDL_CreateWindow("HBC-56 LCD Display", 50, 50,
                              (int)pixelsWidth / 2,
                              (int)pixelsHeight / 2,
                              windowFlags);

    lcdw->renderer = SDL_CreateRenderer(lcdw->window, -1, SDL_RENDERER_SOFTWARE);
    SDL_RenderSetLogicalSize(lcdw->renderer, (int)pixelsWidth, (int)pixelsHeight);
    lcdw->tex = SDL_CreateTexture(lcdw->renderer, SDL_PIXELFORMAT_RGB24, SDL_TEXTUREACCESS_STREAMING, (int)pixelsWidth, (int)pixelsHeight);
    SDL_SetTextureScaleMode(lcdw->tex, SDL_ScaleModeBest);
    lcdw->frameBuffer = malloc(pixelsWidth * pixelsHeight * TEX_BPP);
    if (lcdw->frameBuffer)
    {

      char* ptr = lcdw->frameBuffer - 1;
      for (size_t y = 0; y < pixelsHeight; ++y)
      {
        for (size_t x = 0; x < pixelsWidth; ++x)
        {
          *(++ptr) = lcdColors[0][0];
          *(++ptr) = lcdColors[0][1];
          *(++ptr) = lcdColors[0][2];
        }
      }
    }

    lcdWindowUpdate(lcdw);
  }

  return lcdw;  
}

void lcdWindowDestroy(LCDWindow* lcdw)
{
  if (lcdw)
  {
    VrEmuLcd *tmpLcd = lcdw->lcd;
    lcdw->lcd= NULL;

    vrEmuLcdDestroy(tmpLcd);
    SDL_DestroyRenderer(lcdw->renderer);
    SDL_DestroyTexture(lcdw->tex);
    SDL_DestroyWindow(lcdw->window);
    free(lcdw->frameBuffer);
    free(lcdw);
  }
}


void lcdWindowUpdate(LCDWindow* lcdw) {
  if (lcdw && lcdw->lcd)
  {
    vrEmuLcdUpdatePixels(lcdw->lcd);

    int w = vrEmuLcdNumPixelsX(lcdw->lcd);
    int h = vrEmuLcdNumPixelsY(lcdw->lcd);

    size_t pixelsWidth = (w + (borderX * 2)) * scale;
    size_t pixelsHeight = (h + (borderY * 2)) * scale;

    size_t xOffset = borderX * scale;
    size_t yOffset = borderY * scale;
    size_t stride = pixelsWidth * TEX_BPP;

    for (int y = 0; y < h; ++y)
    {
      for (int x = 0; x < w; ++x)
      {
        char state = vrEmuLcdPixelState(lcdw->lcd, x, y);
        ++state;

        for (int iy = 0; iy < scale - 1; ++iy)
        {
          char* ptr = lcdw->frameBuffer + (yOffset + y * scale + iy) * stride + (xOffset + x * scale) * TEX_BPP;
          --ptr;

          for (int ix = 0; ix < scale - 1; ++ix)
          {
            *(++ptr) = lcdColors[state][0];
            *(++ptr) = lcdColors[state][1];
            *(++ptr) = lcdColors[state][2];
          }
        }
      }
    }

    SDL_UpdateTexture(lcdw->tex, NULL, lcdw->frameBuffer, (int)stride);
    SDL_RenderCopyF(lcdw->renderer, lcdw->tex, NULL, NULL);

    SDL_RenderPresent(lcdw->renderer);

  }

}