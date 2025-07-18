# Three.js Fullscreen 3D Scene

An interactive 3D scene built with Three.js featuring ambient occlusion, particle effects, and multiple input methods.

## 🎮 Features

### Visual Effects
- **Ambient Occlusion (SSAO)** - Realistic lighting with crevice shadows
- **Particle Wave System** - 1200 animated particles in wave patterns
- **Wireframe Overlay** - Black wireframe that syncs with the main mesh
- **Procedural Geometry** - Displaced icosahedron with noise-based crevices
- **Post-processing Pipeline** - EffectComposer with SSAO pass

### Interactive Controls
- **Keyboard Input**
  - `WASD` - Camera movement (forward/backward/left/right)
  - `Arrow Keys` - Mesh rotation (up/down/left/right)
- **Mouse Controls**
  - Orbit camera around the scene
  - Right-click disabled for better UX
- **Gamepad Support**
  - Full Xbox Series X controller support
  - Analog stick movement and rotation
- **Touch/Tablet Support**
  - Wacom tablet pressure sensitivity
  - Touch gesture support

### Technical Features
- **Responsive Design** - Adapts to window resizing
- **Performance Optimized** - Pixel ratio limiting for high-DPI displays
- **Error Handling** - Graceful fallback to simple scene if errors occur
- **Live Reload** - Automatic browser refresh on file changes

## 🚀 Quick Start

### Option 1: Live Server (Recommended)
1. **Install Live Server extension** in VS Code/Cursor
2. **Right-click** on `index.html`
3. **Select** "Open with Live Server"
4. **Browser opens** automatically to `http://localhost:5500`

### Option 2: Command Line
```bash
# Install live-server globally
npm install -g live-server

# Navigate to project directory
cd 071825_3_1_

# Start server
live-server --port=5500 --entry-file=index.html
```

### Option 3: Python Server
```bash
# Navigate to project directory
cd 071825_3_1_

# Start Python server
python3 -m http.server 8000

# Open browser to http://localhost:8000
```

## 📁 Project Structure

```
071825_3_1_/
├── index.html          # Main HTML file with Three.js scene
├── package.json        # Project dependencies and scripts
├── README.md          # This file
└── .vscode/           # VS Code configuration
    ├── settings.json   # Live Server settings
    └── launch.json     # Debug configuration
```

## 🎯 Usage

### Basic Controls
- **Move Camera**: Use `WASD` keys or gamepad left stick
- **Rotate Mesh**: Use arrow keys or gamepad right stick
- **Orbit View**: Click and drag with mouse
- **Zoom**: Mouse wheel or gamepad triggers

### Advanced Features
- **Particle Interaction**: Particles respond to microphone input (when enabled)
- **Pressure Sensitivity**: Wacom tablet pressure affects mesh roughness
- **Real-time Effects**: Lighting and particles update in real-time

## 🔧 Configuration

### Live Server Settings
The project includes optimized VS Code settings for Live Server:
- **Port**: 5500
- **Auto-open**: Enabled
- **Live reload**: Enabled
- **HTTPS**: Disabled

### Three.js Version
Currently using Three.js version `0.158.0` for stability and compatibility.

## 🐛 Troubleshooting

### White Screen Issues
1. **Check Console**: Press `F12` and look for error messages
2. **Clear Cache**: Press `Ctrl+F5` to force refresh
3. **Check Network**: Ensure Three.js CDN is accessible
4. **Fallback Scene**: If main scene fails, a simple green cube will appear

### Performance Issues
- **Reduce Particle Count**: Edit `particleCount` variable in code
- **Disable SSAO**: Comment out SSAO pass for better performance
- **Lower Detail**: Reduce `detail` variable for mesh complexity

### Import Errors
- **Check Internet**: Three.js loads from CDN
- **Browser Support**: Ensure modern browser with ES6 modules support
- **CORS Issues**: Use Live Server instead of file:// protocol

## 🎨 Customization

### Colors
```javascript
// Main mesh color
const material = new THREE.MeshStandardMaterial({ color: 0x00ff88 });

// Particle color
const particleMaterial = new THREE.PointsMaterial({ color: 0xff0077 });

// Wireframe color
const wireframeMaterial = new THREE.LineBasicMaterial({ color: 0x000000 });
```

### Particle System
```javascript
// Adjust particle count
const particleCount = 1200; // Increase/decrease for performance

// Change wave pattern
const wave = Math.sin(time + x * 0.5 + z * 0.5 + wavePhases[i]) * 0.5;
```

### Mesh Detail
```javascript
// Adjust mesh complexity
const detail = 5; // Higher = more vertices, better detail
```

## 📱 Browser Support

- **Chrome**: 61+ (Full support)
- **Firefox**: 60+ (Full support)
- **Safari**: 10.1+ (Full support)
- **Edge**: 79+ (Full support)

## 🔗 Dependencies

- **Three.js**: 0.158.0 (via CDN)
- **OrbitControls**: For camera controls
- **EffectComposer**: For post-processing
- **SSAOPass**: For ambient occlusion

## 📄 License

MIT License - Feel free to use, modify, and distribute.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

If you encounter issues:
1. Check the browser console (F12)
2. Review the troubleshooting section
3. Ensure all dependencies are loading correctly
4. Try the fallback scene to isolate issues

---

**Enjoy exploring the 3D scene!** 🎮✨ 