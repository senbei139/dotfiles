if [ -f ~/.zshrc ]; then
  . ~/.zshrc
fi

export PATH=/sbin:/usr/local/bin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin

export GOOGLE_APPLICATION_CREDENTIALS='/Users/senbei139/workspace/gcp_auth.json'

export PATH=/Users/senbei139/.pyenv/versions/3.6.1/lib/python3.6:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
