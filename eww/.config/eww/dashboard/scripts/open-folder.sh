#!/bin/bash

eww close control-center
if [[ $1 != "" ]]; then
    pcmanfm $1
fi