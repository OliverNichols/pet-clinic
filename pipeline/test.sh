#!/bin/bash
export CHROME_BIN=/usr/bin/chromium-browser
cd spring-petclinic-angular
PATH="$PATH"
ng build
npm run test-headless
