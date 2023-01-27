# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# For example: add yourself some shortcuts to projects you often work on.
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr
#
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
export CODE=/mnt/c/Users/shaun.ryan/code
export WIN_HOME=/mnt/c/Users/shaun.ryan
export SPARK_HOME="$HOME/opt/spark-3.1.1-bin-hadoop3.2"
export PYENV_HOME="$HOME/.pyenv"

export PATH="$SPARK_HOME/bin:$PYENV_HOME/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# alias pipr='pip install -r requirements.txt'
# alias piprd='pip install -r dev_requirements.txt'
function penv {
    python3 -m venv venv
    source venv/bin/activate
    python3 -m pip install --upgrade pip
}

function pipr {

    source venv/bin/activate

    REQ=./requirements.txt
    if test -f "$REQ"; then
        pip install -r requirements.txt
    fi

    REQD=./dev_requirements.txt
    if test -f "$REQD"; then
        pip install -r requirements.txt
    fi
}



---------------

#  JENV 
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# ENV HOMES
export DATABRICKS_JAR_PATH="$HOME/opt/databricks-connect/v7_1_10/lib/python3.7/site-packages/pyspark/jars"
export PULSAR_PLUGINS="$HOME/.pulsarctl/plugins"
export SCALA_HOME="/usr/local/opt/scala@2.12/bin"
export DAGSTER_HOME="/Users/shaunryan/code/dagster"
export ISTIO_HOME="$HOME/opt/istio-1.6.5"
export KAFKA_HOME="$HOME/opt/kafka_2.12-2.5.0"
export POETRY_HOME="$HOME/.poetry/bin"
# export SPARK_HOME="$HOME/opt/spark-3.3.0-bin-hadoop3"
export SPARK_HOME="$HOME/opt/spark-3.3.1-bin-hadoop3"
export KUBEFLOW_HOME="$HOME/opt/kubeflow"
export KUSTOMIZE_HOME="$HOME/opt/kustomize"
export BICEP_HOME="/Users/shaunryan/.azure/bin"
# export PYTHON_VERSION="/usr/local/opt/python@3.8/bin"
export PYTHON_VERSION="$HOME/.pyenv"

export PATH="$BICEP_HOME:$SPARK_HOME:$SPARK_HOME/bin:$PYTHON_VERSION:$KUSTOMIZE_HOME/bin:$KUBEFLOW_HOME/bin:$POETRY_HOME:$PULSAR_PLUGINS:$KAFKA_HOME/bin:$ISTIO_HOME/bin:$SCALA_HOME:$DAGSTER_HOME:$PATH"
export CLASSPATH=".:/usr/local/lib/antlr-4.10.1-complete.jar:$CLASSPATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# See: https://docs.brew.sh/Homebrew-and-Python

# python@3.8 is keg-only, which means it was not symlinked into /usr/local,
# because this is an alternate version of another formula.

# If you need to have python@3.8 first in your PATH, run:
#   echo 'export PATH="/usr/local/opt/python@3.8/bin:$PATH"' >> ~/.zshrc

# For compilers to find python@3.8 you may need to set:
#   export LDFLAGS="-L/usr/local/opt/python@3.8/lib"

# For pkg-config to find python@3.8 you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/python@3.8/lib/pkgconfig"

# Mac Big Sur fix
# export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
# export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"
# function pyenvi(){
#   CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include" LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib" pyenv install --patch $1 < <(curl -sSL https://github.com/python/cpython/commit/8ea6353.patch\?full_index\=1)
# }

export MONGOCONF=/usr/local/etc/mongod.conf
export MONGOLOG=/usr/local/var/log/mongodb
export MONGODATA=/usr/local/var/mongodb

alias mongog="brew services start mongodb-community@4.2"
alias mongos="brew services stop mongodb-community@4.2"
alias postgresg="pg_ctl -D /usr/local/var/postgres start"
alias postgress="pg_ctl -D /usr/local/var/postgres stop"
alias ads="/Applications/Azure\ Data\ Studio.app/Contents/Resources/app/bin/code"
alias d="docker"
alias k="kubectl"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias istio="istioctl"
alias antlr4='java -jar /usr/local/lib/antlr-4.10.1-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'

function ksn(){
  microk8s kubectl config set-context --current --namespace=$1
} 

alias kg="microk8s kubectl get"
alias kgl="microk8s kubectl logs"
alias kglp="microk8s kubectl logs -p"
alias kgn="microk8s kubectl get namespaces"
alias kgp="microk8s kubectl get pods"
alias kgd="microk8s kubectl get deployments"
alias kgs="microk8s kubectl get services"
alias kdesc='microk8s kubectl describe'
alias k="microk8s kubectl"
alias pyBuild='python setup.py sdist bdist_wheel'

penv(){
  local name="${1:-venv}"
  python3 -m venv $name
  source $name/bin/activate
  pip3 install --upgrade pip
}

# gpip() {
#     PIP_REQUIRE_VIRTUALENV="" pip "$@"
# }

pycheck(){
  black .
  pytest
}

dcwipe(){
  docker stop $(docker ps -a -q)
  docker rm -vf $(docker ps -a -q)
}

dciwipe(){
  docker rmi -f $(docker images -a -q)
}

bashin() {
  docker exec -it $1 bash
}

shin() {
  docker exec -it $1 sh
}

din() {
  docker exec -it $1 $2
}

dagit_connect() {
  export DAGIT_POD_NAME=$(kubectl get pods --namespace dagster -l "app.kubernetes.io/name=dagster,app.kubernetes.io/instance=dagster,component=dagit" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8080 to open Dagit"
  kubectl --namespace dagster port-forward $DAGIT_POD_NAME 8080:80
}

flower_connect() {
  export FLOWER_POD_NAME=$(kubectl get pods --namespace dagster -l "app.kubernetes.io/name=dagster,app.kubernetes.io/instance=dagster,component=flower" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:5555 to open Flower"
  kubectl --namespace dagster port-forward $FLOWER_POD_NAME 5555:5555
}

gitsend() {
  git stage .
  git commit -m "$1"
  git push
}

gitissue() {
  git branch "getting-started-step-$1"
  git checkout "getting-started-step-$1"
  git stage .
  git commit -m  "getting-started-step-$1"
  git push --set-upstream origin "getting-started-step-$1"
}

hkgit(){
  local org="${2:-shaunryan}"
  git stage .
  git commit -m "init"
  git remote add origin git@github.com:$org/$1.git
  git branch -M main
  git push -u origin main  
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/shaunryan/opt/anaconda/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/shaunryan/opt/anaconda/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/shaunryan/opt/anaconda/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/shaunryan/opt/anaconda/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate


