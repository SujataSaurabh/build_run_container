# Build the container locally
1. initialise docker daemon
   ```
   docker init
   ```
2. build the docker image
   ```
   docker build -t consumer-rabbitmq-image . --no-cache
   ```
3. run the image with config file mounted
   ```
   docker run -v $(pwd)/configs:/apps/configdir/configs consumer-rabbitmq-image /apps/configdir/configs/credentials.ini 
   ```
4. list all the docker images
   ```
   docker images
   ```
# Build and push the docker image to docker registry locally
1. Select the base image and run it, I chose Kaniko debug as base image
   ```
   docker run -it --entrypoint /bin/sh gcr.io/kaniko-project/executor:v1.9.0-debug
   ```
2. make a .docker directory
   ```
   mkdir -p /kaniko/.docker
   ```
4. make a config file and copy following authernticating content
   ```
   > cat << EOF > /kaniko/.docker/config.json
   {
      "auths": {
        "dockerhub.registry": {
                "username":"robot_user",
               "password": "robit_token"
        }
      }
    }
   EOF
   ```
6. Make a Dcokerfile with following content
   ```
   FROM harbor.arm.gov/python-docker-sgoswami/data-reception-base:latest
   ARG rabbitmq_consumer_dir=/apps/libdir/dir/rabbitmq_consumer
   RUN mkdir -p $rabbitmq_consumer_dir
   WORKDIR $rabbitmq_consumer_dir
   COPY rabbitmq_consumer.py $rabbitmq_consumer_dir
   ENTRYPOINT ["python3", "rabbitmq_consumer.py"]
   ```
7. Build and push the image
   ```
   > /kaniko/executor --cache=true --dockerfile=Dockerfile --destination=docker.registry/docker-container-registry/consumer-rabbitmq-image:latest --context . --skip-tls-verify
   ```
