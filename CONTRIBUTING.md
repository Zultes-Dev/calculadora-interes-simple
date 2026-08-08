# Guía de Contribución

¡Gracias por tu interés en contribuir a **Calculadora de Interés Simple**!

**Se aceptan todas las contribuciones**: informes de errores (*bug reports*), correcciones de errores (*bug fixes*), mejoras en la documentación, mejoras (*enhancements*) e ideas.

---

## ¿Cómo contribuir?

Todas las contribuciones son bienvenidas, sin importar el tamaño. Las formas más habituales de participar son:

- **Informes de errores**: reporta bugs con un *issue* claro y reproducible.
- **Correcciones de errores**: envía un *Pull Request* que solucione un bug reportado o conocido.
- **Mejoras en la documentación**: corrige, amplía o aclara el README, comentarios del código y guías.
- **Mejoras de funcionalidad**: implementa una nueva capacidad (conversión de tasas, historial, etc.).
- **Ideas**: propón nuevas características, mejoras de usabilidad o de la experiencia de usuario.

---

## Reportar un error

Antes de abrir un *issue*:

1. Busca si el problema ya fue reportado.
2. Indica la **versión de Python**, el **sistema operativo** y los pasos para **reproducir** el error.
3. Incluye el resultado esperado y el resultado obtenido.

---

## Flujo de trabajo para código

1. Realiza un `fork` del repositorio.
2. Crea una rama con un nombre descriptivo:

   ```bash
   git checkout -b fix/123-error-interes
   ```

3. Escribe o actualiza los **tests** de tu cambio en `tests/`.
4. Ejecuta las herramientas de calidad antes de enviar:

   ```bash
   ruff check .
   ruff format .
   pytest -v
   ```

5. Envía un **Pull Request** hacia la rama `main` describiendo el cambio realizado.

> Recuerda que al contribuir se aplica el [Código de Conducta](CODE_OF_CONDUCT.md).

---

## Estándares de código

- Mantén la **lógica de dominio** (cálculos financieros) desacoplada de la interfaz gráfica.
- Nombres de variables y funciones en **inglés**; mensajes de usuario en **español**.
- Docstrings según **PEP 257** y código conforme a las reglas de **ruff**.
- Mantén el historial limpio: un cambio lógico por *commit*.

---

## Revisión de contribuciones

El mantenedor revisará tu contribución y podrá solicitar ajustes. La revisión forma parte del proceso: sé abierto a los comentarios y amable al responder.

¡Gracias por hacer crecer este proyecto!
