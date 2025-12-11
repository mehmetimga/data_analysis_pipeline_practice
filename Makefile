# Makefile
# Data Analysis Pipeline for Book Word Counts
# Author: Mehmet Imga
# Converted to Makefile

# This Makefile completes the textual analysis of 4 novels and creates 
# figures on the 10 most frequently occurring words from each novel.

# Usage:
# make all    - run the entire pipeline
# make clean  - remove all generated files

# Define all figure files for the report dependency
FIGURE_FILES = results/figure/isles.png results/figure/abyss.png \
               results/figure/last.png results/figure/sierra.png

# Default target
all: docs/index.html

# Step 1: Count words in each book
results/isles.dat: data/isles.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/isles.txt --output_file=results/isles.dat

results/abyss.dat: data/abyss.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/abyss.txt --output_file=results/abyss.dat

results/last.dat: data/last.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/last.txt --output_file=results/last.dat

results/sierra.dat: data/sierra.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=data/sierra.txt --output_file=results/sierra.dat

# Step 2: Create plots from word counts
results/figure/isles.png: results/isles.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/isles.dat --output_file=results/figure/isles.png

results/figure/abyss.png: results/abyss.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/abyss.dat --output_file=results/figure/abyss.png

results/figure/last.png: results/last.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/last.dat --output_file=results/figure/last.png

results/figure/sierra.png: results/sierra.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=results/sierra.dat --output_file=results/figure/sierra.png

# Step 3: Render the report
docs/index.html: $(FIGURE_FILES) report/count_report.qmd
	quarto render report/count_report.qmd
	mkdir -p docs
	cp report/count_report.html docs/index.html

# Clean target - remove all generated files
clean:
	rm -f results/*.dat
	rm -f results/figure/*.png
	rm -f report/count_report.html
	rm -rf report/count_report_files
	rm -rf docs

.PHONY: all clean
