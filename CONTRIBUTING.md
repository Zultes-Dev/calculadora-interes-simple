# Contributing Guide / Guía de Contribución

## Se aceptan todas las contribuciones, informes de errores, correcciones de errores, mejoras en la documentación, mejoras y ideas.

*All contributions are accepted: bug reports, bug fixes, documentation improvements, enhancements, and ideas.*

---

## How to contribute / Cómo contribuir

Todas las contribuciones son bienvenidas, sin importar el tamaño. Las formas habituales de participar son:

- **Informes de errores (bug reports)**: reporta bugs con un *issue* claro y reproducible.
- **Correcciones de errores (bug fixes)**: resuelve errores reportados o conocidos.
- **Mejoras en la documentación (documentation improvements)**: corrige, amplía o aclara el README, comentarios y guías.
- **Mejoras (enhancements)**: implementa nuevas funcionalidades.
- **Ideas**: propón nuevas características o mejoras de usabilidad.

## Reporting a bug

1. Search if the issue was already reported.
2. Include the **Python version**, the **operating system**, and the steps to **reproduce** the problem.
3. Include the expected result and the actual result.

## Contribution workflow (code)

1. Fork the repository.
2. Create a descriptive branch:

   ```bash
   git checkout -b fix/123-interest-error
   ```

3. Write or update **tests** in `tests/`.
4. Run the quality checks before submitting:

   ```bash
   ruff check .
   ruff format .
   pytest -v
   ```

5. Submit a **Pull Request** to the `main` branch describing the change.

> All contributions are subject to the [Code of Conduct](CODE_OF_CONDUCT.md).

## Coding standards

- Keep the **domain logic** (financial calculations) decoupled from the GUI.
- Variable and function names in **English**; user messages in **Spanish**.
- Docstrings following **PEP 257** and code compliant with **ruff**.
- One logical change per commit.

## Reviewing contributions

The maintainer will review your contribution and may request adjustments during the review.

¡Gracias por hacer crecer este proyecto — thank you!