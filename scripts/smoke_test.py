"""Smoke test: validate the EEVEE pipeline described in docs/DIRECAO_ARTE.md.

Creates a stylized skin-shaded sphere under the project's standard 3-point studio
lighting and renders it at preview resolution.

Run from Blender 5.3:
    blender -b -P scripts/smoke_test.py -- --out renders/previews/smoke_test.png

Exits non-zero if render fails. Prints OK + path on success.
"""
import argparse
import os
import sys

import bpy

STUDIO_BG = (0.133, 0.133, 0.169, 1.0)
SKIN_BASE = (0.949, 0.690, 0.549, 1.0)
SSS_COLOR = (0.910, 0.565, 0.478, 1.0)


def parse_args():
    argv = sys.argv
    argv = argv[argv.index("--") + 1:] if "--" in argv else []
    p = argparse.ArgumentParser()
    p.add_argument("--out", default="renders/previews/smoke_test.png")
    p.add_argument("--width", type=int, default=540)
    p.add_argument("--height", type=int, default=960)
    return p.parse_args(argv)


def reset_scene():
    bpy.ops.wm.read_factory_settings(use_empty=True)
    scene = bpy.context.scene
    scene.render.engine = "BLENDER_EEVEE_NEXT"
    scene.render.fps = 30
    world = bpy.data.worlds.new("World")
    world.use_nodes = True
    bg = world.node_tree.nodes["Background"]
    bg.inputs["Color"].default_value = STUDIO_BG
    bg.inputs["Strength"].default_value = 1.0
    scene.world = world
    return scene


def make_skin_sphere():
    bpy.ops.mesh.primitive_uv_sphere_add(radius=1.0, segments=48, ring_count=24)
    obj = bpy.context.active_object
    obj.name = "SkinSphere"
    for p in obj.data.polygons:
        p.use_smooth = True

    mat = bpy.data.materials.new("SkinStylized")
    mat.use_nodes = True
    nt = mat.node_tree
    for n in list(nt.nodes):
        nt.nodes.remove(n)
    output = nt.nodes.new("ShaderNodeOutputMaterial")
    bsdf = nt.nodes.new("ShaderNodeBsdfPrincipled")
    bsdf.inputs["Base Color"].default_value = SKIN_BASE
    bsdf.inputs["Roughness"].default_value = 0.55
    if "Subsurface Weight" in bsdf.inputs:
        bsdf.inputs["Subsurface Weight"].default_value = 0.08
    if "Subsurface Radius" in bsdf.inputs:
        bsdf.inputs["Subsurface Radius"].default_value = (1.0, 0.3, 0.2)
    sss_input = "Subsurface Color" if "Subsurface Color" in bsdf.inputs else None
    if sss_input:
        bsdf.inputs[sss_input].default_value = SSS_COLOR
    nt.links.new(bsdf.outputs["BSDF"], output.inputs["Surface"])
    obj.data.materials.append(mat)
    return obj


def three_point_lighting():
    # Key: area 1x1m 250W, warm 4800K, upper front-left
    bpy.ops.object.light_add(type="AREA", location=(-2.0, -2.5, 2.5))
    key = bpy.context.active_object
    key.name = "KeyLight"
    key.data.energy = 250
    key.data.size = 1.0
    key.data.color = (1.0, 0.95, 0.85)
    key.rotation_euler = (1.0, -0.4, -0.8)

    # Fill: area 2x2m 60W, cool 6500K, lower front-right
    bpy.ops.object.light_add(type="AREA", location=(2.5, -2.0, 1.2))
    fill = bpy.context.active_object
    fill.name = "FillLight"
    fill.data.energy = 60
    fill.data.size = 2.0
    fill.data.color = (0.85, 0.92, 1.0)
    fill.rotation_euler = (1.3, 0.3, 0.9)

    # Rim: spot 200W, warm 3200K, back-right
    bpy.ops.object.light_add(type="SPOT", location=(2.0, 3.0, 2.5))
    rim = bpy.context.active_object
    rim.name = "RimLight"
    rim.data.energy = 200
    rim.data.color = (1.0, 0.85, 0.7)
    rim.data.spot_size = 1.2
    rim.rotation_euler = (-1.0, 0.2, 2.2)


def camera():
    bpy.ops.object.camera_add(location=(0.0, -4.0, 1.2))
    cam = bpy.context.active_object
    cam.name = "Cam"
    cam.data.lens = 50  # mm, 35-50 for dialog per briefing
    cam.data.sensor_width = 36
    cam.rotation_euler = (1.45, 0.0, 0.0)
    bpy.context.scene.camera = cam
    return cam


def configure_render(scene, width, height, out_path):
    r = scene.render
    r.resolution_x = width
    r.resolution_y = height
    r.resolution_percentage = 100
    r.image_settings.file_format = "PNG"
    r.image_settings.color_mode = "RGB"
    r.image_settings.color_depth = "8"
    r.filepath = out_path

    eevee = scene.eevee
    eevee.taa_render_samples = 128
    eevee.use_gtao = True
    eevee.gtao_distance = 0.3
    eevee.gtao_factor = 1.0
    # EEVEE Next names some things differently; guard with hasattr
    for attr, val in (
        ("use_bloom", False),
        ("use_ssr", True),
        ("use_soft_shadows", True),
        ("shadow_cube_size", "2048"),
    ):
        if hasattr(eevee, attr):
            try:
                setattr(eevee, attr, val)
            except (TypeError, AttributeError):
                pass

    view = scene.view_settings
    view.view_transform = "Standard"
    view.look = "Medium High Contrast"


def main():
    args = parse_args()
    scene = reset_scene()
    make_skin_sphere()
    three_point_lighting()
    camera()

    project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    out_path = args.out
    if not os.path.isabs(out_path):
        out_path = os.path.join(project_root, out_path)
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    configure_render(scene, args.width, args.height, out_path)

    print(f"[smoke_test] rendering to {out_path}")
    bpy.ops.render.render(write_still=True)
    print(f"[smoke_test] OK -> {out_path}")


if __name__ == "__main__":
    main()
