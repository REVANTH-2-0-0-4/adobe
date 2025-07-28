# Docker Commands for PDF Analyzer

This document explains how to use Docker with the PDF Analyzer project.

## Prerequisites

- Docker installed on your system
- Docker Compose (optional, for using docker-compose.yml)

## Installing Docker

### Windows

1. Install Docker Desktop using the terminal:

   ```
   winget install Docker.DockerDesktop
   ```

   Or download the installer from [Docker's website](https://www.docker.com/products/docker-desktop/).

2. Start Docker Desktop after installation.

### macOS

1. Install Docker Desktop using Homebrew:

   ```
   brew install --cask docker
   ```

   Or download the installer from [Docker's website](https://www.docker.com/products/docker-desktop/).

2. Open Docker Desktop from your Applications folder.

### Ubuntu/Debian

1. Update package index:

   ```
   sudo apt-get update
   ```

2. Install prerequisites:

   ```
   sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
   ```

3. Add Docker's official GPG key:

   ```
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   ```

4. Set up the stable repository:

   ```
   echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

5. Install Docker Engine:

   ```
   sudo apt-get update
   sudo apt-get install docker-ce docker-ce-cli containerd.io
   ```

6. Add your user to the docker group to run Docker without sudo:
   ```
   sudo usermod -aG docker $USER
   ```
   Log out and log back in for this to take effect.

### CentOS/RHEL

1. Install required packages:

   ```
   sudo yum install -y yum-utils
   ```

2. Add the Docker repository:

   ```
   sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   ```

3. Install Docker:

   ```
   sudo yum install docker-ce docker-ce-cli containerd.io
   ```

4. Start and enable Docker:

   ```
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

5. Add your user to the docker group:
   ```
   sudo usermod -aG docker $USER
   ```
   Log out and log back in for this to take effect.

For more detailed installation instructions and troubleshooting, see [DOCKER_INSTALL.md](DOCKER_INSTALL.md).

## Building and Running with Docker

### Option 1: Using the provided scripts

#### On Windows:

```
run_docker.bat
```

#### On Linux/macOS:

```
chmod +x run_docker.sh
./run_docker.sh
```

### Option 2: Using Docker Compose

```
docker-compose up --build
```

This will use the default command from docker-compose.yml, which runs in analyze mode.

To run in training mode:

```
docker-compose run pdf-analyzer python analyze_pdf.py --mode train input_pdfs models
```

### Option 3: Manual Docker commands

#### Build the Docker image:

```
docker build -t pdf-analyzer .
```

#### Run model training:

```
docker run --rm \
  -v "./input_pdfs:/app/input_pdfs" \
  -v "./models:/app/models" \
  pdf-analyzer python analyze_pdf.py --mode train input_pdfs models
```

#### Run PDF analysis:

```
docker run --rm \
  -v "./input_pdfs:/app/input_pdfs" \
  -v "./models:/app/models" \
  -v "./output:/app/output" \
  pdf-analyzer python analyze_pdf.py --mode analyze input_pdfs output
```

## Container Structure

- `/app/input_pdfs` - Directory with input PDF files
- `/app/output` - Directory where output JSON files are saved
- `/app/models` - Directory where trained models are saved
- `/app/data` - Directory for data files like annotations

## Volume Mounts

The Docker setup uses volume mounts to:

1. Access PDF files from your local machine
2. Save output files to your local machine
3. Persist trained models between container runs
