#!/usr/bin/env python3

# recursively find all .heic images in the specified directory and convert them to jpg
# requires heif-convert to be installed, which is often in the heif-examples package built from libheif

import click
import pathlib
import subprocess

@click.command()
@click.option('--directory', type=str, required=True, help='the directory to recurse down')
def main(directory):

    count = 0

# TODO heif-convert is slow, we could speed this up greatly by using threads/processes
    for heic_image in pathlib.Path(directory).rglob("*.heic"):
        jpg_image = heic_image.parent / (heic_image.name.rstrip(".heic") + ".jpg")
        print(f"converting {heic_image} to {jpg_image}")
        if jpg_image.exists():
            raise RuntimeError(f"Refusing to overwrite existing file {jpg_image}")
        subprocess.run(["heif-convert", "-q", "100", heic_image, jpg_image])
        count+=1

    print(f"converted {count} heic images")




if __name__ == "__main__":
    main()
