# The MIT License (MIT)
# Copyright (c) 2014 KidMastermind

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

###########################################################
# SETTINGS:

# Leave this blank while building project
WORKSPACE = WORKSPACE_NAME

# Specify project name if there's no WORKSPACE
PROJECT = PROJECT_NAME

APP = APP_NAME
CONFIG = CONFIG_NAME
SCHEME = SCHEME_NAME
###########################################################
# There should be no need to change anything below this line.

BUILD_PATH = $(shell pwd)/Build

INFO_CLR = \033[01;33m
RESULT_CLR = \033[01;32m
RESET_CLR = \033[0m

default: clean build_app

.PHONY: clean
clean:
	@echo "${INFO_CLR}>> Cleaning $(APP)...${RESTORE_CLR}${RESULT_CLR}"
ifdef WORKSPACE
	@xcodebuild -sdk iphoneos -workspace "$(WORKSPACE).xcworkspace" -scheme "$(SCHEME)" -configuration "$(CONFIG)" -jobs 2 clean 2>/dev/null | tail -n 2 | cat && printf "${RESET_CLR}" && rm -rf "$(BUILD_PATH)"
else
	@xcodebuild -sdk iphoneos -project "$(PROJECT).xcodeproj" -scheme "$(SCHEME)" -configuration "$(CONFIG)" -jobs 2 clean 2>/dev/null | tail -n 2 | cat && printf "${RESET_CLR}" && rm -rf "$(BUILD_PATH)"
endif

build_app:
	@echo "${INFO_CLR}>> Building $(APP)...${RESTORE_CLR}${RESULT_CLR}"
ifdef WORKSPACE
	@xcodebuild -sdk iphoneos -workspace "$(WORKSPACE).xcworkspace" -scheme "$(SCHEME)" -configuration "$(CONFIG)" SYMROOT="$(BUILD_PATH)/Products" -jobs 6 build 2>/dev/null | tail -n 2 | cat && printf "${RESET_CLR}" && rm -rf "$(BUILD_PATH)"
else
	@xcodebuild -sdk iphoneos -project "$(PROJECT).xcodeproj" -scheme "$(SCHEME)" -configuration "$(CONFIG)" CONFIGURATION_BUILD_DIR="$(BUILD_PATH)/Products" -jobs 6 build 2>/dev/null | tail -n 2 | cat && printf "${RESET_CLR}" && rm -rf "$(BUILD_PATH)"
endif
