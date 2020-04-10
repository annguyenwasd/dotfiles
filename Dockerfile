FROM ubuntu:18.04

# OS updates and install
RUN apt-get -qq update
RUN apt-get install git sudo zsh build-essential curl file neovim -qq -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/workspace/dotfiles
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/workspace/dotfiles

# Run setup
# RUN sh ./install/install-tools.sh
RUN ["nvim", "-h"]
