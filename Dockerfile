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

ARG bearerToken=EAAKVtdWkq4kBAOLOu4gM60AyZAL0WYvoWyBFTiccQqVAq8ETAMt2ZA1TZB7D188upnXGrTQpVvUYP6SaZBl7vxiOd2ZCQZBgKsGoFfTZA2xEID7KKzZBjZCmi9VWGtbeOpCBkpY1I5ohIIUxBuL2j2fRp1eemD9IGrKZCvLwU3uzAIdCU3ZAXPeHZACgYoIDe043TsdPD70gZBxFZBlAZDZD
ENV bearerToken=EAAKVtdWkq4kBAOLOu4gM60AyZAL0WYvoWyBFTiccQqVAq8ETAMt2ZA1TZB7D188upnXGrTQpVvUYP6SaZBl7vxiOd2ZCQZBgKsGoFfTZA2xEID7KKzZBjZCmi9VWGtbeOpCBkpY1I5ohIIUxBuL2j2fRp1eemD9IGrKZCvLwU3uzAIdCU3ZAXPeHZACgYoIDe043TsdPD70gZBxFZBlAZDZD

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port", "5000"]
