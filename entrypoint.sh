#!/bin/bash
mkdir -p /ComfyUI/models/{checkpoints,diffusers,loras,upscale_models,clip,diffusion_models,photomaker,vae,clip_vision,embeddings,style_models,vae_approx,configs,gligen,text_encoders,controlnet,hypernetworks,unet}
exec "$@"
