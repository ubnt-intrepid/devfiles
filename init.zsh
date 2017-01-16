# vim: set ft=zsh ts=2 sw=2 et :

export TEMPLATE_PLUGIN_ROOT="$(dirname ${(%):-%N})"

function template-apply() {
  cp ${TEMPLATE_PLUGIN_ROOT}/templates/${1}/* .
  git init .
}

function template-list() {
  ls --color=no "${TEMPLATE_PLUGIN_ROOT}/templates/" | sed -e 's|/$||'
}
