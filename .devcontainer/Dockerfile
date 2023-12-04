FROM mcr.microsoft.com/devcontainers/ruby:3.0-bullseye

# Install Rails
RUN su vscode -c "rbenv install 3.0.4"
RUN su vscode -c "rbenv global 3.0.4"
RUN su vscode -c "gem install rails -v 6.1.3.2"
RUN su vscode -c "gem install webdrivers"
RUN su vscode -c "/usr/local/rvm/bin/rvm fix-permissions"
RUN su vscode -c 'echo eval "$(rbenv init - zsh)" >> /home/vscode/.zshrc'

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
# The value is a comma-separated list of allowed domains 
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends nodejs

# [Optional] Uncomment this line to install additional gems.
# RUN su vscode -c "gem install <your-gem-names-here>"

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
