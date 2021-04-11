# Start from the code-server Debian base image
FROM codercom/code-server:latest 

USER coder

# Apply VS Code settings
COPY deploy-container/settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash

# You can add custom software and dependencies for your environment here. Some examples:
RUN sudo apt-get install build-essential -y
# RUN sudo apt-get install nodejs@latest -y
# RUN sudo apt-get install npm@latest -y
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN bash -i -c 'nvm install node'

# WORKDIR ~/project

# RUN code-server --install-extension esbenp.prettier-vscode
# RUN sudo apt-get install -y build-essential
# RUN COPY myTool /home/coder/myTool
# RUN sudo apt-get install nodejs -y
# RUN npm install
RUN git config --global user.name "Michael Ward"
RUN git config --global user.email mward82@gmail.com

# Fix permissions for code-server
RUN sudo chown -R coder:coder /home/coder/.local

# Port
ENV PORT=8080

# Use our custom entrypoint script first
COPY deploy-container/entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
