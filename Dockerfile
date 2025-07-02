FROM docker.io/python:3.12-slim

RUN apt update; apt install -y git curl libopencv-dev g++

RUN git clone https://github.com/comfyanonymous/ComfyUI /ComfyUI
RUN pip install -r /ComfyUI/requirements.txt

# You can optionally install packages for plugins here.
# RUN apt install -y build-essential libssl-dev libffi-dev python3-dev

WORKDIR /ComfyUI/custom_nodes/
RUN git clone https://github.com/ServiceStack/comfy-asset-downloader.git comfy-asset-downloader/
RUN git clone https://github.com/kijai/ComfyUI-DepthAnythingV2.git ComfyUI-DepthAnythingV2/;pip install -r ComfyUI-DepthAnythingV2/requirements.txt
RUN git clone https://github.com/spacepxl/ComfyUI-Depth-Pro.git ComfyUI-Depth-Pro/;pip install -r ComfyUI-Depth-Pro/requirements.txt
RUN git clone https://github.com/Gourieff/ComfyUI-ReActor.git ComfyUI-ReActor/;pip install -r ComfyUI-ReActor/requirements.txt
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager

CMD ["python3", "/ComfyUI/main.py", "--listen"]
