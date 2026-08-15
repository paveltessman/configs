# Sets up the dev environment for the project in the current directory.
#
# This script MUST be sourced, not executed - it modifies the environment of
# the calling shell. The `dev` alias in .zshrc does that.
#
#   .venv/  -> activate the virtualenv
#   go.mod  -> source .setenv (which does its own exporting)

if [ -d "./.venv" ]; then
    . ./.venv/bin/activate
elif [ -f "./go.mod" ]; then
    if [ -f "./.setenv" ]; then
        . ./.setenv
    else
        echo "dev: go.mod found, but no .setenv to source" >&2
    fi
else
    echo "dev: .venv or go.mod not found" >&2
fi
