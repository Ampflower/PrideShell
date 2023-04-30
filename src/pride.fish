#!/bin/env fish

# Copyright 2023 Ampflower
#
# This software is subject to the terms of the Zlib License.
# If a copy was not distributed with this file, you can obtain one at
# https://github.com/Ampflower/PrideShell/blob/main/LICENSE
#
# Source: https://github.com/Ampflower/PrideShell
# SPDX-License-Identifier: Zlib

# All the flags to choose from.

set __pride_rainbow 0xE40203 0xFE8D00 0xFFED00 0x008025 0x004DFF 0x750787
set __pride_gay 0x3F685B 0x7EC181 0xFFFFFF 0x63BBCB 0x033657
set __pride_lesbian 0xD52D00 0xFF9A56 0xFFFFFF 0xD362A4 0xA30262
set __pride_plural 0x31C69E 0x347DDE 0x6B3FBD 0x000000
set __pride_trans 0x5BCEFA 0xF5A9B8 0xFFFFFF 0xF5A9B8 0x5BCEFA
set __pride_demi_girl1 0x7F7F7F 0xC4C4C4 0xFEAFC9 0xFFFFFF 0xFEAFC9 0xC4C4C4 0x7F7F7F
set __pride_demi_girl2 0xC000E4 0xE0B9FB 0xFCC3F1 0xF8F0FC 0xEFA2D2 0xE86699 0x935E92
set __pride_demi_boy1 0x7F7F7F 0xC4C4C4 0x9AD9EB 0xFFFFFF 0x9AD9EB 0xC4C4C4 0x7F7F7F
set __pride_demi_boy2 0x027BE4 0xB9D8FD 0xC1F3FE 0xF2FDF0 0xA0A9EF 0xA193E5 0x685F92
set __pride_demi_gender 0x7F7F7F 0xC4C4C4 0xFAFF74 0xFFFFFF 0xFAFF74 0xC4C4C4 0x7F7F7F
set __pride_bi_gender 0x6992D9 0x92C2E8 0xFFFFFF 0xC4A4EA 0xFFFFFF 0xF8ABC5 0xED7AA8
set __pride_genderfluid 0xE948A1 0xFFFFFF 0xAD00DE 0x343434 0x5643ED
set __pride_genderqueer 0xB562D9 0xFFFFFF 0x578D3B
set __pride_agender 0x000000 0xB9B9B9 0xFFFFFF 0xB8F482 0xFFFFFF 0xB9B9B9 0x000000
set __pride_aroace 0xE38C01 0xECCD00 0xFFFFFF 0x62AEDF 0x203857
set __pride_aro 0x3CA542 0xA7D379 0xFFFFFF 0xA9A9A9 0x000000
set __pride_ace 0x000000 0xA3A3A3 0xFFFFFF 0x7F007F
set __pride_bisexual 0xD60270 0x9A4F96 0x0039A9
set __pride_intersex 0xFFC901 0xFFC901 0x9A00FF 0xFFC901 0x9A00FF 0xFFC901 0xFFC901
set __pride_enbee 0xFAF533 0xFDFDFD 0x9C58D1 0x2C2C2C
set __pride_pineapple 0xFF7200 0xFF7200 0x000000 0xFF7200 0x000000 0xFF7200 0xFF7200
set __pride_proxyfox 0x2D3131 0xE8DACA 0xFD8803 0x2D3131 0xFD8803 0xE9CA9A 0x97594D

# Pride flags; alternatively declare your array directly.
set __pride_1 "$__pride_rainbow"
set __pride_2 "$__pride_rainbow"
set __pride_3 "$__pride_trans"

# Colour dividers
set __pride_1_d 1
set __pride_2_d 2
set __pride_3_d 1

# " #", " $" and ">" works as well
set __pride_end " &"



### Internals from here on ###

set __pride_i 0
set __pride_len (math (string length $USER$hostname) + 8)

function __pride_colour
	set -f c (string split ' ' $argv[1])
	set -f i (math $__pride_i % (count $c) + 1)
	set -f c $c[$i]
	# Normalise input to avoid division by 0;
	set -f d $argv[2]
	if test $d -lt 1; set -f d 1; end

	set -f r (math "floor(bitand($c / 65536, 255) / $d)")
	set -f g (math "floor(bitand($c / 256,   255) / $d)")
	set -f b (math "floor(bitand($c / 1,     255) / $d)")
	echo -ne \e\[38\;2\;$r\;$g\;"$b"m
end

function fish_prompt
	set -f 1 (__pride_colour "$__pride_1" "$__pride_1_d")
	set -f 2 (__pride_colour "$__pride_2" "$__pride_2_d")
	set -f 3 (__pride_colour "$__pride_3" "$__pride_3_d")
	set -g __pride_i (math $__pride_i + 1)


	set -f location (string replace ~ \~ $PWD)

	printf '\033]0;%s@%s:%s\033\\[%s%s\033[m@%s%s\033[m] %s%s\033[m%s ' \
        		"$USER" "$hostname" "$location" "$1" "$USER" "$2" "$hostname" "$3" "$location" "$__pride_end"
end

function fish_right_prompt
	printf '[\033[31m%s\033[m]' $status
end
