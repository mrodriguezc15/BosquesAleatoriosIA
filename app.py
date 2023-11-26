# Algoritmo_Bosques/app.py
from flask import Flask, request, jsonify
from flask_cors import CORS
from algoritmo import obtener_resultado_bosques, obtener_resultado_red_neuronal

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "*"}})

@app.route('/api/bosquesAleatorios', methods=['POST'])
def bosques_aleatorios():
    try:
        resultado = obtener_resultado_bosques()
        return jsonify({'resultado': resultado}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/redNeuronal', methods=['POST'])
def red_neuronal():
    try:
        resultado = obtener_resultado_red_neuronal()
        return jsonify({'resultado': resultado}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/prueba', methods=['GET'])
def prueba():
    return jsonify({'mensaje': '¡Conexión exitosa con Flask!'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
