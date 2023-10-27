FROM haskell:8

WORKDIR /opt/erd

RUN apt-get update && apt-get install -y graphviz
RUN cabal v2-update && cabal v2-install erd

ENTRYPOINT ["erd"]

# docker run -i erd < sample.er > out.pdf
