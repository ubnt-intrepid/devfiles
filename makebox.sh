#!/bin/bash
set -e
vagrant package \
  --output ./package.box \
  --vagrantfile ./template/Vagrantfile \
