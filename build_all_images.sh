find jenkins-* -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd {} && pwd && \
  docker build -t wolginm/{}:latest ." \;