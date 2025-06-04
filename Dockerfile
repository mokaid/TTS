# Dockerfile for Render
FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y git ffmpeg libsndfile1 espeak-ng

# Clone the Coqui repo (already done since you're using your own fork)
WORKDIR /app
COPY . /app

# Install with server support
RUN pip install --upgrade pip && pip install -e .[server]

# Set default port
ENV PORT=5002
EXPOSE 5002

# Start the Coqui TTS HTTP server
CMD ["python3", "TTS/server/server.py", "--model_name", "tts_models/en/ljspeech/glow-tts", "--port", "5002"]
