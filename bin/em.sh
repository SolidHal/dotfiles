#!/bin/sh

[ -z "$1" ] && (emacsclient --create-frame '(scratch)' &) || (emacsclient --create-frame $1 &)
