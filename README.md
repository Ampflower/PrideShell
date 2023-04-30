# PrideShell

A UNIX-style shell prompt for POSIX shells and PowerShell with a flare of pride.

## How to use:

 - Add `. ~/.pride<shell>` for your shell in your shell's `.rc` or profile file.
   - For `ash` and `dash` shells: If your dotfiles are not at home, set `__pride_home` to the directory before calling.
   - For `fish`, see [Fish#Setup](#fish)
 - Optionally configure your prompt for what you want.

## Configuring Shells

### Bash

#### Configuring

To set a flag of your liking, you can directly set the variable `__pride_X` with X being the integer. You may also set
the lightness divider with `__pride_X_d` to any value you like.

An example setting the lesbian flag with half the lightness on path:

```sh
# Sets the lesbian flag at variable 3 (path)
__pride_3=("${__pride_lesbian[@]}")

# Sets half lightness on path
__pride_3_d=2
```

You may optionally set the end of the prompt to any character like `$` with the following:

```sh
# Sets the prompt to end with `$` so it emits `[user@host] ~ $ `
__pride_end=' $'
```

#### Variables

The following variables are available for configuration:

| Name          | Purpose                                              |
|---------------|------------------------------------------------------|
| `__pride_1`   | Username Flag (default: `("${__pride_rainbow[@]}")`) |
| `__pride_2`   | Hostname Flag (default: `("${__pride_rainbow[@]}")`) |
| `__pride_3`   | Path Flag (default: `("${__pride_trans[@]}")`)       |
| `__pride_1_d` | Username Flag's lightness divider (default: `1`)     |
| `__pride_2_d` | Hostname Flag's lightness divider (default: `2`)     |
| `__pride_3_d` | Path Flag's lightness divider (default: `1`)         |
| `__pride_end` | End of the prompt (default: `" &"`)                  |

### Ash & Dash

#### Configuring

To set a flag of your liking, you will need to use the `__pride_array` function, which has the parameters of `array`,
`variable` and `lightness divider`.

An example setting the lesbian flag with half the lightness on path:

```sh
# Sets the lesbian flag at pride 3 (path) at half lightness.
__pride_array "$__pride_lesbian" __pride_3 2
```

You may optionally set the end of the prompt to any character like `$` with the following:

```sh
# Sets the prompt to end with `$` so it emits `[user@host] ~ $ `
__pride_end=' $'
```

#### Variables

The following variables are available for configuration:

| Name          | Purpose                                         |
|---------------|-------------------------------------------------|
| `__pride_1`   | Username Flag (default: `"$__pride_rainbow" 1`) |
| `__pride_2`   | Hostname Flag (default: `"$__pride_rainbow" 2`) |
| `__pride_3`   | Path Flag (default: `"$__pride_trans" 1`)       |
| `__pride_end` | End of the prompt (default: `" &"`)             |

### PowerShell

#### Configuring

To set a flag of your liking, you can directly set the variable `$__pride_X` with X being the integer. You may also set
the lightness divider with `$__pride_X_d` to any value you like.

An example setting the lesbian flag with half the lightness on path:

```powershell
# Sets the lesbian flag at variable 3 (path)
$__pride_3=$__pride_lesbian

# Sets half lightness on path
$__pride_3_d=2
```

You may optionally set the end of the prompt to any character like `$` with the following:

```powershell
# Sets the prompt to end with `$` so it emits `[user@host] ~ $ `
$__pride_end=' $'
```

#### Variables

The following variables are available for configuration:

| Name           | Purpose                                          |
|----------------|--------------------------------------------------|
| `$__pride_1`   | Username Flag (default: `$__pride_rainbow`)      |
| `$__pride_2`   | Hostname Flag (default: `$__pride_rainbow`)      |
| `$__pride_3`   | Path Flag (default: `$__pride_trans`)            |
| `$__pride_1_d` | Username Flag's lightness divider (default: `1`) |
| `$__pride_2_d` | Hostname Flag's lightness divider (default: `2`) |
| `$__pride_3_d` | Path Flag's lightness divider (default: `1`)     |
| `$__pride_end` | End of the prompt (default: `" &"`)              |

### Fish

#### Setup

To set up PrideShell, you'll need to drop `pride.fish` in `~/.config/fish/conf.d/`,
or source using `. ~/.pride.fish` in your rc file at `~/.config/fish/config.fish`.

A few things of note for `/conf.d/`:
 - You must not have a `.` at the beginning of the file name.
 - You must have the `.fish` extension.
 - It must not be a symbolic link

#### Configuring

To set a flag of your liking, you can directly set the variable `__pride_X` with X being the integer.
You may also set the lightness divider with `__pride_X_d` to any value you like.

An example setting the lesbian flag with half the lightness on path:

```fish
# Sets the lesbian flag at variable 3 (path)
set __pride_3 $__pride_lesbian

# Sets half lightness on path
set __pride_3_d 2
```

You may optionally set the end of the prompt to any character like `$` with the following:

```fish
# Sets the prompt to end with `$` so it emits `[user@host] ~ $ `
set __pride_end ' $'
```

#### Variables

The following variables are available for configuration:

| Name          | Purpose                                          |
|---------------|--------------------------------------------------|
| `__pride_1`   | Username Flag (default: `$__pride_rainbow`)      |
| `__pride_2`   | Hostname Flag (default: `$__pride_rainbow`)      |
| `__pride_3`   | Path Flag (default: `$__pride_trans`)            |
| `__pride_1_d` | Username Flag's lightness divider (default: `1`) |
| `__pride_2_d` | Hostname Flag's lightness divider (default: `2`) |
| `__pride_3_d` | Path Flag's lightness divider (default: `1`)     |
| `__pride_end` | End of the prompt (default: `" &"`)              |

## Available Flags

```
__pride_rainbow
__pride_gay
__pride_lesbian
__pride_plural
__pride_trans
__pride_demi_girl1
__pride_demi_girl2
__pride_demi_boy1
__pride_demi_boy2
__pride_demi_gender
__pride_bi_gender
__pride_genderfluid
__pride_genderqueer
__pride_agender
__pride_aroace
__pride_aro
__pride_ace
__pride_bisexual
__pride_intersex
__pride_enbee
__pride_pineapple
__pride_proxyfox
```
