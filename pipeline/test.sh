#!/bin/bash
export CHROME_BIN=/usr/bin/chromium-browser
cd spring-petclinic-angular
ng build
npm run test-headless
