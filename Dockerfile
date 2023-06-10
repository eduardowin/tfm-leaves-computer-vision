# syntax=docker/dockerfile:1

FROM python:3.10-slim-bullseye

WORKDIR /

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN pip3 install httpx==0.23.3
RUN pip3 install heyoo==0.0.9
RUN pip install -U flask-cors

COPY . .

# CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0"]
# EXPOSE 5000
# ENTRYPOINT [ "python3" ]
# CMD [  "app.py"]

ARG urlBase=https://graph.facebook.com/v17.0
ENV urlBase=https://graph.facebook.com/v17.0

ARG bearerToken=EAAKVtdWkq4kBAPVlwDapXXUiKdSFKQZB6ZAxg6tpR9JvWZA3ANPLh9Rn2Kdc62IrfJZCPtGHAsgtCflDHlRqv0pcyTBZBFEHrvL6avD0EG8ZChY8xosyGuS3lxlLcPLUPSblZCJSD7yK2waLQQA6gAFPxWvHcIXexJRNnfc0WiYGAu7XXWjPcVFrM1ZBfc16gTkZAJF7fnmacKgZDZD
ENV bearerToken=EAAKVtdWkq4kBAPVlwDapXXUiKdSFKQZB6ZAxg6tpR9JvWZA3ANPLh9Rn2Kdc62IrfJZCPtGHAsgtCflDHlRqv0pcyTBZBFEHrvL6avD0EG8ZChY8xosyGuS3lxlLcPLUPSblZCJSD7yK2waLQQA6gAFPxWvHcIXexJRNnfc0WiYGAu7XXWjPcVFrM1ZBfc16gTkZAJF7fnmacKgZDZD

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port", "5000"]
