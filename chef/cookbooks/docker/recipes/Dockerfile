FROM python:3.9.18-alpine3.18
RUN mkdir application
COPY application ./application
WORKDIR /application
RUN pip install -r requirements.txt
EXPOSE 5000 6379
CMD ["python" , "app.py"]