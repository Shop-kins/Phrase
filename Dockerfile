FROM python:3.9.18-alpine3.18
RUN mkdir application
COPY ./application ./application
RUN pip install -r ./application/requirements.txt
EXPOSE 5000 6379
CMD ["python" , "./application/app.py"]