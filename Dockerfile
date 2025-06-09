FROM docker.io/ubuntu:noble

RUN apt update; apt install -y git curl libopencv-dev
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN /root/.local/bin/uv venv --python 3.12
RUN /root/.local/bin/uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
RUN /root/.local/bin/uv pip install opencv-python imageio-ffmpeg pip

RUN git clone https://github.com/comfyanonymous/ComfyUI /ComfyUI

RUN /root/.local/bin/uv pip install -r /ComfyUI/requirements.txt

# You can optionally install packages for plugins here.
# RUN apt install -y build-essential libssl-dev libffi-dev python3-dev

CMD ["/root/.local/bin/uv", "run", "/ComfyUI/main.py", "--listen"]
