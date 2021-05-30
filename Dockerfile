FROM python:3.8-slim-buster AS BASE

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt .
RUN pip install -r requirements.txt


FROM python:3.8-slim-buster as RUN

COPY --from=BASE /opt/venv /opt/venv
ENV PATH=/opt/venv/bin:$PATH

COPY main.py main.py

#FROM ubuntu AS RUN

#RUN apt-get update && apt-get -y install curl
#RUN apt-get install uvicorn -y
#RUN apt-get install python3-pkg-resources -y

#COPY --from=BASE /opt/venv /opt/venv
#ENV PATH="$VIRTUAL_ENV/bin:$PATH"
#COPY main.py main.py

CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0"]


