#!/bin/bash

readonly AUTH="${1:?Error: Please set your API token}"
readonly APP="${2:?Error: Please set your application name}"
readonly FILE="${3:?Error: Please set your file for deployment}"
readonly ARVAN="/usr/bin/arvan-cli-0.3.0-linux-amd64/arvan"

print_header() {
	printf "%s\n" "* * * * * * * * * * * * * * * * * * * * *"
	printf "%s\n" "*                                       *"
	printf "%s\n" "*   Arvancloud Edge Computing Action    *"
	printf "%s\n" "*                                       *"
	printf "%s\n" "* * * * * * * * * * * * * * * * * * * * *"
	printf "%s\n" ""
}

print_error() {
	printf " -----> Error: %s\n" "$1"
}

validate_arguments() {
	local errors=0
	for arg in "$@"; do
		if [ -z "$arg" ]; then
			print_error "Empty argument"
			((errors++))
		fi
	done
	return "$errors"
}

get_data() {
	printf " -----> Get data\n"
	printf "Application's name: %s\n" "$APP"
	printf "File for deployment: %s\n" "$FILE"
	printf "%s\n" ""
}

deploy() {
	printf " -----> Deploy\n"
	ARVAN_API_KEY="$AUTH" "$ARVAN" ec deploy -f "$FILE" "$APP"
}

main() {
	set -e
	print_header
	validate_arguments "$@" || exit
	get_data
	deploy
}

main "$@"
