# Estágio de construção
FROM cgr.dev/chainguard/python:latest-dev AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Estágio final
FROM cgr.dev/chainguard/python:latest
WORKDIR /app
COPY --from=builder /app /app
COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages
ENV PATH="/home/nonroot/.local/lib/python3.12/site-packages:$PATH"
EXPOSE 5000
ENTRYPOINT [ "python", "-m", "flask", "run", "--host=0.0.0.0" ]
