FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN pip install pytest

COPY app.py .
CMD ["python", "app.py"]
