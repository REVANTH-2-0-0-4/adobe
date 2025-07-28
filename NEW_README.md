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
python analyze_pdf.py --mode train data/input_pdfs models/
```

### PDF Outline Extraction

```bash
python analyze_pdf.py --mode analyze data/input_pdfs output/
```

## Project Components

- **Document Parser**: Extracts text spans with formatting from PDF files
- **Feature Extractor**: Converts text spans into ML features for classification
- **Heading Detector**: Classifies text spans as headings of different levels
- **Model Trainer**: Trains and saves ML models for heading detection
