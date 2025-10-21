# Build (override user/pass if you like)
docker build -t rocky8-ansible:8.10 \
  --build-arg USERNAME=appuser \
  --build-arg PASSWORD='Admin@123' .

