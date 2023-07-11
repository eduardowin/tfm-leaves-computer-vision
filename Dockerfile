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

ARG bearerToken=EAAKVtdWkq4kBAPBkPdQ8RNZC70W7vvmMS7keB04Sta9ZCRqQaEgf1NAZCPQtGHiOzvRMPpMjTWOPyvi40X1pNwtIgPMKXnZAOyMTvKIZBGKZCfbIcBjIsT3zz1h90kXyMxObqUHBTeZA2cdyG6ZCfSBhN6EVxsza4QCkihng7yUGXYEEQftEk0UXYh9XvfOcR0WZAHywTmcMYoAZDZD
ENV bearerToken=EAAKVtdWkq4kBAPBkPdQ8RNZC70W7vvmMS7keB04Sta9ZCRqQaEgf1NAZCPQtGHiOzvRMPpMjTWOPyvi40X1pNwtIgPMKXnZAOyMTvKIZBGKZCfbIcBjIsT3zz1h90kXyMxObqUHBTeZA2cdyG6ZCfSBhN6EVxsza4QCkihng7yUGXYEEQftEk0UXYh9XvfOcR0WZAHywTmcMYoAZDZD

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port", "5000"]
