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

ARG bearerToken=EAAKVtdWkq4kBAGl7fthISgILEkEKMbJhoHSJlTUbH4U9KQ0zyOcK1FrUISbouwVh7KtygP972XSuZCQozZCM4JGomESciZAPSAECfrhRHlg6KZCykZAjyIiL6ZBKf9lnSKVuOzIn3K7AqHlTKSaiZBY3Q92H7LK52XbPPWb4Nt3wdUYElz7EZCmFk7stDKaW4SwyOu6XVZC42zwZDZD
ENV bearerToken=EAAKVtdWkq4kBAGl7fthISgILEkEKMbJhoHSJlTUbH4U9KQ0zyOcK1FrUISbouwVh7KtygP972XSuZCQozZCM4JGomESciZAPSAECfrhRHlg6KZCykZAjyIiL6ZBKf9lnSKVuOzIn3K7AqHlTKSaiZBY3Q92H7LK52XbPPWb4Nt3wdUYElz7EZCmFk7stDKaW4SwyOu6XVZC42zwZDZD

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port", "5000"]
