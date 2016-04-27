#!/bin/bash

# Pre Reqs User Scripts
SCRIPTS=$(find ./.crafter/pre -type f -name '*.sh')

if [[ ! -z ${SCRIPTS} ]]; then
  for script in ${SCRIPTS}; do
    ${script}
  done
fi

# Override Reqs user scripts
SCRIPTS=$(find ./.crafter/override -type f -name '*.sh')

if [[ ! -z ${SCRIPTS} ]]; then
  for script in ${SCRIPTS}; do
    ${script}
  done
else
  # Find requirements
  REQUIREMENTS=$(find . -name requirements.txt -not -path venv -not -path virtualenv)

  if [[ ! -z ${REQUIREMENTS} ]]; then
    for requirement in ${REQUIREMENTS}; do
      pip2 install -r ${requirement}
    done
  fi
fi

# Post Reqs User Scripts
SCRIPTS=$(find ./.crafter/post -type f -name '*.sh')

if [[ ! -z ${SCRIPTS} ]]; then
  for script in ${SCRIPTS}; do
    ${script}
  done
fi


# Start passenger
/sbin/my_init
