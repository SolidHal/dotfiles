#!/usr/bin/env python3.10

import click
import pathlib
import shutil
import subprocess
import tempfile





@click.command()
@click.option('--video', required=True, help='video to convert to a gif')
@click.option('--low_res', is_flag=True, help='downres the gif after creating it')
def main(video, low_res):
    video_file_path = pathlib.Path(video).resolve()
    assert video_file_path.exists()

    palette_file_path = pathlib.Path("/tmp") / video_file_path.with_suffix(".png").name
    hq_gif_file_path = pathlib.Path("/tmp") / video_file_path.with_suffix(".gif").name

    gif_file_path = video_file_path.parent / video_file_path.with_suffix(".gif").name

    subprocess.run(["ffmpeg", "-y", "-i", video_file_path, "-vf", "palettegen", palette_file_path], check=True)
    subprocess.run(["ffmpeg", "-y", "-i", video_file_path, "-i", palette_file_path, "-filter_complex", "paletteuse", "-r", "10", hq_gif_file_path], check=True)

    if not low_res:
        hq_gif_file_path.rename(gif_file_path)
        print(f"created gif at {gif_file_path}")
        exit()

    subprocess.run(["gifsicle", "--resize-height", "220", "-O3", hq_gif_file_path, "-o", gif_file_path], check=True)
    print(f"created low res gif at {gif_file_path}")





if __name__ == "__main__":
    main()
