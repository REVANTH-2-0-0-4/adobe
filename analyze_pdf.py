"""
Entry point script for PDF Analyzer.
"""

import sys
import os

# Add the project root to Python path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

print("Python Path:", sys.path)
print("Current Directory:", os.getcwd())

try:
    from pdf_analyzer.cli.commands import main
    print("Successfully imported main from pdf_analyzer.cli.commands")
except ImportError as e:
    print(f"Import Error: {e}")
    print("Files in current directory:", os.listdir("."))
    print("Files in pdf_analyzer:", os.listdir("pdf_analyzer"))
    print("Files in pdf_analyzer/cli:", os.listdir("pdf_analyzer/cli"))

if __name__ == "__main__":
    print("Starting PDF Analyzer...")
    try:
        main()
    except NameError:
        # If main is not defined, try running it a different way
        import click
        from pdf_analyzer.core.headings import process_documents
        
        print("Using alternative method to run...")
        input_dir = "input_pdfs"
        output_dir = "output"
        print(f"Processing PDFs from '{input_dir}' and saving outlines to '{output_dir}'...")
        process_documents(input_dir, output_dir)
