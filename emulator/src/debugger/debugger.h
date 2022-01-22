/*
 * Troy's HBC-56 Emulator - Debugger
 *
 * Copyright (c) 2021 Troy Schrapel
 *
 * This code is licensed under the MIT license
 *
 * https://github.com/visrealm/hbc-56/emulator
 *
 */

#include "../devices/device.h"
#include "SDL.h"

struct vrEmu6502_s;
typedef struct vrEmu6502_s VrEmu6502;


#define DEBUGGER_WIDTH_PX  320
#define DEBUGGER_HEIGHT_PX 720
#define DEBUGGER_BPP       3

#define DEBUGGER_CHAR_W 6
#define DEBUGGER_CHAR_H 8 

#define DEBUGGER_CHARS_X (DEBUGGER_WIDTH_PX / DEBUGGER_CHAR_W)
#define DEBUGGER_CHARS_Y (DEBUGGER_HEIGHT_PX / DEBUGGER_CHAR_H)


void debuggerInit(VrEmu6502 *cpu6502);

void debuggerInitTms(HBC56Device *tms9918);

void debuggerLoadLabels(const char * labelFileContents);

void debuggerUpdate(SDL_Texture *tex, int mouseX, int mouseY);