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
