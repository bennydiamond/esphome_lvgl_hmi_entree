#!/bin/bash

socat pty,link=/dev/hmientree,raw,group-late=dialout,mode=666 tcp:192.168.1.136:1234
