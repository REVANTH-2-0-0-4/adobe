# PDF Analyzer

A tool to extract outlines and headings from PDF documents.

## Project Structure

```
pdf_analyzer/
├── config/               # Configuration settings
│   ├── __init__.py
│   └── paths.py          # Path configurations
├── core/                 # Core functionality
│   ├── __init__.py
│   ├── document.py       # PDF parsing
│   ├── analysis.py       # Feature extraction
│   └── headings.py       # Heading detection
├── model/                # Model training
│   ├── __init__.py
│   └── trainer.py        # Training functionality
├── utils/                # Utilities
│   ├── __init__.py
│   └── io_helpers.py     # File I/O operations
├── cli/                  # Command line interface
│   ├── __init__.py
│   └── commands.py       # CLI commands
├── __init__.py
├── __main__.py
```

## Installation

```bash
pip install -r requirements.txt
```

## Usage

### Model Training

```bash
python analyze_pdf.py --mode train input_pdfs models/
```

### PDF Outline Extraction

```bash
python analyze_pdf.py --mode analyze input_pdfs output/
```

## Docker Support

The project includes Docker support for containerized execution.

### Building the Docker Image

```bash
# Build the Docker image
docker build -t pdf-analyzer .
```

### Running with Docker

```bash
# Run model training
docker run --rm \
  -v "$(pwd)/input_pdfs:/app/input_pdfs" \
  -v "$(pwd)/models:/app/models" \
  pdf-analyzer python analyze_pdf.py --mode train input_pdfs models

# Run PDF analysis
docker run --rm \
  -v "$(pwd)/input_pdfs:/app/input_pdfs" \
  -v "$(pwd)/models:/app/models" \
  -v "$(pwd)/output:/app/output" \
  pdf-analyzer python analyze_pdf.py --mode analyze input_pdfs output
```

### Using Convenience Scripts

```bash
# On Windows
run_docker.bat

# On Linux/macOS
chmod +x run_docker.sh
./run_docker.sh
```

For more Docker options, see [DOCKER_COMMANDS.md](DOCKER_COMMANDS.md)

## Project Components

- **Document Parser**: Extracts text spans with formatting from PDF files
- **Feature Extractor**: Converts text spans into ML features for classification
- **Heading Detector**: Classifies text spans as headings of different levels
- **Model Trainer**: Trains and saves ML models for heading detection
