FROM python:alpine3.7
COPY . /app
WORKDIR /app
RUN pip install -U Flask
EXPOSE 5001
ENTRYPOINT ["python","./index.py"]
