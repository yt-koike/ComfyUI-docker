FROM docker.io/python:3.12-slim

RUN apt update; apt install -y git curl libopencv-dev g++ ffmpeg
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu129

RUN curl -sL -o - https://github.com/comfyanonymous/ComfyUI/archive/refs/tags/v0.3.47.tar.gz | tar zxvf - && mv /ComfyUI-0.3.47 /ComfyUI
RUN pip install -r /ComfyUI/requirements.txt

WORKDIR /ComfyUI/custom_nodes/
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager/;pip install -r comfyui-manager/requirements.txt
RUN git clone https://github.com/AIGODLIKE/ComfyUI-ToonCrafter ComfyUI-ToonCrafter/; pip install -r ComfyUI-ToonCrafter/requirements.txt
RUN mkdir -p ComfyUI-ToonCrafter/ToonCrafter/checkpoints/tooncrafter_512_interp_v1/
RUN curl -L https://huggingface.co/Doubiiu/ToonCrafter/resolve/main/model.ckpt -o ComfyUI-ToonCrafter/ToonCrafter/checkpoints/tooncrafter_512_interp_v1/model.ckpt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["python3", "/ComfyUI/main.py", "--listen"]
