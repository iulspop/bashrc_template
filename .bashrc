cowsay "Unhurried, aware, playfully moving forward."

PS1="\n\e[0;35m\]\d\e[0m\]\n\[\e[0m\]\e[0;31m\]\u\[\e[0;34m\] in \[\e[1;33m\]\w\[\e[m\]\[\e[0;31m\]\n\[\033[35m\]$\[\033[00m\] "

ca () {
  if [[ $# == '0' ]]; then
    command git add -A && git commit -m "Quick commit"
  elif [[ $# == '1' ]]; then
    command git add -A && git commit -m "$1"
  else
    command git add -A && git commit -m "$1" -m "$2"
  fi
}

ct () {
  if [[ $# == '0' ]]; then
    command git add -A && git commit -m "Quick commit" -m "Co-authored-by: Stephen Gontzes <gontzess@gmail.com>
Co-authored-by: Isaak Krautwurst <isaakkraut@gmail.com>
Co-authored-by: Iuliu Pop <iuliu.laurentiu.pop@protonmail.com>
Co-authored-by: Josh Keller <jrkeller@gmail.com>"
  elif [[ $# == '1' ]]; then
    command git add -A && git commit -m "$1" -m "Co-authored-by: Stephen Gontzes <gontzess@gmail.com>
Co-authored-by: Isaak Krautwurst <isaakkraut@gmail.com>
Co-authored-by: Iuliu Pop <iuliu.laurentiu.pop@protonmail.com>
Co-authored-by: Josh Keller <jrkeller@gmail.com>"
  else
    command git add -A && git commit -m "$1" -m "$2

Co-authored-by: Stephen Gontzes <gontzess@gmail.com>
Co-authored-by: Isaak Krautwurst <isaakkraut@gmail.com>
Co-authored-by: Iuliu Pop <iuliu.laurentiu.pop@protonmail.com>
Co-authored-by: Josh Keller <jrkeller@gmail.com>"
  fi
}

fr () {
  command find . \( ! -regex '.*/\..*' \) -type f | xargs sed -i "s/$1/$2/g"
}

n() {
  next_commit=$(command git log --reverse --pretty=%H master | grep -A 1 $(git rev-parse HEAD) | tail -n1)
  command git checkout $next_commit;
  $(output_commit_url $next_commit);
}

p() {
  previous_commit=$(command git rev-parse HEAD^1)
  command git checkout $previous_commit;
  $(output_commit_url $previous_commit);
}

output_commit_url() {
  local commit="$1";
  repo_path=$(git remote get-url --all origin | grep -Po '(?<=github.com[/:]).+/([^.])+');
  echo "https://github.com/$repo_path/commit/$commit" >$(tty);
}

cap() {
  command monolith $1 -afFiIv -o $2;
}

getbr() {
  command git checkout remotes/origin/$1
  command git checkout -b $1
}

compressimgs() {
  parallel convert {} ./optimized/{.}.jpg ::: *.png
  parallel convert {} -quality 50% {} ::: ./optimized/*
}

rmzone() {
  find . -type f -name '*:Zone.Identifier' -print -delete
}

gpk() {
  mkdir $1
  cp /home/joy/uber_dev/templates/go_package_template/* ./$1
  cd $1
  rn template $1
  fr template $1
  fr Template `snake_to_pascal $1`
}

rn() {
  rename "s/$1/$2/" *
  rename "s/$1/$2/" **/*
}

snake_to_pascal() {
 echo $1 | sed -r 's/(^|_)([a-z])/\U\2/g'
}

# Enable globstar (**) in Bash
shopt -s globstar

# Configure display to connect to X server
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
sudo /etc/init.d/dbus start &> /dev/null

# Add PIP bin folder to path
export PATH="$HOME/.local/bin:$PATH"
 
# Add Go to PATH
export PATH="$PATH:/usr/local/go/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.cargo/env"

# Setup personal dev account AWS environment credentials for Pixee
source /home/joy/uber_dev/work/aws_env/aws_env.sh
# aws_env personal

