FROM alpine:latest

RUN apk --no-cache add curl bash jq # Install jq package

# Install Nomad CLI
RUN NOMAD_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/nomad | jq -r .current_version) \
    && curl -Lo /usr/local/bin/nomad https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip \
    && chmod +x /usr/local/bin/nomad

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
