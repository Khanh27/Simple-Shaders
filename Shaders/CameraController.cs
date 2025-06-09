using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class CameraController : MonoBehaviour
{
    [SerializeField]
	protected Shader shader;
	protected Material material;

	private void Awake()
	{
		// Create a new material with the supplied shader.
		material = new Material(shader);
	}

	// OnRenderImage() is called when the camera has finished rendering.
	protected virtual void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		Graphics.Blit(src, dst, material);
	}
}