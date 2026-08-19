FROM python:3.12.13-alpine3.23

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN addgroup --system appgroup && \
    adduser --system --ingroup appgroup appuser

COPY --chown=appuser:appgroup app/ .

ENV PYTHONDONTWRITEBYTECODE=1

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]