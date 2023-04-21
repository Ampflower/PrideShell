#!/bin/env pwsh

# Copyright 2023 Ampflower
#
# This software is subject to the terms of the Zlib License.
# If a copy was not distributed with this file, you can obtain one at
# https://github.com/Ampflower/PrideShell/blob/main/LICENSE
#
# Source: https://github.com/Ampflower/PrideShell
# SPDX-License-Identifier: Zlib

# All the flags to choose from.

$__pride_rainbow=0xE40203, 0xFE8D00, 0xFFED00, 0x008025, 0x004DFF, 0x750787
$__pride_gay=0x3F685B, 0x7EC181, 0xFFFFFF, 0x63BBCB, 0x033657
$__pride_lesbian=0xD52D00, 0xFF9A56, 0xFFFFFF, 0xD362A4, 0xA30262
$__pride_plural=0x31C69E, 0x347DDE, 0x6B3FBD, 0x000000
$__pride_trans=0x5BCEFA, 0xF5A9B8, 0xFFFFFF, 0xF5A9B8, 0x5BCEFA
$__pride_demi_girl1=0x7F7F7F, 0xC4C4C4, 0xFEAFC9, 0xFFFFFF, 0xFEAFC9, 0xC4C4C4, 0x7F7F7F
$__pride_demi_girl2=0xC000E4, 0xE0B9FB, 0xFCC3F1, 0xF8F0FC, 0xEFA2D2, 0xE86699, 0x935E92
$__pride_demi_boy1=0x7F7F7F, 0xC4C4C4, 0x9AD9EB, 0xFFFFFF, 0x9AD9EB, 0xC4C4C4, 0x7F7F7F
$__pride_demi_boy2=0x027BE4, 0xB9D8FD, 0xC1F3FE, 0xF2FDF0, 0xA0A9EF, 0xA193E5, 0x685F92
$__pride_demi_gender=0x7F7F7F, 0xC4C4C4, 0xFAFF74, 0xFFFFFF, 0xFAFF74, 0xC4C4C4, 0x7F7F7F
$__pride_bi_gender=0x6992D9, 0x92C2E8, 0xFFFFFF, 0xC4A4EA, 0xFFFFFF, 0xF8ABC5, 0xED7AA8
$__pride_genderfluid=0xE948A1, 0xFFFFFF, 0xAD00DE, 0x343434, 0x5643ED
$__pride_genderqueer=0xB562D9, 0xFFFFFF, 0x578D3B
$__pride_agender=0x000000, 0xB9B9B9, 0xFFFFFF, 0xB8F482, 0xFFFFFF, 0xB9B9B9, 0x000000
$__pride_aroace=0xE38C01, 0xECCD00, 0xFFFFFF, 0x62AEDF, 0x203857
$__pride_aro=0x3CA542, 0xA7D379, 0xFFFFFF, 0xA9A9A9, 0x000000
$__pride_ace=0x000000, 0xA3A3A3, 0xFFFFFF, 0x7F007F
$__pride_bisexual=0xD60270, 0x9A4F96, 0x0039A9
$__pride_intersex=0xFFC901, 0xFFC901, 0x9A00FF, 0xFFC901, 0x9A00FF, 0xFFC901, 0xFFC901
$__pride_enbee=0xFAF533, 0xFDFDFD, 0x9C58D1, 0x2C2C2C
$__pride_pineapple=0xFF7200, 0xFF7200, 0x000000, 0xFF7200, 0x000000, 0xFF7200, 0xFF7200
$__pride_proxyfox=0x2D3131, 0xE8DACA, 0xFD8803, 0x2D3131, 0xFD8803, 0xE9CA9A, 0x97594D

# Pride flags; alternatively declare your array directly.
$__pride_1=$__pride_rainbow
$__pride_2=$__pride_rainbow
$__pride_3=$__pride_trans

# Colour dividers
$__pride_1_d=1
$__pride_2_d=2
$__pride_3_d=1

# " #", " $" and ">" works as well
$__pride_end=" &"



### Internals from here on ###

# Fixes the username problem.
if($null -eq $env:USER) {
    $env:USER = $env:USERNAME
} else {
    $env:USER = whoami
}

# Caches the hostname for the entire session
# Note, toLower is ran after to fix the hostname from Windows.
$Global:HostName=$(hostname).toLower()
# Pride increment.
$Global:__pride_i=0

# This is a bad hack for old PowerShell, as old PowerShell doesn't support `e.
# This is not a problem for PowerShell Core, but it's here anyways.
$Esc=[char]27

function __pride_location() {
    $location=@(Get-Location).Path
    # If the location is under ~ or home, substring the location and replace with ~
    # Note: $HOME is a PowerShell intrinsic, we can trust that it will always be here.
    if($location.startsWith($HOME)) {
        "~$($location.substring($HOME.length))"
    } else {
        $location
    }
}

function __pride_colour($array, $index, $divider = 1) {
    if($divider -lt 1) {
        $divider = 1
    }
    # Prepares the pride.
    $c=[int]$array[$index % $array.length]
    $r=[int](($c -shr 16 -band 255) / $divider)
    $g=[int](($c -shr  8 -band 255) / $divider)
    $b=[int](($c -shr  0 -band 255) / $divider)
    "$Esc[38;2;$r;$g;${b}m"
}

function prompt {
    $lastExit=$Global:LASTEXITCODE
    $location=__pride_location

    $a1=__pride_colour $__pride_1 $Global:__pride_i $__pride_1_d
    $a2=__pride_colour $__pride_2 $Global:__pride_i $__pride_2_d
    $a3=__pride_colour $__pride_3 $Global:__pride_i $__pride_3_d
    $Global:__pride_i+=1

    # Determines the length of the prompt for backtracking.
    $len=$location.length + $env:USER.length + $Global:HostName.length + $NestedPromptLevel + $__pride_end.length + 6

    $(if (Test-Path variable:/PSDebugContext) { $len += 7; '[DBG]: ' } else { '' }) +
        "$Esc]0;$env:USER@"+$Global:HostName+":$location$Esc\$Esc]7;$location$Esc\" +
        "[$a1$env:USER$Esc[m@$a2$Global:HostName$Esc[m] $a3$location$Esc[m" +
    # "`e[$($len)G" is required for IntelliJ, else it won't correctly reset the cursor.
    $('>'*$NestedPromptLevel)+"$__pride_end $Esc[s$Esc[32767C$Esc[$("$lastExit".length+2)D[$Esc[31m$lastExit$Esc[m]$Esc[$($len)G$Esc[u"
}
