# Installing Docker Compose

After installing Docker, you may want to install Docker Compose separately (on some systems it's not included by default).

## Windows & macOS

Docker Compose is included with Docker Desktop for Windows and macOS.

## Linux

1. Download the current stable release of Docker Compose:

   ```
   sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   ```

2. Apply executable permissions:

   ```
   sudo chmod +x /usr/local/bin/docker-compose
   ```

3. Create a symbolic link to make it available in your path:

   ```
   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
   ```

4. Verify the installation:
   ```
   docker-compose --version
   ```

## Alternatively, using pip (Python package manager)

If you have Python and pip installed, you can install Docker Compose using pip:

```
pip install docker-compose
```

# Verifying Docker Installation

To verify Docker is installed correctly, run:

```
docker --version
docker run hello-world
```

If Docker is working correctly, you'll see version information and the hello-world container will run successfully.

# Troubleshooting Docker Installation

## Common Issues on Windows

1. Virtualization not enabled in BIOS/UEFI
2. WSL 2 not installed or configured properly
3. Hyper-V not available or enabled

## Common Issues on Linux

1. Docker daemon not running
   ```
   sudo systemctl start docker
   ```
2. User not in docker group (requires running with sudo)

   ```
   sudo usermod -aG docker $USER
   ```

   Then log out and log back in.

3. Firewall blocking Docker
   ```
   sudo firewall-cmd --permanent --zone=trusted --add-interface=docker0
   sudo firewall-cmd --reload
   ```
