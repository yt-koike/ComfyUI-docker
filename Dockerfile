FROM nvcr.io/nvidia/tensorrt:24.06-py3

RUN apt update
RUN apt install -y git python3-pip libgl1-mesa-dev libglib2.0-0 aria2
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

RUN git clone https://github.com/comfyanonymous/ComfyUI /ComfyUI

WORKDIR /ComfyUI
RUN pip install -r requirements.txt

# install ComfyUI manager (optional)
WORKDIR /ComfyUI/custom_nodes
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager

WORKDIR /ComfyUI
CMD ["python", "main.py", "--listen"]
