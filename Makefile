createdb:
	docker exec -it local_postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it local_postgres dropdb simple_bank

postgres:
	docker run --name local_postgres --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password -d postgres

migrateup:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test: 
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -destination=./db/mock/store.go -package=mockdb  github.com/mikhelbriones/simplebank/db/sqlc Store

.PHONY: createdb postgres dropdb sqlc test migrateup migratedown server mock migratedown1 migrateup1