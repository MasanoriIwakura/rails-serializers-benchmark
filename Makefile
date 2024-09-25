setup:
	@docker compose down -v
	@docker compose build
	@docker compose run --rm api bundle exec rails db:reset
	@docker compose run --rm api bundle exec rails db:migrate
	@docker compose run --rm api bundle exec rails db:seed

up:
	@docker compose up -d api

exec:
	@docker compose exec api bash

run:
	@docker compose exec api rake benchmark:all

down:
	@docker compose down
