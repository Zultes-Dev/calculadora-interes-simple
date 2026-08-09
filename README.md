# Calculadora de Interés Simple

Aplicación de escritorio desarrollada en **Python** con interfaz gráfica (**GUI**) para el cálculo de **interés simple**, **monto final**, **capital**, **tiempo** y **tasa**, además de conversión de tasas (anual, mensual, diaria) y cálculo de **interés compuesto**.

> Proyecto final — Ingeniería de Software / Cálculo Financiero

---

## Índice

- [Descripción del Proyecto](#descripción-del-proyecto)
- [Características](#características)
- [Stack Tecnológico](#stack-tecnológico)
- [Fórmulas Financieras Implementadas](#fórmulas-financieras-implementadas)
- [Arquitectura del Proyecto](#arquitectura-del-proyecto)
- [Estructura de Directorios](#estructura-de-directorios)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Uso (Guía de Usuario)](#uso-guía-de-usuario)
- [Lógica de Negocio y API Interna](#lógica-de-negocio-y-api-interna)
- [Manejo de Errores](#manejo-de-errores)
- [Pruebas](#pruebas)
- [Calidad de Código y Estándares](#calidad-de-código-y-estándares)
- [Integración Continua (CI)](#integración-continua-ci)
- [Seguridad](#seguridad)
- [Rendimiento](#rendimiento)
- [Roadmap](#roadmap)
- [Cómo Contribuir](#cómo-contribuir)
- [Licencia](#licencia)
- [Autores y Contacto](#autores-y-contacto)

---

## Descripción del Proyecto

La **Calculadora de Interés Simple** es una aplicación de escritorio que permite al usuario resolver problemas financieros de interés simple y compuesto de forma rápida y confiable. Incluye un **historial de cálculos persistente** y **conversión de tasas de interés** para garantizar la consistencia entre periodos (año comercial de 360 días y año civil de 365 días).

El proyecto separa estrictamente la **lógica financiera** (capa de dominio, sin dependencias gráficas) de la **interfaz de usuario**, lo que permite:

- **Verificación unitaria** completa de los cálculos.
- **Reutilización de la lógica** desde CLI, API o scripts externos.
- **Mantenibilidad** y escalabilidad a largo plazo.

---

## Características

| ID | Característica | Descripción |
|----|----------------|-------------|
| F-01 | **Cálculo de Interés Simple (I)** | `I = P × r × t` |
| F-02 | **Cálculo de Monto (A)** | `A = P + I` (Valor Futuro) |
| F-03 | **Despeje de Capital (P)** | Dado interés/monto, tasa y tiempo |
| F-04 | **Despeje de Tasa (r)** | Dado interés, capital y tiempo |
| F-05 | **Despeje de Tiempo (t)** | Dado interés, capital y tasa |
| F-06 | **Interés Compuesto** | `A = P × (1 + r)^t` |
| F-07 | **Conversión de Tasas** | Anual → Mensual → Diaria (360/365) |
| F-08 | **Modo capitalizable año** | 360 días (comercial) / 365 días (exacto) |
| F-09 | **Historial de Cálculos** | Guarda y exporta operaciones realizadas |
| F-10 | **Interfaz Gráfica (GUI)** | Tkinter, navegable, con validaciones en vivo |

---

## Stack Tecnológico

| Capa | Tecnología | Justificación |
|------|------------|---------------|
| Lenguaje | **Python 3.10+** | Estándar, legible, multiplataforma |
| GUI | **Tkinter** (`ttk`) | Biblioteca estándar, sin dependencias externas |
| Persistencia | **JSON** (módulo `historial.py`) | Simplicidad y portabilidad del historial |
| Pruebas | **pytest** + **unittest** | Cubrimiento de la lógica financiera |
| Linting/Formato | **ruff + black** | Calidad de código uniforme |
| Tipado | `typing` + `mypy` (opcional) | Prevención de errores temprana |

> **Decisión de arquitectura:** utilizar exclusivamente librerías estándar de Python para la GUI y persistencia garantiza que el proyecto **funcione en cualquier máquina sin instalar dependencias de terceros**, lo cual es ideal para un proyecto de evaluación/entrega educativa.

---

## Fórmulas Financieras Implementadas

### Interés Simple

- **Interés:** `I = P × r × t`
- **Monto:** `A = P + I = P × (1 + r × t)`
- **Capital:** `P = I / (r × t)`
- **Tasa:** `r = I / (P × t)`
- **Tiempo:** `t = I / (P × r)`

Donde:

- `P` = Capital principal (saldo inicial) — moneda (`CLP`, `USD`, etc.)
- `r` = Tasa de interés en **término decimal** (ej. `0.05` = 5%)
- `t` = Tiempo en **el periodo de la tasa** (años si la tasa es anual)

### Conversión de Tasas

| De | A | Fórmula |
|----|----|---------|
| Tasa anual `i_a` | Mensual | `i_m = i_a / 12` |
| Tasa anual `i_a` | Diaria (360) | `i_d = i_a / 360` |
| Tasa anual `i_a` | Diaria (365) | `i_d = i_a / 365` |
| Tasa mensual `i_m` | Anual | `i_a = i_m × 12` |
| Tasa mensual | Diaria | `i_d = i_m / 30` |
| Tasa diaria | Anual | `i_a = i_d × 365 (base)` |

> ⚠️ La **base de días** configurable (360 => comercial, 365 => exacto/civil) es a raíz de una decisión de negocio **explícita para cada cálculo**.

### Interés Compuesto (modo avanzado)

- **Monto compuesto:** `A = P × (1 + r)^t`
- **Interés compuesto:** `I = A − P`
- **Frecuencia de capitalización:** anual `m = 1`, mensual `m = 12`, etc.
  `A = P × (1 + r/m)^(m×t)`

### Casos límite y convenciones

- `P`, `r`, `t` **deben ser ≥ 0**. No existen capitales, tasas ni periodos negativos.
- Divisiones por cero devuelven un error controlado `ZeroDivisionError` traducido a mensaje de usuario.
- Resultados monetarios se redondean a **2 decimales** por defecto (configurable vía `settings`).
- Los cálculos se realizan con `decimal.Decimal` (o `float` según config) para evitar errores de punto flotante en operaciones monetarias.

---

## Arquitectura del Proyecto

El proyecto sigue una arquitectura **de capas (arquitecture limpia simplificada)**:

```
┌─────────────────────────────┐
│   Presentación / GUI        │   capa de interfaz
│   (tkinter views, controllers)
├─────────────────────────────┤
│   Aplicación                │   casos de uso: orquestar
│   (Servicio Calculadora)    │   la lógica + historial
├─────────────────────────────┤
│   Núcleo del Dominio        │   fórmulas puras/calculos
│   (finance.py)              │   sin dependencias gráficas
├─────────────────────────────┤
│   Infraestructura           │   persistencia historial, JSON
│   (storage.py)              │
└─────────────────────────────┘
```

**Principios de diseño aplicados:**

- **Separación de responsabilidades**: el cálculo financiero es 100% testeable y aislado de la GUI.
- **SOLID**: módulos pequeños, interfaces por contexto (`FinanceCalculator`, `HistoryStore`, `Settings`).
- **Programación a interfaces** (“loose coupling”): la GUI depende de la interfaz `Calculator`, no de una implementación concreta.
- **Sin acoplamiento a framework**: la lógica de negocio no importa a Tkinter ni a ninguna librería externa de UI.
- **Configuración centralizada**: parámetros como la base de días y la moneda se definen una sola vez (module `settings`).

---

## Estructura de Directorios

```
proyecto-final-git/
├── README.md
├── requirements.txt            # pytest, ruff (dev)
├── pyproject.toml              # configuración de tooling (ruff, black, pytest, mypy)
├── .gitignore
├── src/                        # código fuente de la aplicación
│   ├── __init__.py
│   ├── main.py                 # punto de entrada: arranca la GUI (tk.Tk)
│   ├── calc/
│   │   ├── __init__.py
│   │   ├── finance.py          # fórmulas financieras (lógica pura)
│   │   ├── validator.py        # validaciones de entrada
│   │   └── converter.py        # conversión de tasas de interés
│   ├── core/
│   │   ├── __init__.py
│   │   ├── service.py          # orquestación de casos de uso
│   │   └── repository.py       # interfaz de persistencia (abstract)
│   ├── storage/
│   │   ├── __init__.py
│   │   └── sqlite_store.py     # historial en SQLite (fácil exportar)
│   ├── ui/
│   │   ├── __init__.py
│   │   ├── app.py              # ventana principal (tk.Tk)
│   │   ├── views.py            # tabs: Simple / Compuesto / Conversión
│   │   ├── widgets.py          # componentes reutilizables (Spinbox,mensajes)
│   │   └── history_panel.py    # vista del historial de operaciones
│   └── config/
│       ├── __init__.py
│       └── settings.py         # constantes: base de días, moneda, redondeo
└── tests/
    ├── __init__.py
    ├── test_finance.py         # casos de la capa de cálculo
    ├── test_convert.py         # conversión de tasas
    ├── test_validator.py       # validación de entradas
    └── test_history.py         # almacenamiento/recuperación
```

---

## Requisitos Previos

- **Windows / macOS / Linux**
- **Python 3.10 o superior** (verificar con `python --version`)
- (Opcional) `pip` para instalar dependencias de desarrollo
- Sin dependencias en runtime (la app usa la biblioteca estándar)

---

## Instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/Zultes-Dev/github-final-project.git
cd "github-final-project"

# 2. (Opcional) Crear y activar un entorno virtual
python -m venv .venv
# Windows:
.\.venv\Scripts\activate
# Linux/macOS:
source .venv/bin/activate

# 3. Instalar dependencias de desarrollo
pip install -r requirements.txt

# 4. Ejecutar la aplicación
python -m src.main
```

---

## Uso (Guía de Usuario)

1. **Iniciar la aplicación**: ejecuta `python -m src.main`.
2. En el panel **"Interés Simple"**, ingresa:
   - `Capital (P)`: monto inicial.
   - `Tasa (r)`: en porcentaje (p.ej. `5` para 5%).
   - `Tiempo (t)`: número de periodos (años, meses o días) según selector.
   - Base de días: **360 (comercial)** o **365 (exacto)**.
3. Pulsa **Calcular**. El resultado muestra `Interés (I)` y `Monto (A)`.
4. En **Conversión de tasas** ingresa una tasa y su base, y selecciona la salida deseada.
5. En **Historial** se listan todas las operaciones guardadas con fecha/hora; puedes **exportar a CSV** y **borrar historial**.

> Los resultados con valores financieros negativos o divisiones por cero se muestran como mensajes de error no excepcionales, nunca se bloquea la interfaz.

---

## Lógica de Negocio y API Interna

La capa de dominio expone la siguiente API (independiente de la GUI):

```python
# src/calc/finance.py
def interest_simple(P: float, r: float, t: float) -> float:
    """Retorna el interés simple I = P * r * t."""

def amount_simple(P: float, r: float, t: float) -> float:
    """Retorna el monto A = P + I."""

def principal_from_amount(A: float, r: float, t: float) -> float:
def rate_from_interest(I: float, P: float, t: float) -> float:
def time_from_interest(I: float, P: float, r: float) -> float:
def interest_compound(P: float, r: float, t: float, m: int = 1) -> float:
def compound_amount(P: float, r: float, t: float, m: int = 1) -> float:
```

```python
# src/calc/converter.py
def to_annual(rate: float, base: str) -> float:
def monthly_to_annual(m: float) -> float:
def annual_to_daily(a: float, base: int = 360) -> float:
def convert_rate(rate: float, from_base: str, to_base: str, year_base: int) -> float:
```

Todos los módulos `calc` **no importan Tkinter** → 100% ejecutable en terminal para automatizar pruebas de serie oro.

---

## Manejo de Errores

| Escenario | Nivel | Acción |
|-----------|-------|--------|
| Entrada no numérica | Validación | `ValidationError` → mensaje en el campo |
| `t=0` en despeje de tasa/tasa | Dominio | Elevar `InvalidInputError` con mensaje en español |
| `P=0` / `r=0` | Dominio | `InvalidInputError` según CDU |
| Valores negativos | Dominio | Normalizado a `abs` + advertencia, o bloqueo (configurable) |
| Archivo de historial no exista | Storage | Crear DB/vacía silenciosamente |
| Error de redondeo | Monetario | `decimal.Decimal` en modo 2 decimales |
| CPU sin Tk instalado | Runtime | Catch + mensaje de instalación |

Todas las excepciones del núcleo se **re-etiquetan** como `AppError` en la capa de servicio, y la UI las presenta como diálogos no críticos.

---

## Pruebas

```bash
# Ejecutar toda la suite
pytest -v

# Pruebas con cobertura
pytest --cov=src --cov-report=html

# Ejecutar un solo archivo
pytest tests/test_interest.py -v
```

Técnicas aplicadas:

- **Table-driven tests** (parametrización con `@pytest.mark.parametrize`).
- **Tests de fronteras**: `0`, negativos, muy grandes.
- **Tests de casos conocidos** (por ejemplo: P=1000, r=0.05, t=3 → I=150).
- **Tests con fixtures** para el historial con `tmp_path` o un `sqlite :memory:`.
- **Ajuste de redondeo** para verificar precisión financiera.

---

## Calidad de Código y Estándares

Herramientas recomendadas configuradas en `pyproject.toml`:

```bash
ruff check .            # linter (bugs + estilo)
ruff format .           # formato automático
black --check .         # formateador alternativo
mypy src/               # chequeo de tipos (opcional)
```

Convenciones:

- **Nombres en inglés** para código-fuente; **UI en español** para el usuario final.
- **Docstrings** en español conforme PEP 257.
- Máximo ~**88 columnas** (line-wrap).
- Uso de `Decimal` para montos monetarios cuando se requiera exactitud.
- Commit messages con convención **Conventional Commits** (`feat:`, `fix:`, `docs:`).
- `pre-commit` con hooks de `ruff` + `black` + `mypy` (opcional).

---

## CI/CD

La integración continua se encarga de validar calidad, pruebas y empaquetado en cada push/PR.

| Stage | Herramienta | Comandos |
|-------|-------------|----------|
| Lint | GitHub Actions | `ruff check .` |
| Format | `ruff format --check .` | `ruff format --check .` |
| Unit tests | `pytest` | `pytest -v` |
| Coverage | `pytest --cov` | Umbral mínimo 80 % |
| Build (Windows) | `PyInstaller --onefile` | Plataforma específica |

> Los builds con PyInstaller generan un ejecutable `.exe` para Windows, listo para distribuir sin Python instalado.

---

## Seguridad

- **Almacenamiento local**: el historial se guarda localmente (`history.db` / `data/history.json`), nunca se envía a red.
- **Validación de entradas**: sanitizadas y tipadas en la entrada al dominio.
- **Sin credenciales** en el repositorio (`.gitignore` excluye `*.env`, base de datos y builds).
- **Sin dependencias de terceros críticas** → mínima superficie de ataque (sólo estándar).
- El código no refleja captura en logs: no se loguean datos personales, solo operaciones.

---

## Rendimiento

- Los cálculos son **instantáneos** (complejidad O(1)); no hay I/O en la ruta crítica.
- El historial se persiste en **lotes** (solo al agregar o eliminar), evitando escrituras en cada tecla.
- Se ejecuta el render **lazy** de tablas de historial (paginación en `ttk.Treeview` para más de 1000 filas).
- Se reutilizan las constantes de redondeo vía `settings`.

---

## Roadmap

- [x] Núcleo financiero (interés simple, monto, compuesto)
- [x] Conversión de tasas (360/365)
- [x] Interfaz gráfica Tkinter
- [x] Historial persistente y exportación CSV
- [ ] Gráfico comparación simple vs compuesto (`matplotlib`)
- [ ] Soporte de múltiples monedas con tipo de cambio
- [ ] Empaquetado `.exe` con PyInstaller
- [ ] i18n (English/Español)

---

## Cómo Contribuir

1. Realiza un `fork` del proyecto.
2. Crea una rama: `git checkout -b feat/nueva-funcionalidad`.
3. Escribe tests para tu cambio.
4. Ejecuta `ruff check` y `pytest` localmente.
5. Envía un **Pull Request** describiendo el cambio con el template del repo.

Todas las contribuciones están sujetas al [Código de Conducta](CODE_OF_CONDUCT.md).

---

## Licencia

**Apache License 2.0** — ver archivo [`LICENSE`](LICENSE). Libre de uso educativo y comercial, con los términos habituales de Apache para patentes, marcas y garantías.

---

## Autores y Contacto

- **Autor principal:** Zultes-Dev
- **Curso / materia:** Proyecto Final — Ingeniería, Cálculo Financiero
- **Repositorio:** https://github.com/Zultes-Dev/github-final-project
- **Correo:** (completar)
- **Docentes / revisores:** (completar)

© 2026 — Proyecto final de software. Todos los derechos reservados.