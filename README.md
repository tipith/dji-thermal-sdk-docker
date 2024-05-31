# DJI Thermal SDK Docker image

![](https://img.shields.io/badge/version-v1.4-red.svg)

Dockerized [DJI Thermal SDK](https://www.dji.com/downloads/softwares/dji-thermal-sdk), which includes example tools for processing and measuring some DJI thermal images.

## Prequisites

1. For Windows, follow the installation instructions at https://docs.docker.com/desktop/install/windows-install/
2. Clone this repo

## Installation

```sh
docker build -t djithermal .                        
```

## Commands

Convert all R-JPGs from INPUT_DIR to tiff at OUTPUT_DIR. Pixel format is float and preserves exif tags.

```powershell
docker run `
    --network none `
    -v C:\dji-thermal-sdk-docker:/work `
    -v C:\my\path\to\input-jpg:/pics_in `
    -v C:\my\path\to\output-tiff:/pics_out `
    -w /work `
    -i `
    tipith/djithermal:v1 `
        /bin/bash -c "ls -l /pics_in; chmod +x work.sh; sed -i $'s/\r$//' ./work.sh; ./work.sh /pics_in /pics_out"
```