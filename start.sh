#!/bin/bash

# FX Lessons - Startup Script
# This script provides multiple ways to run the project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}🎨 FX Lessons - Startup Script${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a port is in use
port_in_use() {
    netstat -tlnp 2>/dev/null | grep ":$1 " >/dev/null 2>&1
}

# Function to kill process on port
kill_port() {
    if port_in_use $1; then
        print_warning "Port $1 is in use. Attempting to kill existing process..."
        sudo fuser -k $1/tcp 2>/dev/null || true
        sleep 2
    fi
}

# Function to start live-server
start_live_server() {
    local port=$1
    local directory=$2
    
    print_status "Starting live-server on port $port from directory: $directory"
    
    if ! command_exists live-server; then
        print_error "live-server not found. Installing..."
        npm install -g live-server
    fi
    
    kill_port $port
    
    cd "$directory"
    live-server --port=$port --entry-file=index.html --no-browser &
    local pid=$!
    echo $pid > .live-server-$port.pid
    
    print_status "Live server started with PID: $pid"
    print_status "Access at: http://localhost:$port"
}

# Function to start Docker
start_docker() {
    print_status "Starting Docker container..."
    
    if ! command_exists docker; then
        print_error "Docker not found. Please install Docker first."
        exit 1
    fi
    
    if ! command_exists docker-compose; then
        print_error "Docker Compose not found. Please install Docker Compose first."
        exit 1
    fi
    
    docker-compose up -d
    print_status "Docker container started"
    print_status "Access at: http://localhost:8081"
}

# Function to stop all services
stop_all() {
    print_status "Stopping all services..."
    
    # Kill live-server processes
    for pid_file in .live-server-*.pid; do
        if [ -f "$pid_file" ]; then
            pid=$(cat "$pid_file")
            kill $pid 2>/dev/null || true
            rm "$pid_file"
        fi
    done
    
    # Stop Docker
    docker-compose down 2>/dev/null || true
    
    print_status "All services stopped"
}

# Function to show status
show_status() {
    print_status "Project Status:"
    echo "  📁 Root directory: $(pwd)"
    echo "  📄 Root index.html: $([ -f "index.html" ] && echo "✅" || echo "❌")"
    echo "  📁 Lesson directory: $([ -d "fx_lessons/ambient_occlusion" ] && echo "✅" || echo "❌")"
    echo "  📄 Lesson index.html: $([ -f "fx_lessons/ambient_occlusion/index.html" ] && echo "✅" || echo "❌")"
    echo "  🐳 Docker: $(command_exists docker && echo "✅" || echo "❌")"
    echo "  📦 Node.js: $(command_exists node && echo "✅" || echo "❌")"
    echo "  🌐 Live-server: $(command_exists live-server && echo "✅" || echo "❌")"
    
    echo ""
    print_status "Port Status:"
    echo "  Port 5500: $(port_in_use 5500 && echo "🟢 In Use" || echo "🔴 Available")"
    echo "  Port 5501: $(port_in_use 5501 && echo "🟢 In Use" || echo "🔴 Available")"
    echo "  Port 8081: $(port_in_use 8081 && echo "🟢 In Use" || echo "🔴 Available")"
}

# Main script logic
main() {
    print_header
    
    case "${1:-help}" in
        "root"|"start")
            print_status "Starting root server..."
            start_live_server 5500 .
            ;;
        "lesson"|"dev")
            print_status "Starting lesson server..."
            start_live_server 5501 fx_lessons/ambient_occlusion
            ;;
        "docker")
            start_docker
            ;;
        "all")
            print_status "Starting all services..."
            start_live_server 5500 .
            start_live_server 5501 fx_lessons/ambient_occlusion
            start_docker
            ;;
        "stop")
            stop_all
            ;;
        "status")
            show_status
            ;;
        "install")
            print_status "Installing dependencies..."
            npm install
            ;;
        "clean")
            print_status "Cleaning up..."
            stop_all
            rm -rf node_modules package-lock.json
            print_status "Cleanup complete"
            ;;
        "help"|*)
            echo "Usage: $0 [command]"
            echo ""
            echo "Commands:"
            echo "  start, root    - Start root server on port 5500"
            echo "  lesson, dev    - Start lesson server on port 5501"
            echo "  docker         - Start Docker container on port 8081"
            echo "  all            - Start all services"
            echo "  stop           - Stop all services"
            echo "  status         - Show project status"
            echo "  install        - Install dependencies"
            echo "  clean          - Clean up and stop all services"
            echo "  help           - Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 start       # Start root server"
            echo "  $0 lesson      # Start lesson server"
            echo "  $0 all         # Start everything"
            echo "  $0 stop        # Stop everything"
            ;;
    esac
}

# Trap to clean up on exit
trap 'print_status "Shutting down..."; stop_all' EXIT

# Run main function
main "$@" 