from io import BytesIO
from flask import Flask, Response, jsonify, current_app
from flask import make_response, send_file
import json
import re
import os
import requests

from datetime import datetime
from time import sleep
from threading import Thread
from functools import wraps
import os
from flask_cors import CORS
from flask import Flask, render_template, request,jsonify

from math import expm1
import pandas as pd
from tensorflow import keras

app = Flask(__name__, static_folder='static')
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

from heyoo import WhatsApp
import cv2
import numpy as np
from tensorflow.keras.models import load_model

urlBase = os.environ.get('urlBase')
bearerToken = os.environ.get('bearerToken')
model = load_model('leaf_model_cnn_accu 0.9279778599739075 --2023-07-15 182517.h5')
widthImage = 224
heightImage = 224

@app.route('/')
def index():
    print('index',flush=True)
    return '<h1> Hola desde flask </h1>'

def resize(x):
  return cv2.resize(x, dsize=(widthImage, heightImage), interpolation = cv2.INTER_AREA)

@app.route("/webhook/", methods=["POST", "GET"])
def webhook_whatsapp():
    if request.method == "GET":
        if request.args.get('hub.verify_token') == "LeafBotModel":
            return request.args.get('hub.challenge')
        else:
          return "Error de autentificacion."
    data=request.get_json()

    if 'messages' in data['entry'][0]['changes'][0]['value']:

        primer_mensaje = data['entry'][0]['changes'][0]['value']['messages'][0]
        telefonoCliente = primer_mensaje['from']
        print(data,flush=True)
        
        if primer_mensaje['type'] == "image":
            image_id = primer_mensaje['image']['id']

            urlParameter = "/{0}".format(image_id)
            headers = {
                'content-type': 'application/json',
                'Authorization':  'Bearer '+ bearerToken,
            }
            wb = str(urlBase) + str(urlParameter)

            print('wb',flush=True)
            response = requests.get(wb, headers=headers)

            if response.status_code == 200:
                dataUrl = response.json()
                resp = requests.get(dataUrl['url'], headers=headers, stream=True).raw

                if resp is not None:
                    image = np.asarray(bytearray(resp.read()), dtype="uint8")
                    image = cv2.imdecode(image, cv2.IMREAD_COLOR)
                    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

                    newImage = resize(image)
                    newImage = newImage.reshape(1, 224, 224, 3)
                    
                    predicted_classes = np.argmax(model.predict(newImage), axis=-1)
                    
                    label_to_text =  {1:'Enferma', 0:'Sana'}
                    text_prediction = label_to_text[predicted_classes[0]]
                    enviar(telefonoCliente, "La clasificación es:\n{}".format(text_prediction))

                else:
                    enviar(telefonoCliente, 
                           "Hubo un error al obtener la imagen, por favor volve a intentarlo")
            else:
                enviar(telefonoCliente, 
                       "Hubo un error al obtener la imagen, por favor volve a intentarlo")
        else:
            enviar(telefonoCliente, 
                   "El sistema solo acepta imágenes de plantas de mango" +
                   ", por favor enviar una imagen a evaluar")
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
