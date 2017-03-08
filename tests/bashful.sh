#!/usr/bin/env bash

# log4bash - Makes logging in Bash scripting suck less

source ../log4bash.sh

log "This is regular log message... ";

log_info "So is this...";

log_success "Yeah!! Awesome Possum.";

log_warning "Luke ... you turned off your targeting computer";

log_error "Whoops! I made a booboo";

# If you have figlet installed -- you'll see some big letters on the screen!
log_captains "What was in the captain's toilet?";

# If you have the "espeak" command (e.g. on Linux)
log_speak "Resistance is futile";
