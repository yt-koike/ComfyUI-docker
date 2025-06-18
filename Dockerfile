FROM docker.io/ubuntu:noble

RUN apt update; apt install -y git curl libopencv-dev
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN /root/.local/bin/uv venv --python 3.12
RUN /root/.local/bin/uv pip install pip

RUN git clone https://github.com/comfyanonymous/ComfyUI /ComfyUI
RUN /root/.local/bin/uv pip install -r /ComfyUI/requirements.txt

# You can optionally install packages for plugins here.
# RUN apt install -y build-essential libssl-dev libffi-dev python3-dev

WORKDIR /ComfyUI/custom_nodes/
RUN git clone https://github.com/ServiceStack/comfy-asset-downloader.git comfy-asset-downloader/
RUN git clone https://github.com/kijai/ComfyUI-DepthAnythingV2.git ComfyUI-DepthAnythingV2/;/root/.local/bin/uv pip install -r ComfyUI-DepthAnythingV2/requirements.txt
RUN git clone https://github.com/spacepxl/ComfyUI-Depth-Pro.git ComfyUI-Depth-Pro/;/root/.local/bin/uv pip install -r ComfyUI-Depth-Pro/requirements.txt
RUN git clone https://github.com/Gourieff/ComfyUI-ReActor.git ComfyUI-ReActor/
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager

CMD ["/root/.local/bin/uv", "run", "/ComfyUI/main.py", "--listen"]
