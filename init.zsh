generate_completions() {
  if [[ ${+commands[(e)${2}]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} ]]; then

    local command=${commands[(e)${2}]:-"$(${commands[asdf]} which $2 2> /dev/null)"}

    [[ -z $command ]] && return 1

    local compfile=$1/functions/_$2
    if [[ ! -e $compfile || $compfile -ot $command ]]; then
      $command --completion-script-zsh >| $compfile
      print -u2 -PR "* Detected a new version '$2'. Regenerated completions."
    fi
  fi
}

# Teleport user CLI
generate_completions "${0:h}" tsh
# Teleport admin CLI
generate_completions "${0:h}" tctl
# Machine ID Bot
generate_completions "${0:h}" tbot
