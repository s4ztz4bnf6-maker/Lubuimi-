# SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && python -m playwright install --with-deps chromium
COPY adapters.py test_adapters.py ./
RUN python -m unittest test_adapters
RUN useradd --create-home worker
USER worker
CMD ["python","-m","unittest","test_adapters"]
