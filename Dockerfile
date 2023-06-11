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

ARG bearerToken=EAAKVtdWkq4kBADMHRXr8tZC5GumllzcWg6E1GUvAmMegNJr8Mr3XhGKDNumA9FSRL1CymmK4LXbz1VTMVoCm9ziXKrga4qxZCGZCkZCk4TUjTnrf5qt2GVnLP8FNV4ZAsHVjvMv66U5Pb0nyYaXMGimghZARNklqz5TI8QNgdpFSGd6ql8YkuDCVywjScwNZAHZAdvjjbdSDqQZDZD
ENV bearerToken=EAAKVtdWkq4kBADMHRXr8tZC5GumllzcWg6E1GUvAmMegNJr8Mr3XhGKDNumA9FSRL1CymmK4LXbz1VTMVoCm9ziXKrga4qxZCGZCkZCk4TUjTnrf5qt2GVnLP8FNV4ZAsHVjvMv66U5Pb0nyYaXMGimghZARNklqz5TI8QNgdpFSGd6ql8YkuDCVywjScwNZAHZAdvjjbdSDqQZDZD

CMD ["python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port", "5000"]
