#!/bin/bash

if ! command -v qpdf &> /dev/null; then
    echo "qpdf is not installed. Please install it first."
    exit 1
fi

pdf_files=$(ls *.pdf | sort)

output_file="combined.pdf"

qpdf --empty --pages $pdf_files -- "$output_file"

echo "PDFs combined into $output_file"
