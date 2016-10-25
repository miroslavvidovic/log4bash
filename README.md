# log4bash

Let's face it - plain old **echo** just doesn't cut it.  **log4bash** is an attempt to have better logging for Bash scripts (i.e. make logging in Bash suck less).

## Original author

Fred Palmer

## Using log4bash

**source** the *log4bash.sh* script at the beginning of any Bash program.

``` bash

    #!/usr/bin/env bash
    source log4bash.sh

    log "This is regular log message... log and log_info do the same thing";

    log_warning "Luke ... you turned off your targeting computer";
    log_info "I have you now!";
    log_success "You're all clear kid, now let's blow this thing and go home.";
    log_error "One thing's for sure, we're all gonna be a lot thinner.";

    # If you have figlet installed -- you'll see some big letters on the screen!
    log_captains "What was in the captain's toilet?";

    # If you have the "espeak" command (e.g. on Linux)
    log_speak "Resistance is futile";

```

## An Overview of log4bash


### Colorized Output

[![](https://img.skitch.com/20110526-46e6ng8hj11pshw2s5my7e841.jpg)](https://img.skitch.com/20110526-46e6ng8hj11pshw2s5my7e841.jpg)

### Logging Levels

* **log_info**

    Prints an "INFO" level message to stdout with the timestamp of the occurrence.

* **log_warning**

    Prints a "WARNING" level message to stdout with the timestamp of the occurrence.

* **log_success**

    Prints a "SUCCESS" level message to stdout with the timestamp of the occurrence.

* **log_error**

    Prints an "ERROR" level message to stdout with the timestamp of the occurrence.

### Special Logging Abilities

* **log_speak**

    On the Linux platform this will use the espeak command to echo the command to the current audio output device.

* **log_captains**

    If the *figlet* program is installed this will print out an ascii-art depiction of the phrase passed to the function.

### Other Useful Tidbits

* **SCRIPT_ARGS**

    A global array of all the arguments used to create run your script

* **SCRIPT_NAME**

    The script name (sometimes tricky to get right depending on how one invokes a script).

* **SCRIPT_BASE_DIR**

    The script's base directory which is not always the current working directory.



