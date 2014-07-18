#!/bin/bash
set -e
BOOTSTRAP_JS_PATH=src/vendor/bootstrap/js
cat \
    src/vendor/jquery/jquery-1.11.0.js \
    ${BOOTSTRAP_JS_PATH}/affix.js \
    ${BOOTSTRAP_JS_PATH}/alert.js \
    ${BOOTSTRAP_JS_PATH}/button.js \
    ${BOOTSTRAP_JS_PATH}/carousel.js \
    ${BOOTSTRAP_JS_PATH}/collapse.js \
    ${BOOTSTRAP_JS_PATH}/dropdown.js \
    ${BOOTSTRAP_JS_PATH}/modal.js \
    ${BOOTSTRAP_JS_PATH}/tooltip.js \
    ${BOOTSTRAP_JS_PATH}/popover.js \
    ${BOOTSTRAP_JS_PATH}/scrollspy.js \
    ${BOOTSTRAP_JS_PATH}/tab.js \
    ${BOOTSTRAP_JS_PATH}/transition.js \
    src/vendor/underscore/underscore.js \
    src/vendor/backbone/backbone.js \
    src/vendor/handlebars/handlebars-v1.3.0.js \
    src/site/site.js \
    | uglifyjs > compiled/site.js
lessc --compress --include-path=src/vendor src/site/site.less > compiled/site.css
cp -r src/vendor/font-awesome/fonts compiled/
