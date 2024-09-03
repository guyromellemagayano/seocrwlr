help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	
dev: ## Build and run local environment
	docker-compose build
	docker-compose up -d

stop: ## Stop local environment
	docker-compose stop

logs: ## Display logs for local environment
	docker-compose logs --tail=100 -f