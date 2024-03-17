find jenkins-* -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cp ./scripts ./{}/scripts -r && \
  cd {} && \
  pwd && \
  docker build -t wolginm/{}:latest ." \;