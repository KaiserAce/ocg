run:
	docker compose -f compose.local.yaml --env-file .env up --build aguhon-database -d
	npm run dev 

reset-local:
	docker compose -f compose.local.yaml down
	docker volume prune 
	docker volume rm aguhon-dev_mongodb

reset-prod:
	docker compose -f compose.production.yaml down 
	docker volume prune 
	docker volume rm aguhon-prod_mongodb

build:
	docker compose -f compose.local.yaml --env-file .env up --build -d

build-prod:
	docker compose -f compose.production.yaml --env-file .env up --build -d
