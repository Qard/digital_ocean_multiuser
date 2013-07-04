# Digital Ocean Multiuser

This is a little shell script helper to manage multiple Digital Ocean accounts from the same computer. It simply exports DIGITAL_OCEAN_CLIENT_ID and DIGITAL_OCEAN_API_KEY to the environment, so use those in place of hard-coded user info.

## Installation

To install you could use the [install script](https://github.com/qard/digital_ocean_multiuser/blob/master/install.sh) (requires Git) using cURL:

	curl https://raw.github.com/qard/digital_ocean_multiuser/master/install.sh | sh

or Wget:

	wget -qO- https://raw.github.com/qard/digital_ocean_multiuser/master/install.sh | sh

<sub>The script clones the repository to `~/.digital_ocean` and adds the source line to your profile (`~/.bash_profile` or `~/.profile`).</sub>

## Usage

	do_user help
	do_user login
	do_user change