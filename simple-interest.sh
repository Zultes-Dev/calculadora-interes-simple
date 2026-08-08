#!/usr/bin/env bash
#
# simple-interest.sh
# Calculadora de interés simple basada en la entrada del usuario.
#
# Fórmula:  I = (P * R * T) / 100
#
#   P = capital (principal)   | moneda
#   R = tasa de interés anual | porcentaje
#   T = período de tiempo     | años
#
# Autor: Zultes-Dev
# Licencia: Apache License 2.0
#
set -euo pipefail

# --- Función de validación de entrada (número decimal >= 0) ---------------
valid_number() {
  [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]]
}

read_number() {
  local prompt="$1" value
  while true; do
    read -r -p "$prompt" value
    if valid_number "$value" && [[ "$value" != "0" ]]; then
      echo "$value"
      return 0
    fi
    echo "Entrada inválida: ingrese un número decimal mayor que 0." >&2
  done
}

# --- Entrada de datos -------------------------------------------------------
p=$(read_number "Ingrese el capital (P): ")
r=$(read_number "Ingrese la tasa de interés anual (R) en %: ")
t=$(read_number "Ingrese el período de tiempo en años (T): ")

# --- Cálculo del interés simple ----------------------------------------------
si=$(awk -v p="$p" -v r="$r" -v t="$t" 'BEGIN { printf "%.2f", p * t * r / 100 }')

# --- Salida -------------------------------------------------------------------
echo "Capital  (P):      $p"
echo "Tasa     (R):      $r%"
echo "Tiempo   (T):      $t año(s)"
echo "-------------------------------------"
echo "Interés simple (I): $si"