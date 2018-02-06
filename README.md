<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### aws-asp

> A plugin for [Oh My Fish][omf-link].

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

Enables quick switching between AWS profiles. Supports both hard-coded keys
(role will have to come later)

## Prerequisites

The machine which you are using should support following standard commands

* `grep`
* `fgrep`

## Install

```fish
$ omf install https://github.com/tanmng/omf-aws-asp.git
```

## Available commands

* `asp` - Set up AWS_DEFAULT_PROFILE environment variable to specify the profile
    you wish to use in subsequent commands
* `asc` - Clear all AWS-related environment variables
* `ase` - Set up `AWS_ACCESS_KEY_ID`, `$AWS_SECRET_ACCESS_KEY` and `AWS_DEFAULT_REGION` (in case your CLI utility doesn't support AWS profile)

## Usage

### `asp`

Parameter:

* `profile_name` The name of the profile (set in `~/.aws/config`) that we wish
    to set to `AWS_DEFAULT_PROFILE`

Set the value of `AWS_DEFAULT_PROFILE` so that subsequent command can use the
appropriate profile.

Sample
```fish
$ asp test

Setting AWS_DEFAULT_PROFILE to test
```

### `ase`

* Sets `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables to the corresponding values from `~/.aws/credentials`;
* Sets `AWS_DEFAULT_PROFILE` environment variables to the corresponding values from `~/.aws/config`.

Parameter:

* `profile_name` The name of the profile (set in `~/.aws/config`)

Sample
```fish
$ ase aws-hs-searchnp

Setting AWS_DEFAULT_REGION to WAIT A SECOND, WHY SHOULD I PRINT THIS OUT AGAIN?
Setting AWS_ACCESS_KEY_ID to WAIT A SECOND, WHY SHOULD I PRINT THIS OUT AGAIN?
Setting AWS_SECRET_ACCESS_KEY to WAIT A SECOND, WHY SHOULD I PRINT THIS OUT AGAIN?
```

### `asc`

> This command doesn't take any parameter

Remove all AWS-related environment variables (filtered by the RegExp `AWS_[^=]+`

## Todo

* Use the value of `AWS_SHARED_CREDENTIALS_FILE` and `AWS_CONFIG_FILE` if set
* Support using `assume_role` for credentials

[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/tanmng
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish
[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
