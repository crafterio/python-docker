#!/bin/bash

PRE_DIR="${CODE_DIR}/.crafter/scripts/api/pre"
OVERRIDE_DIR="${CODE_DIR}/.crafter/scripts/api/override"
POST_DIR="${CODE_DIR}/.crafter/scripts/api/post"

# Pre Reqs User Scripts
if [[ -d ${PRE_DIR} ]]; then
  SCRIPTS=$(find ${PRE_DIR} -type f -name '*.sh')

  if [[ ! -z ${SCRIPTS} ]]; then
    for script in ${SCRIPTS}; do
      ${script}
    done
  fi
fi

# Override Reqs user scripts
if [[ -d ${OVERRIDE_DIR} ]]; then
  SCRIPTS=$(find ${CODE_DIR}/.crafter/scripts/api/override -type f -name '*.sh')

  if [[ ! -z ${SCRIPTS} ]]; then
    for script in ${SCRIPTS}; do
      ${script}
    done
  else
    # Find requirements
    REQUIREMENTS=$(find ${CODE_DIR} -name requirements.txt -not -path venv -not -path virtualenv)

    if [[ ! -z ${REQUIREMENTS} ]]; then
      for requirement in ${REQUIREMENTS}; do
        pip2 install -r ${requirement}
      done
    fi
  fi
fi

# Post Reqs User Scripts
if [[ -d ${POST_DIR} ]]; then
  SCRIPTS=$(find ${CODE_DIR}/.crafter/scripts/api/post -type f -name '*.sh')

  if [[ ! -z ${SCRIPTS} ]]; then
    for script in ${SCRIPTS}; do
      ${script}
    done
  fi
fi

# Start passenger
/sbin/my_init
