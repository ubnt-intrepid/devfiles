# vim: set ft=zsh ts=2 sw=2 et :

export TEMPLATE_PLUGIN_ROOT="$(dirname ${(%):-%N})"

function template-list() {
  ls --color=no "${TEMPLATE_PLUGIN_ROOT}/templates/" | sed -e 's|/$||'
}
