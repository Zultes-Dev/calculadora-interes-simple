# Contributing Guide

Thank you for your interest in contributing to **Simple Interest Calculator**!

**We accept all contributions:** bug reports, bug fixes, documentation improvements, enhancements, and ideas.

---

## How to contribute?

All contributions are welcome, regardless of size. The most common ways to participate are:

- **Bug reports**: report issues with a clear, reproducible problem description.
- **Bug fixes**: submit a Pull Request that fixes a reported or known bug.
- **Documentation improvements**: correct, expand, or clarify the README, code comments, and guides.
- **Enhancements**: implement a new capability (rate conversion, history, etc.).
- **Ideas**: propose new features, usability improvements, or changes to the user experience.

## Reporting a bug

Before opening an issue:

1. Search for the issue to see if it has already been reported.
2. Include the **Python version**, the **operating system**, and the steps to **reproduce** the problem.
3. Include the expected result and the actual result.

## Contribution workflow (code)

1. Fork the repository.
2. Create a branch with a descriptive name:

   ```bash
   git checkout -b fix/123-interest-error
   ```

3. Write or update **tests** for your change in `tests/`.
4. Run the quality checks before submitting:

   ```bash
   ruff check .
   ruff format .
   pytest -v
   ```

5. Submit a **Pull Request** to the `main` branch describing the change.

> Remember that all contributions are subject to the [Code_of_Conduct](CODE_OF_CONDUCT.md).

## Coding standards

- Keep the **domain logic** (financial calculations) decoupled from the graphical interface.
- Variable and function names in **English**; user messages in **Spanish**.
- Docstrings following **PEP 257** and code compliant with the **ruff** rules.
- Keep the history clean: one logical change per commit.

## Reviewing contributions

The maintainer will review your contribution and may request adjustments. Review is part of the process: be open to feedback and friendly when responding.

Thank you for helping this project grow!