# FX Lessons - Three.js Visual Effects Collection

A collection of Three.js visual effects lessons and demonstrations.

## 📁 Project Structure

```
fx_lessons/
└── ambient_occlusion/
    ├── index.html          # Three.js Ambient Occlusion Scene
    ├── README.md          # Detailed documentation
    ├── package.json       # Dependencies
    └── .vscode/          # VS Code configuration
```

## 🎮 Available Lessons

### [Ambient Occlusion](/fx_lessons/ambient_occlusion/)
- **Interactive 3D scene** with SSAO (Screen Space Ambient Occlusion)
- **Particle wave system** with 1200 animated particles
- **Multiple input methods** (keyboard, mouse, gamepad, tablet)
- **Real-time lighting effects** and post-processing

## 🚀 Quick Start

### Option 1: Docker (Recommended)
```bash
# Build and run with Docker Compose
docker-compose up --build

# Access at http://localhost:8080
```

### Option 2: Direct Docker
```bash
# Build the image
docker build -t fx-lessons .

# Run the container
docker run -p 8080:80 fx-lessons

# Access at http://localhost:8080
```

### Option 3: Local Development
```bash
# Navigate to specific lesson
cd fx_lessons/ambient_occlusion/

# Start live server
live-server --port=5500 --entry-file=index.html

# Access at http://localhost:5500
```

## 🐳 Docker Commands

```bash
# Build image
docker build -t fx-lessons .

# Run container
docker run -d -p 8080:80 --name fx-lessons fx-lessons

# Stop container
docker stop fx-lessons

# Remove container
docker rm fx-lessons

# View logs
docker logs fx-lessons
```

## 📦 Docker Compose Commands

```bash
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# Rebuild and start
docker-compose up --build

# View logs
docker-compose logs
```

## 🔗 Navigation

- **Root**: This page
- **Ambient Occlusion**: `/fx_lessons/ambient_occlusion/`
- **Direct Scene**: `/fx_lessons/ambient_occlusion/index.html`

## 🛠️ Development

### Adding New Lessons
1. Create new directory in `fx_lessons/`
2. Add your Three.js scene files
3. Update this README with lesson description
4. Commit and push to repository

### Local Development
```bash
# Clone repository
git clone <repository-url>
cd fx_lessons

# Install dependencies (if needed)
npm install

# Start development server
npm run dev
```

## 📄 License

MIT License - Feel free to use, modify, and distribute.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add your lesson or improvements
4. Test thoroughly
5. Submit a pull request

---

**Explore the visual effects lessons!** 🎨✨ 