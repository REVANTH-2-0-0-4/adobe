# PDF Analyzer

PDF Analyzer automatically extracts document outlines and heading structure from
PDF files.  It provides a small command line interface and Docker setup so you
can train a model on your own annotated PDFs and then generate JSON outlines for
new documents.

The project was built for an internal hackathon where the challenge was to
identify headings of different levels (H1, H2, H3…) across PDFs with very
different layouts.  A machine‑learning model is trained on annotated data using
features such as font size, boldness and numbering patterns.  The trained model
is then used to label new documents and produce a structured outline.

## Directory Structure

```
├── analyze_pdf.py         # Command line entry point
├── run_project.py         # Helper script for training and analysis
├── pdf_analyzer/          # Main package
│   ├── config/            # Path configuration
│   ├── core/              # Parsing, feature extraction, heading detection
│   ├── model/             # Model training logic
│   ├── utils/             # Helper utilities
│   └── cli/               # CLI wrapper around the functionality
├── scripts/               # Tools for generating annotation CSVs
├── input_pdfs/            # Example PDFs to process
├── models/                # Saved models (created after training)
├── output/                # JSON outlines produced by the analyzer
├── docker-compose.yml     # Docker setup
├── Dockerfile
└── tests/                 # Unit tests
```

## Installation

```bash
pip install -r requirements.txt
```

## Usage

### 1. Prepare Training Data (optional)

If you want to train the model yourself, extract lines or spans from your PDFs
and label them:

```bash
python scripts/export_spans.py      # or export_lines_new.py
# Open data/annotations_template.csv and fill in the 'label' column
mv data/annotations_template.csv data/annotations.csv
```

### 2. Train the Model

```bash
python analyze_pdf.py --mode train input_pdfs models/
```

### 3. PDF Outline Extraction

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

The code is organized into a few focused modules:

- **Document Parser** – uses [PyMuPDF](https://pymupdf.readthedocs.io/) to read
  each PDF and collect text spans with font information.
- **Feature Extractor** – converts spans into numeric features (font size,
  bold flag, word count, upper‑case ratio, numbering pattern, relative size).
- **Model Trainer** – trains a simple Decision Tree classifier from annotated
  examples and stores the model as `models/heading_model.joblib`.
- **Heading Detector** – loads the trained model and predicts heading levels to
  generate a JSON outline for each document.

Unit tests for the feature extractor and heading detector reside in the
`tests/` directory.

## Running Tests

```bash
pytest -v
```
