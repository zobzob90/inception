.PHONY: all build up down start stop restart clean fclean re logs ps

# Variables
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/ertrigna/data

# Colors for pretty output
GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
NC = \033[0m # No Color

all: build up

# Create data directories
setup:
	@echo "$(YELLOW)Creating data directories...$(NC)"
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	@echo "$(GREEN)✓ Data directories created$(NC)"

# Build all containers
build: setup
	@echo "$(YELLOW)Building Docker containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) build
	@echo "$(GREEN)✓ Build complete$(NC)"

# Build and start containers in detached mode
up: setup
	@echo "$(YELLOW)Starting containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) up -d
	@echo "$(GREEN)✓ Containers are running$(NC)"

# Stop and remove containers
down:
	@echo "$(YELLOW)Stopping containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)✓ Containers stopped$(NC)"

# Start existing containers
start:
	@echo "$(YELLOW)Starting containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) start
	@echo "$(GREEN)✓ Containers started$(NC)"

# Stop running containers
stop:
	@echo "$(YELLOW)Stopping containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) stop
	@echo "$(GREEN)✓ Containers stopped$(NC)"

# Restart containers
restart:
	@echo "$(YELLOW)Restarting containers...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) restart
	@echo "$(GREEN)✓ Containers restarted$(NC)"

# View logs
logs:
	@docker-compose -f $(COMPOSE_FILE) logs -f

# Show running containers
ps:
	@docker-compose -f $(COMPOSE_FILE) ps

# Clean containers and images
clean: down
	@echo "$(YELLOW)Removing containers and images...$(NC)"
	@docker system prune -af
	@echo "$(GREEN)✓ Cleanup complete$(NC)"

# Full clean including volumes
fclean: down
	@echo "$(RED)Removing everything (containers, images, volumes, data)...$(NC)"
	@docker-compose -f $(COMPOSE_FILE) down -v
	@docker system prune -af --volumes
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@echo "$(GREEN)✓ Full cleanup complete$(NC)"

# Rebuild everything from scratch
re: fclean all

# Help
help:
	@echo "$(GREEN)Available targets:$(NC)"
	@echo "  $(YELLOW)make all$(NC)      - Build and start all containers"
	@echo "  $(YELLOW)make build$(NC)    - Build Docker images"
	@echo "  $(YELLOW)make up$(NC)       - Start containers in detached mode"
	@echo "  $(YELLOW)make down$(NC)     - Stop and remove containers"
	@echo "  $(YELLOW)make start$(NC)    - Start existing containers"
	@echo "  $(YELLOW)make stop$(NC)     - Stop running containers"
	@echo "  $(YELLOW)make restart$(NC)  - Restart containers"
	@echo "  $(YELLOW)make logs$(NC)     - View container logs"
	@echo "  $(YELLOW)make ps$(NC)       - Show running containers"
	@echo "  $(YELLOW)make clean$(NC)    - Remove containers and images"
	@echo "  $(YELLOW)make fclean$(NC)   - Full cleanup (including volumes)"
	@echo "  $(YELLOW)make re$(NC)       - Rebuild everything from scratch"
	@echo "  $(YELLOW)make help$(NC)     - Show this help message"
