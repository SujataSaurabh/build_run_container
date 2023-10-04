FROM python-base-with-libaries
ARG queue_consumer_dir=/apps/libdir/dirname/consumer_dir
RUN mkdir -p $queue_consumer_dir
WORKDIR $queue_consumer_dir
COPY rabbitmq_consumer.py $queue_consumer_dir

ENTRYPOINT ["python3", "rabbitmq_consumer.py"]

