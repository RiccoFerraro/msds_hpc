# run with `DOCKER_BUILDKIT=0 docker build -f  assignment_04.dockerfile .` from the /assignments directory 

FROM alpine:3.14

RUN apk --no-cache add curl
RUN apk add --no-cache bash

RUN mkdir assignments

COPY ./assignment_04.sh ./assignments/assignment_04.sh

RUN echo "$(ls -lh)"

RUN ./assignments/assignment_04.sh