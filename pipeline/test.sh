#!/bin/bash
export CHROME_BIN=/usr/bin/chromium-browser
ng build
npm run test-headless
