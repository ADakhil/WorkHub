FROM mono:latest

# Install xsp4 (and its dependencies)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      mono-xsp4 \
 && rm -rf /var/lib/apt/lists/* 

RUN mkdir /opt/app
COPY . /opt/app

CMD ["xsp4", "/opt/app"]
