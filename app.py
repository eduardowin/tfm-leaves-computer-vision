
from io import BytesIO
from typing import Awaitable
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
import httpx
from flask_cors import CORS
from flask import Flask, render_template, request,jsonify

from math import expm1
import joblib
import pandas as pd
from tensorflow import keras

app = Flask(__name__, static_folder='static')
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

from heyoo import WhatsApp

SECRET_KEY = 'aKLMSLK3I4JNESOLUTIONSKJN545N4J5N4J54H4G44H5JBSSDBNF3453S2223KJNF'

@app.route('/')
def index():
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
    #EXTRAEMOS EL NUMERO DE TELEFONO Y EL MANSAJE
    telefonoCliente=data['entry'][0]['changes'][0]['value']['messages'][0]['from']
    #EXTRAEMOS EL TELEFONO DEL CLIENTE
    mensaje=data['entry'][0]['changes'][0]['value']['messages'][0]['text']['body']
    #EXTRAEMOS EL ID DE WHATSAPP DEL ARRAY
    idWA=data['entry'][0]['changes'][0]['value']['messages'][0]['id']
    #EXTRAEMOS EL TIEMPO DE WHATSAPP DEL ARRAY
    timestamp=data['entry'][0]['changes'][0]['value']['messages'][0]['timestamp']
    #ESCRIBIMOS EL NUMERO DE TELEFONO Y EL MENSAJE EN EL ARCHIVO TEXTO
    #SI HAY UN MENSAJE
    respuesta=""

    respuesta=respuesta.replace("\\n","\\\n")
    respuesta=respuesta.replace("\\","")

    # enviar(telefonoCliente,respuesta)
    #RETORNAMOS EL STATUS EN UN JSON
    print('telefonoCliente')
    print(telefonoCliente)
    print('timestamp')
    print(timestamp)
    print('mensaje')
    print(mensaje)
    return jsonify({"status": "success"}, 200)

def enviar(telefonoRecibe,respuesta):
  #TOKEN DE ACCESO DE FACEBOOK
  token = 'EAALDlRZBLBD4BAGIFXLcPuwwgkXMZAnCOAuvPTXRBPbi4tKavrq9PmCFuWfMvmoBHkjeKghBQhs0AExdK3Ru5NCXfWsDaIvUuVAZBDLNtKmom0pwSkA9LhUJMYrLVYTLhlWPPjg9iRuOBSpKKr7oExDHwC385UxJZCwFH2qxadMfqKQDAMMngReZBNvyJ3rLFmiOVB6xZBrwZDZD'
  #IDENTIFICADOR DE NÚMERO DE TELÉFONO
  idNumeroTeléfono = '116907067953774'
  #INICIALIZAMOS ENVIO DE MENSAJES
  mensajeWa = WhatsApp(token,idNumeroTeléfono)
  telefonoRecibe = telefonoRecibe.replace("521","52")
  #ENVIAMOS UN MENSAJE DE TEXTO
  mensajeWa.send_message(respuesta,telefonoRecibe)

# if __name__ == '__main__':
#     port = int(os.environ.get('PORT', 5000))
#     app.run(debug=True, host='0.0.0.0', port=port)
