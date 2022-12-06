#!/bin/sh
	cd dwm && make clean install >/dev/null 2>&1 &
	cd dmenu && make clean install >/dev/null 2>&1 &
	cd dwmblocks && make clean install >/dev/null 2>&1 &
