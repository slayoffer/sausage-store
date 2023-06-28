FROM gitlab.praktikum-services.ru:5050/std-012-042/sausage-store/python:3.11.2-alpine3.17
WORKDIR /app
ADD app.py /app
ADD requirements.txt /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
EXPOSE 8080