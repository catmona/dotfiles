#!/bin/bash

if [[ $1 == "true" ]]; then
    surface profile set low-power
    
else
    surface profile set balanced

fi