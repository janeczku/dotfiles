# Brew
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH

# Go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Source secrets
if [ -f ~/.zshenv-secrets ]; then
  source ~/.zshenv-secrets
fi

# Source AWS credentials
if [ -f ~/.aws/aws_variables ]; then
  source ~/.aws/aws_variables
fi