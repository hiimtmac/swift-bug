# swift-bug

Build container `docker build -t hiimtac/swift-bug .`

Bring up memory db `docker compose up -d db`

Bring up container `docker compose up api` (need to wait till db is ready)

Make request `curl http://localhost:8080`

Bring down `docker compose down -v --remove-orphans`
