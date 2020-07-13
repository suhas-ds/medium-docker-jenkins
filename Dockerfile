FROM frolvlad/alpine-python-machinelearning:latest
RUN pip3 install --upgrade pip

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN apk add --no-cache --virtual .build-deps gcc musl-dev python3-dev\
  && pip3 install cython \
  && pip3 install --no-cache-dir -r requirements.txt \
  && apk del .build-deps gcc musl-dev


COPY . /app

CMD python /app/model.py && python /app/server.py
