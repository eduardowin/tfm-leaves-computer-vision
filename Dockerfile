#Create a ubuntu base image with python 3 installed.
FROM ubuntu:22.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && \
    apt-get install -y locales && \
    sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales
ENV LC_TIME es_ES.UTF-8

RUN apt-get install -y wget fontconfig libfreetype6 libpng16-16 \
    libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base libfontconfig1 \
    fontconfig-config libx11-data libxau6 libxdmcp6 xfonts-utils ucf fonts-dejavu-core \
    ttf-bitstream-vera fonts-liberation libbsd0 libfontenc1 libxfont2 \
    x11-common xfonts-encodings

#Set the working directory
WORKDIR /

RUN apt-get -y update
RUN apt-get install -y python3 python3-pip

RUN pip install -U flask-cors
RUN pip install PyJWT==2.4.0
RUN pip3 install Flask==2.0.3
RUN pip3 install gunicorn==20.1.0
RUN pip3 install Jinja2==3.0.3
RUN pip3 install aioflask==0.4.0
RUN pip3 install asgiref==3.6.0

RUN pip3 install importlib-metadata==4.8.3
RUN pip3 install importlib-resources==5.4.0
RUN pip3 install pycodestyle==2.8.0
RUN pip3 install Werkzeug==2.0.3
RUN pip3 install requests==2.27.0
RUN pip3 install asyncio==3.4.3
RUN pip3 install httpx==0.23.3
RUN pip3 install Jinja2==3.0.3
RUN pip3 install joblib==1.2.0
RUN pip3 install tensorflow==2.12.0
RUN pip3 install pandas==2.0.2


RUN rm /bin/sh && ln -s /bin/bash /bin/sh

COPY . .

#Expose the required port
EXPOSE 5000

ENTRYPOINT [ "python3" ]

ARG UrlapiFacturacionVenta=https://prod-apies-venta.herokuapp.com/api/
ENV UrlapiFacturacionVenta=https://prod-apies-venta.herokuapp.com/api/

#Run the command
CMD [  "app.py"]