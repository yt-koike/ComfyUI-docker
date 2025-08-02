FROM docker.io/python:3.12-slim

RUN apt update; apt install -y git curl libopencv-dev g++ ffmpeg
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

RUN curl -sL -o - https://github.com/comfyanonymous/ComfyUI/archive/refs/tags/v0.3.47.tar.gz | tar zxvf - && mv /ComfyUI-0.3.47 /ComfyUI
RUN pip install -r /ComfyUI/requirements.txt

WORKDIR /ComfyUI/custom_nodes/
RUN pip install gitpython onnxruntime
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager/;pip install -r comfyui-manager/requirements.txt
RUN git clone https://github.com/ServiceStack/comfy-asset-downloader.git comfy-asset-downloader/
RUN git clone https://github.com/kijai/ComfyUI-DepthAnythingV2.git ComfyUI-DepthAnythingV2/;pip install -r ComfyUI-DepthAnythingV2/requirements.txt
RUN git clone https://github.com/spacepxl/ComfyUI-Depth-Pro.git ComfyUI-Depth-Pro/;pip install -r ComfyUI-Depth-Pro/requirements.txt
RUN git clone https://github.com/Gourieff/ComfyUI-ReActor.git ComfyUI-ReActor/;pip install -r ComfyUI-ReActor/requirements.txt
RUN git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git ComfyUI-VideoHelperSuite/;pip install -r ComfyUI-VideoHelperSuite/requirements.txt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["python3", "/ComfyUI/main.py", "--listen"]
