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

ARG bearerToken=EAAKVtdWkq4kBAEB9NIliQmOee3ti8ZAOEZAHaWde9sYWXiUUOtk4xVoHgZAqsvhsbZAZC6N4uW3fRvyMoXN3gtakh8eHY2XiKTUyXsnEPbbA9ZAS5ltF1FlvpYjtRtg9OC1ikeU7UmFv9jgVAdbJOJqUt61mZAtnMq7gCW94nRcd8SmlfRYTUrDVuIukVlTyyC2Lo9nswKTFwZDZD
ENV bearerToken=EAAKVtdWkq4kBAEB9NIliQmOee3ti8ZAOEZAHaWde9sYWXiUUOtk4xVoHgZAqsvhsbZAZC6N4uW3fRvyMoXN3gtakh8eHY2XiKTUyXsnEPbbA9ZAS5ltF1FlvpYjtRtg9OC1ikeU7UmFv9jgVAdbJOJqUt61mZAtnMq7gCW94nRcd8SmlfRYTUrDVuIukVlTyyC2Lo9nswKTFwZDZD

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port", "5000"]
