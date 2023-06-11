
from io import BytesIO
from flask import Flask, Response, jsonify, current_app
from flask import make_response, send_file
import time

import json
import re
import os
import sys
import requests

from datetime import datetime
from time import sleep
from threading import Thread
from functools import wraps
import os
import asyncio
from flask_cors import CORS
from flask import Flask, render_template, request,jsonify

from math import expm1
import joblib
import pandas as pd
from tensorflow import keras

app = Flask(__name__, static_folder='static')
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

from heyoo import WhatsApp
import cv2
import numpy as np

urlBase = os.environ.get('urlBase')
bearerToken = os.environ.get('bearerToken')

@app.route('/')
def index():
    print('index',flush=True)
    return '<h1> Hola desde flask </h1>'


@app.route("/api/model/evalute", methods=["POST"])
def model_evaluate():
    # data = request.json
    # df = pd.DataFrame(data, index=[0])
    # prediction = model.predict(transformer.transform(df))
    # predicted_price = expm1(prediction.flatten()[0])
    # return jsonify({"price": str(predicted_price)})
    return jsonify({"price":"2324"})

@app.route("/webhook/", methods=["POST", "GET"])
def webhook_whatsapp():
    print('webhook_whatsapp',flush=True)
    #SI HAY DATOS RECIBIDOS VIA GET
    if request.method == "GET":
        #SI EL TOKEN ES IGUAL AL QUE RECIBIMOS
        if request.args.get('hub.verify_token') == "LeafBotModel":
            #ESCRIBIMOS EN EL NAVEGADOR EL VALOR DEL RETO RECIBIDO DESDE FACEBOOK
            return request.args.get('hub.challenge')
        else:
            #SI NO SON IGUALES RETORNAMOS UN MENSAJE DE ERROR
          return "Error de autentificacion."
    #RECIBIMOS TODOS LOS DATOS ENVIADO VIA JSON
    data=request.get_json()

    print('data',flush=True)
    print(data,flush=True)

    primer_mensaje = data['entry'][0]['changes'][0]['value']['messages'][0]
    telefonoCliente = primer_mensaje['from']

    if primer_mensaje['type'] == "image":
        image_id = primer_mensaje['image']['id']

        urlParameter = "/{0}".format(image_id)
        headers = {
            'content-type': 'application/json',
            'Authorization':  'Bearer '+ bearerToken,
        }

 

        wb = str(urlBase) + str(urlParameter)

        print('wb',flush=True)
        print(wb,flush=True)
        response = requests.get(wb, headers=headers)

        if response.status_code == 200:
            dataUrl = response.json()
            resp = requests.get(dataUrl['url'], headers=headers, stream=True).raw

            print('resp',flush=True)
            print(resp,flush=True)

            if resp is not None:
                image = np.asarray(bytearray(resp.read()), dtype="uint8")
                image = cv2.imdecode(image, cv2.IMREAD_COLOR)
                print('image',flush=True)
                print(image,flush=True)
                # cv2.imshow('image',image)
                # cv2.waitKey(0)
                # with open('image_name.jpg', 'wb') as handler:
                #     handler.write(resp.content)
                enviar(telefonoCliente, "La clasificación es:\nHoja Enferma")

            else:
                print('Hubo un error 1',flush=True)
                enviar(telefonoCliente, "Hubo un error al obtener la imagen, por favor volve a intentarlo")
        else:
            print('Hubo un error 2',flush=True)
            enviar(telefonoCliente, "Hubo un error al obtener la imagen, por favor volve a intentarlo")
    else:
        enviar(telefonoCliente, "Este sistema solo acepta imagenes de plantas de mango, por favor enviamos tu imagen a evaluar")
    return jsonify({"status": "success"}, 200)

def enviar(telefonoRecibe,respuesta):
  #TOKEN DE ACCESO DE FACEBOOK
  token = bearerToken
  #IDENTIFICADOR DE NÚMERO DE TELÉFONO
  idNumeroTeléfono = '108937662223602'
  #INICIALIZAMOS ENVIO DE MENSAJES
  mensajeWa = WhatsApp(token,idNumeroTeléfono)
  telefonoRecibe = telefonoRecibe.replace("521","52")
  #ENVIAMOS UN MENSAJE DE TEXTO
  mensajeWa.send_message(respuesta,telefonoRecibe)

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    print('port')
    print(port)
    app.run(host='0.0.0.0', port=port)
