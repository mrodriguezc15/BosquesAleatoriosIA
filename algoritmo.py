# Algoritmo_Bosques/algoritmo.py
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import StandardScaler
from tqdm import tqdm
import warnings

# Configuraciones iniciales
warnings.filterwarnings("ignore")

def obtener_resultado_bosques():
    # Lógica para Bosques Aleatorios
    archivo_csv = 'diabetes.csv'  # Reemplaza con la ruta correcta
    datos = pd.read_csv(archivo_csv)

    X = datos.drop('Outcome', axis=1)
    y = datos['Outcome']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Lógica para Bosques Aleatorios
    best_rf_model = RandomForestClassifier(n_estimators=100, max_depth=10, min_samples_split=5, random_state=42)
    best_rf_model.fit(X_train_scaled, y_train)

    y_pred_test_rf = best_rf_model.predict(X_test_scaled)
    accuracy_test_rf = accuracy_score(y_test, y_pred_test_rf)

    return f'Precisión en el conjunto de prueba para Bosques Aleatorios: {accuracy_test_rf * 100:.2f}%'

def obtener_resultado_red_neuronal():
    # Lógica para Red Neuronal
    archivo_csv = 'diabetes.csv'  # Reemplaza con la ruta correcta
    datos = pd.read_csv(archivo_csv)

    X = datos.drop('Outcome', axis=1)
    y = datos['Outcome']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    mlp = MLPClassifier(hidden_layer_sizes=(100,), max_iter=1000, random_state=42)
    mlp.fit(X_train_scaled, y_train)

    y_pred_test_nn = mlp.predict(X_test_scaled)
    accuracy_test_nn = accuracy_score(y_test, y_pred_test_nn)

    return f'Precisión en el conjunto de prueba para Red Neuronal: {accuracy_test_nn * 100:.2f}%'

def validar_datos_cargados(datos_cargados_path):
    # Lógica para validar datos cargados
    datos = pd.read_csv(datos_cargados_path)  # Asegúrate de que la ruta es correcta

    X = datos.drop('Outcome', axis=1)
    y = datos['Outcome']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Validar con Bosques Aleatorios
    best_rf_model = RandomForestClassifier(n_estimators=100, max_depth=10, min_samples_split=5, random_state=42)
    best_rf_model.fit(X_train_scaled, y_train)

    y_pred_test_rf = best_rf_model.predict(X_test_scaled)
    accuracy_test_rf = accuracy_score(y_test, y_pred_test_rf)

    # Validar con Red Neuronal
    mlp = MLPClassifier(hidden_layer_sizes=(100,), max_iter=1000, random_state=42)
    mlp.fit(X_train_scaled, y_train)

    y_pred_test_nn = mlp.predict(X_test_scaled)
    accuracy_test_nn = accuracy_score(y_test, y_pred_test_nn)

    return {
        'precision_bosques_aleatorios': accuracy_test_rf,
        'precision_red_neuronal': accuracy_test_nn
    }