# Docker Build and Run Guide

## Building the Docker Image

To build the Docker image, run the following command from the project root directory:

```bash
docker build -t pdf-analyzer .
```

This will create a Docker image named "pdf-analyzer" using the Dockerfile in the current directory.

## Running the Docker Container

### For Model Training:

```bash
docker run --rm \
  -v "$(pwd)/input_pdfs:/app/input_pdfs" \
  -v "$(pwd)/models:/app/models" \
  pdf-analyzer python analyze_pdf.py --mode train input_pdfs models
```

On Windows CMD:

```cmd
docker run --rm ^
  -v "%cd%\input_pdfs:/app/input_pdfs" ^
  -v "%cd%\models:/app/models" ^
  pdf-analyzer python analyze_pdf.py --mode train input_pdfs models
```

On Windows PowerShell:

```powershell
docker run --rm `
  -v "${PWD}/input_pdfs:/app/input_pdfs" `
  -v "${PWD}/models:/app/models" `
  pdf-analyzer python analyze_pdf.py --mode train input_pdfs models
```

### For PDF Analysis:

```bash
docker run --rm \
  -v "$(pwd)/input_pdfs:/app/input_pdfs" \
  -v "$(pwd)/models:/app/models" \
  -v "$(pwd)/output:/app/output" \
  pdf-analyzer python analyze_pdf.py --mode analyze input_pdfs output
```

On Windows CMD:

```cmd
docker run --rm ^
  -v "%cd%\input_pdfs:/app/input_pdfs" ^
  -v "%cd%\models:/app/models" ^
  -v "%cd%\output:/app/output" ^
  pdf-analyzer python analyze_pdf.py --mode analyze input_pdfs output
```

On Windows PowerShell:

```powershell
docker run --rm `
  -v "${PWD}/input_pdfs:/app/input_pdfs" `
  -v "${PWD}/models:/app/models" `
  -v "${PWD}/output:/app/output" `
  pdf-analyzer python analyze_pdf.py --mode analyze input_pdfs output
```

## Using Docker Compose

With docker-compose, you can simplify the commands:

```bash
# Build the image
docker-compose build

# Run analysis (default)
docker-compose up

# Run training
docker-compose run pdf-analyzer python analyze_pdf.py --mode train input_pdfs models
```

## One-Step Build and Run

You can also build and run in a single command:

```bash
# For analysis
docker-compose up --build

# For training
docker-compose run --build pdf-analyzer python analyze_pdf.py --mode train input_pdfs models
```
