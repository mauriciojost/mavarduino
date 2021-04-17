#ifndef MAVARDUINO_SIMULATOR_LAUNCHER
#define MAVARDUINO_SIMULATOR_LAUNCHER
#include <Platform.h>
#include <cstdio>
#include <iostream>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

#ifndef COMMANDS_FILENAME
#define COMMANDS_FILENAME "/tmp/commands.list"
#endif // COMMANDS_FILENAME

#define CL_MAX_LENGTH 65000

enum AppMode { Interactive = 0, NonInteractive = 1 };
AppMode appMode = Interactive;

////////////////////////////////////////
// Functions requested for architecture
////////////////////////////////////////

// Callbacks
///////////////////

void handleCommands() {
  if (appMode == Interactive) {
    RichBuffer commands(1024 * 16);
    log(CLASS_PLATFORM, Debug, "Waiting for %s...", COMMANDS_FILENAME);
    while(access(COMMANDS_FILENAME, 0 ) != 0) {
      sleep(0.1);
    }
    log(CLASS_PLATFORM, Debug, "File %s found!", COMMANDS_FILENAME);
    readFile(COMMANDS_FILENAME, commands.getBuffer());
    printf("###COMMAND: %s\n", commands.getBuffer()->getBuffer());
    remove(COMMANDS_FILENAME);
    Buffer cmdBuffer(64);
    while (commands.split(';', &cmdBuffer) != -1) {
      cmdBuffer.replace('\n', 0);
      cmdBuffer.replace('\r', 0);
      log(CLASS_PLATFORM, Debug, "Command: '%s'", cmdBuffer.getBuffer());
      if (!cmdBuffer.equals("exit")) {
        Cmd cmd(cmdBuffer.getBuffer());
        CmdExecStatus s = m->getBot()->command(&cmd);
        printf("'%s' => %d\n", cmdBuffer.getBuffer(), (int)s);
      } else {
        exit(0);
      }
    }
    remove(COMMANDS_FILENAME);
  }
}

int main(int argc, const char *argv[]) {
  setup();

  int simulationSteps = 10;

  if (argc == 1) {
    appMode = NonInteractive;
  } else if (argc == 1 + 1) {
    appMode = (AppMode)atoi(argv[1]);
  } else if (argc == 1 + 2) {
    appMode = (AppMode)atoi(argv[1]);
    simulationSteps = atoi(argv[2]);
  } else if (argc != 1 + 2) {
    log(CLASS_PLATFORM, Error, "2 args max: <starter> [appMode [steps]]");
    return -1;
  }

  for (int i = 0; i < simulationSteps; i++) {
    log(CLASS_PLATFORM, Debug, "### Step %d/%d", i, simulationSteps);
    handleCommands();
    loop();
  }
  log(CLASS_PLATFORM, Debug, "### DONE");
  return 0;
}

#endif // MAVARDUINO_SIMULATOR_LAUNCHER
