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