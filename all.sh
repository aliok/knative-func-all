#!/usr/bin/env bash

#brew tap knative-extensions/kn-plugins
#brew unlink func || true
#brew install func@1.14  || true
#brew upgrade func  || true
#brew link func@1.14 || true

# get the list of templates (skip the first line, which is the header)
TEMPLATES_LINES=$(func templates | tail -n +2)
IFS=$'\n' read -d '' -r -a TEMPLATE_TUPLES <<< "$TEMPLATES_LINES"
for tuple in "${TEMPLATE_TUPLES[@]}"
do
  IFS=' ' read -r -a tuple <<< "$tuple"
  LANG=${tuple[0]}
  TEMPLATE=${tuple[1]}
  NAME="my-$LANG-$TEMPLATE"
  rm -rf "./${NAME}"
  echo "Language: $LANG, Template: $TEMPLATE"
  func create -l $LANG -t $TEMPLATE $NAME
done
