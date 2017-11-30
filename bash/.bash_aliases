alias t='timekeeper'
alias ll='exa -lhg --extended --git'
alias tksync='envdo aws/storage.ssly.se.gpg timekeeper-sync'
alias mic-check='arecord -vvv -f dat /dev/null'
alias tle='exa -T -a --git-ignore -I .git'
alias mysqlc='docker run -it --rm mysql mysql'
alias azure="docker run -v ${HOME}/.azure:/root/.azure -it --rm microsoft/azure-cli azure"
alias az="docker run -v ${HOME}/.azure:/root/.azure -it --rm antonlindstrom/azure-cli"
