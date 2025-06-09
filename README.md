# 🎨 Unity Image Effects: Custom Shaders

This repository contains a collection of custom post-processing shaders written in Unity. Each shader demonstrates a different visual effect using fragment shader techniques and Unity's depth or color buffer. Based on Daniel Ilett's Image Effect series.  

## 🧪 Shaders Included

### 🖤 Greyscale Shader

Converts the rendered scene into greyscale by calculating **luminance** based on human visual sensitivity:
- Red contributes ~0.3
- Green ~0.59
- Blue ~0.11
- Each pixel's RGB is reduced to a single luminance value and applied uniformly.

**Preview:**
![Greyscale Preview](Images/GreyScale.png)

---

### 🟤 Sepia Tone Shader

Applies a vintage **sepia filter** by applying a 3×3 matrix to the original RGB values. This mimics the warm, brownish tint of old photographs.

**Core Idea:**
Each output color channel is a weighted sum of all three input channels.

**Preview:**
![Sepia Tone Preview](Images/Sepia-Effect.png)

---

### 🌈 Neon Line Shader (Edge Detection)

Uses the **depth buffer** to detect edges in the scene, creating a glowing or outlined silhouette effect. Ideal for stylized visuals or highlighting objects.

- Based on depth discontinuity (difference in depth between neighboring pixels)
- Can be combined with glow effects or colors for a "neon wireframe" look

**Preview:**
![Neon Preview](Images/Neon-Effect.png)

---
