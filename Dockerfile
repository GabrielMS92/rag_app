# ── Oráculo Corporativo — RAG AI ──
# Alpine conforme exigido pelo professor.
FROM python:3.12-alpine

# ── Dependências de sistema para compilar pacotes C/Rust no Alpine ──
#  - gcc g++ musl-dev          → compilação C/C++ genérica
#  - postgresql-dev libpq      → psycopg2 (não-binary, compila contra libpq)
#  - libffi-dev                → cffi (usado por cryptography)
#  - openssl-dev               → cryptography (fallback se não houver wheel)
#  - zlib-dev jpeg-dev         → Pillow
#  - cmake make linux-headers  → build genérico (pyarrow, numpy, etc.)
#  - git                       → GitPython (usa git cli)
#  - cargo                     → pacotes Rust (orjson, rpds-py, pydantic-core)
#                                se não tiver wheel musllinux pré-compilado
RUN apk add --no-cache \
    gcc g++ musl-dev \
    postgresql-dev libpq \
    libffi-dev openssl-dev \
    zlib-dev jpeg-dev \
    cmake make linux-headers \
    git \
    cargo

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8501

CMD ["streamlit", "run", "consume_api/interface_main.py", \
     "--server.port=8501", "--server.address=0.0.0.0", \
     "--server.headless=true"]
