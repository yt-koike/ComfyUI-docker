FROM docker.io/ubuntu:noble

RUN apt update
RUN apt install -y git python3.12 python3.12-venv

RUN python3.12 -m venv /ComfyEnv
RUN /ComfyEnv/bin/pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

RUN git clone https://github.com/comfyanonymous/ComfyUI /ComfyUI

WORKDIR /ComfyUI
RUN /ComfyEnv/bin/pip install -r requirements.txt

CMD ["/ComfyEnv/bin/python3", "main.py", "--listen"]
