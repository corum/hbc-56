/*
 * Troy's HBC-56 Emulator - Audio
 *
 * Copyright (c) 2021 Troy Schrapel
 *
 * This code is licensed under the MIT license
 *
 * https://github.com/visrealm/hbc-56/emulator
 *
 */

#include "audio.h"
#include "hbc56emu.h"
#include "devices/device.h"

#include "SDL.h"

static SDL_AudioDeviceID audioDevice = 0;
static SDL_AudioSpec audioSpec;

void hbc56AudioCallback(
  void* userdata,
  Uint8* stream,
  int    len)
{
  int samples = len / (sizeof(float) * audioSpec.channels);
  float* str = (float*)stream;

  SDL_memset(stream, 0, len);

  int deviceCount = hbc56NumDevices();
  for (size_t i = 0; i < deviceCount; ++i)
  {
    renderAudioDevice(hbc56Device(i), str, samples);
  }
}

void hbc56Audio(int start)
{
  if (start && audioDevice == 0)
  {
    SDL_AudioSpec want;

    SDL_memset(&want, 0, sizeof(want));
    SDL_memset(&audioSpec, 0, sizeof(audioSpec));
    want.freq = HBC56_AUDIO_FREQ;
    want.format = AUDIO_F32SYS;
    want.channels = 2;
    want.samples = 1024;
    want.callback = hbc56AudioCallback;
    if (SDL_OpenAudio(&want, &audioSpec) == 0) audioDevice = 1;

    SDL_PauseAudioDevice(audioDevice, 0);

    if (audioDevice == 0)
    {
      SDL_Log("Audio error: %s\n", SDL_GetError());
    }
    else
    {
      SDL_Log("Audio device: %d\n", audioDevice);
    }
  }
  else if (audioDevice)
  {
    SDL_PauseAudioDevice(audioDevice, 1);
    SDL_CloseAudioDevice(audioDevice);
    audioDevice = 0;
  }
}

int hbc56AudioChannels()
{
  return audioSpec.channels;
}

int hbc56AudioFreq()
{
  return audioSpec.freq;
}
