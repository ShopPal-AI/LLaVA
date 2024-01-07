FROM ghcr.io/shoppal-ai/llm-base:pytorch-2.0.1-py3.10-cuda-11.8.0-cudnn8-devel-22.04

LABEL maintainer="Ji Wang <wangji@shoppal.ai>"

COPY llava/ /workspace/llava/
COPY pyproject.toml /workspace/
COPY cog.yaml /workspace/
COPY scripts/ /workspace/scripts/

WORKDIR /workspace

#RUN micromamba activate python_310
#RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip config set global.index-url https://pypi.org/simple
RUN pip install --upgrade pip 
RUN pip install -e .
RUN pip install -e ".[train]"
RUN pip install flash-attn --no-build-isolation --index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install torch==2.0.1+cu118 -f https://download.pytorch.org/whl/cu118/torch_stable.html
RUN pip install torchvision==0.15.2+cu118 -f https://download.pytorch.org/whl/cu118/torch_stable.html
