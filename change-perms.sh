#!/bin/bash

for filename in `find . -type f`; do
  echo $filename;
  chmod g-x $filename;
done;
