# Use Python base, not CUDA-based image
FROM python:3.10-slim

# Set env variables
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    espeak-ng \
    git \
    ffmpeg \
    libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install TTS via PyPI instead of local editable
RUN pip install --upgrade pip
RUN pip install TTS

# Copy optional start script or use CMD directly
WORKDIR /app

# Expose port used by TTS server
EXPOSE 5002

# Start TTS server (example with default model)
CMD ["tts", "--model_name", "tts_models/en/ljspeech/tacotron2-DDC", "--out_path", "/app/output.wav", "--text", "Hello from Flowise"]
