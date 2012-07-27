#!/bin/bash
HEAD=$(git describe --tags)
git archive HEAD --prefix=tmw-branding-${HEAD#v}/ -o tmw-branding-${HEAD#v}.tar.gz
