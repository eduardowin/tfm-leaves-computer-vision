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

ARG bearerToken=EAAKVtdWkq4kBAG3z4yVdfT5wZCSZCuROEneE2hq1kakXIVppvDb2vzT3CJ2evaqXmpdgnR5Onh60Y5A4eQG2rC9koB36JILthZCmJ3nku9MVyQViaGtZBgelcbKk3poFTKN1vvIT6tJkBsEx3oHd7u7OvzDbd1LPH0QeToDQRstBe1dnv5nLdwMivcFRZCo75nRRudkin6QZDZD
ENV bearerToken=EAAKVtdWkq4kBAG3z4yVdfT5wZCSZCuROEneE2hq1kakXIVppvDb2vzT3CJ2evaqXmpdgnR5Onh60Y5A4eQG2rC9koB36JILthZCmJ3nku9MVyQViaGtZBgelcbKk3poFTKN1vvIT6tJkBsEx3oHd7u7OvzDbd1LPH0QeToDQRstBe1dnv5nLdwMivcFRZCo75nRRudkin6QZDZD

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port", "5000"]
