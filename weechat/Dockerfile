FROM weechat/weechat:latest

USER root

RUN apt-get update && \
    apt-get install -y python3-pip python3-venv python3-websocket && \
    python3.11 -m venv /opt/weechat_venv && \
    /opt/weechat_venv/bin/python -m pip install websocket-client

CMD ["weechat"]
