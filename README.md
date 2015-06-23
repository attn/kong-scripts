# Kong Scripts

# Summary

Shell scripts for setting up Kong.

# Description

These scripts autmoate the process of building Kong and Cassandra, Kong's
database dependency, in Docker containers. Both the Kong config and Cassandra's
file system are mounted on the host using Docker's Data Volumes.

There is both a setup and a teardown script. The teardown script is mostly used
for debugging purposes. It does not provide any error handling.

These scripts assume a single Kong instance is being created. Scaling out either
the Kong containers or the Cassandra containers still must be done manually.

# Logging

Inside is set of three helper functions that will log output to the console for
you as well as pass error codes upon success or failure.

# Issues
The Kong container often fails to connect to the Cassandra container. It looks
like Cassandra is not finished setting up before Kong makes its initial
connection attempt.

After the script runs make sure the Kong container is connected by running
`docker start kong`. To view the logs of the Kong container run `docker logs
kong`.
