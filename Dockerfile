# Use Python 3.9 as base image
FROM python:3.9-slim AS builder

# Set working directory
WORKDIR /app

# Copy pip configuration
COPY pip.conf /etc/pip.conf

# Install system dependencies needed for PyMuPDF
RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements-minimal.txt .

# Install Python dependencies with increased timeout
RUN pip install --no-cache-dir --timeout=600 -r requirements-minimal.txt

# Final stage
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy pip configuration
COPY pip.conf /etc/pip.conf

# Install system dependencies needed for PyMuPDF
RUN apt-get update && apt-get install -y \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy installed packages from builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy project files
COPY input_pdfs/ /app/input_pdfs/
COPY data/ /app/data/
COPY pdf_analyzer/ /app/pdf_analyzer/
COPY analyze_pdf.py .
COPY setup.py .

# Create output and models directories
RUN mkdir -p /app/output /app/models

# Set environment variables
ENV PYTHONPATH=/app

# Default command - runs the analyzer in extraction mode
# Can be overridden at runtime
CMD ["python", "analyze_pdf.py", "--mode", "analyze", "input_pdfs", "output"]
