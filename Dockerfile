FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive
COPY . /home
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    libsm6 \
    libxext6
WORKDIR /home
RUN pip install torch torchvision torchaudio
RUN pip install pytorch-quantization
RUN pip install -q git+https://github.com/Deci-AI/super-gradients.git
RUN sed -i -e "s/sghub.deci.ai/sg-hub-nv.s3.amazonaws.com/g" /usr/local/lib/python3.10/dist-packages/super_gradients/training/pretrained_models.py
RUN sed -i -e "s/sghub.deci.ai/sg-hub-nv.s3.amazonaws.com/g" /usr/local/lib/python3.10/dist-packages/super_gradients/training/utils/checkpoint_utils.py
