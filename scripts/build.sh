#!/bin/bash

set -e
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
PROJECT_NAME="Arliz"
SOURCE_FILE="book/Arliz.tex"
OUTPUT_DIR="book"
LOG_DIR=".build"
LOG_FILE="$LOG_DIR/build.log"
WATCH_FLAG="$LOG_DIR/.watch_lock"

# Create log directory
mkdir -p "$LOG_DIR"

# Logging functions
log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

log_silent() {
    echo "$1" >> "$LOG_FILE"
}

print_header() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    🚀 ${PROJECT_NAME} Build System                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check for critical errors that should stop the build
check_critical_error() {
    local log_file="$1"
    
    # Critical errors that should stop the build
    local critical_errors=(
        "File.*not found"
        "Emergency stop"
        "Fatal error"
        "No pages of output"
        "Undefined control sequence"
        "Missing \\begin{document}"
        "Extra \\begin"
        "Extra \\end"
        "Runaway argument"
        "File ended while scanning"
    )
    
    for error in "${critical_errors[@]}"; do
        if grep -qi "$error" "$log_file"; then
            return 0  # Critical error found
        fi
    done
    
    # Check if PDF was actually generated (most important test)
    if [ ! -f "Arliz.pdf" ]; then
        return 0  # No PDF = critical error
    fi
    
    return 1  # No critical errors
}

# Check if LaTeX is installed
check_latex() {
    print_step "Checking LaTeX installation..."
    
    # Common LaTeX distributions
    LATEX_ENGINES=("pdflatex" "xelatex" "lualatex")
    FOUND_ENGINE=""
    
    for engine in "${LATEX_ENGINES[@]}"; do
        if command -v "$engine" >/dev/null 2>&1; then
            FOUND_ENGINE="$engine"
            break
        fi
    done
    
    if [ -z "$FOUND_ENGINE" ]; then
        print_error "LaTeX not found!"
        echo
        print_step "Please install LaTeX based on your system:"
        echo -e "${YELLOW}Ubuntu/Debian:${NC} sudo apt install texlive-full"
        echo -e "${YELLOW}CentOS/RHEL:${NC}  sudo yum install texlive-scheme-full"
        echo -e "${YELLOW}Arch Linux:${NC}   sudo pacman -S texlive-most"
        echo -e "${YELLOW}macOS:${NC}        brew install mactex-no-gui"
        echo -e "${YELLOW}Windows:${NC}      Download MiKTeX or TeX Live"
        echo
        exit 1
    fi
    
    print_success "Found LaTeX engine: $FOUND_ENGINE"
    log_silent "LaTeX engine: $FOUND_ENGINE"
    echo "$FOUND_ENGINE" > "$LOG_DIR/.latex_engine"
}

# Build the document
build_document() {
    print_step "Building $PROJECT_NAME..."
    
    if [ ! -f "$SOURCE_FILE" ]; then
        print_error "Source file not found: $SOURCE_FILE"
        exit 1
    fi
    
    LATEX_ENGINE=$(cat "$LOG_DIR/.latex_engine" 2>/dev/null || echo "pdflatex")
    
    log_silent "Build started at: $(date)"
    log_silent "Source: $SOURCE_FILE"
    log_silent "Engine: $LATEX_ENGINE"
    
    # Change to book directory for proper relative paths
    cd book
    
    # First pass
    print_step "Running first pass..."
    if ! $LATEX_ENGINE -interaction=nonstopmode Arliz.tex >> "../$LOG_FILE" 2>&1; then
        # Check if it's a real error or just warnings
        if check_critical_error "../$LOG_FILE"; then
            print_error "First pass failed with critical errors!"
            show_errors
            exit 1
        else
            print_warning "First pass completed with warnings (continuing...)"
        fi
    fi
    
    # Check if we need bibliography
    if grep -q "\\bibliography\|\\addbibresource" Arliz.tex 2>/dev/null; then
        print_step "Processing bibliography..."
        if command -v biber >/dev/null 2>&1; then
            biber Arliz >> "../$LOG_FILE" 2>&1 || true
        elif command -v bibtex >/dev/null 2>&1; then
            bibtex Arliz >> "../$LOG_FILE" 2>&1 || true
        fi
    fi
    
    # Second pass for references
    print_step "Running second pass..."
    if ! $LATEX_ENGINE -interaction=nonstopmode Arliz.tex >> "../$LOG_FILE" 2>&1; then
        if check_critical_error "../$LOG_FILE"; then
            print_error "Second pass failed with critical errors!"
            show_errors
            exit 1
        else
            print_warning "Second pass completed with warnings (continuing...)"
        fi
    fi
    
    # Third pass for final formatting
    print_step "Running final pass..."
    if ! $LATEX_ENGINE -interaction=nonstopmode Arliz.tex >> "../$LOG_FILE" 2>&1; then
        if check_critical_error "../$LOG_FILE"; then
            print_error "Final pass failed with critical errors!"
            show_errors
            exit 1
        else
            print_warning "Final pass completed with warnings (continuing...)"
        fi
    fi
    
    cd ..
    
    if [ -f "$OUTPUT_DIR/Arliz.pdf" ]; then
        print_success "Build completed successfully!"
        print_success "Output: $OUTPUT_DIR/Arliz.pdf"
        log_silent "Build completed at: $(date)"
        
        # Clean up auxiliary files
        cleanup_aux_files
    else
        print_error "PDF not generated!"
        show_errors
        exit 1
    fi
}

# Clean up auxiliary files
cleanup_aux_files() {
    print_step "Cleaning up auxiliary files..."
    cd book
    rm -f *.aux *.log *.toc *.out *.bbl *.blg *.fdb_latexmk *.fls *.synctex.gz *.nav *.snm *.vrb
    cd ..
    print_success "Cleanup completed"
}

# Show important errors
show_errors() {
    echo
    print_error "Build failed! Here are the critical errors:"
    echo -e "${RED}────────────────────────────────────────────────────────────${NC}"
    
    # Extract only critical error messages
    if [ -f "$LOG_FILE" ]; then
        # Look for critical errors only
        grep -i "emergency stop\|fatal error\|file.*not found\|undefined control sequence\|no pages of output\|missing.*begin{document}" "$LOG_FILE" | head -5 | while IFS= read -r line; do
            echo -e "${RED}$line${NC}"
        done
        
        # Check for missing packages specifically
        if grep -qi "file.*\.sty.*not found" "$LOG_FILE"; then
            echo
            print_warning "Missing LaTeX packages detected!"
            print_step "Quick fix: Run the dependency installer:"
            echo -e "${GREEN}  chmod +x scripts/install-latex-deps.sh${NC}"
            echo -e "${GREEN}  ./scripts/install-latex-deps.sh${NC}"
            echo
            print_step "Or install manually based on your system:"
            echo -e "${YELLOW}Void Linux:${NC}    sudo xbps-install texlive-most texlive-fontsExtra"
            echo -e "${YELLOW}Ubuntu/Debian:${NC} sudo apt install texlive-latex-extra texlive-fonts-extra"
            echo -e "${YELLOW}Arch Linux:${NC}   sudo pacman -S texlive-most texlive-fontsextra"
            echo -e "${YELLOW}macOS:${NC}        tlmgr install mathdesign charter mathpazo"
        fi
    fi
    
    echo -e "${RED}────────────────────────────────────────────────────────────${NC}"
    echo -e "${YELLOW}Full log available at: $LOG_FILE${NC}"
    
    # Show warnings summary
    if [ -f "$LOG_FILE" ]; then
        local warning_count=$(grep -c "Warning\|warning" "$LOG_FILE" 2>/dev/null || echo 0)
        if [ "$warning_count" -gt "0" ]; then
            echo -e "${YELLOW}ℹ️  Note: $warning_count warnings found (these don't stop the build)${NC}"
        fi
    fi
}

# Watch mode
watch_mode() {
    print_step "Entering watch mode..."
    print_warning "Watching for changes in $SOURCE_FILE"
    print_warning "Press Ctrl+C to exit watch mode"
    echo
    
    touch "$WATCH_FLAG"
    
    # Get initial modification time
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        LAST_MOD=$(stat -f %m "$SOURCE_FILE" 2>/dev/null || echo 0)
    else
        # Linux
        LAST_MOD=$(stat -c %Y "$SOURCE_FILE" 2>/dev/null || echo 0)
    fi
    
    while [ -f "$WATCH_FLAG" ]; do
        if [[ "$OSTYPE" == "darwin"* ]]; then
            CURRENT_MOD=$(stat -f %m "$SOURCE_FILE" 2>/dev/null || echo 0)
        else
            CURRENT_MOD=$(stat -c %Y "$SOURCE_FILE" 2>/dev/null || echo 0)
        fi
        
        if [ "$CURRENT_MOD" -gt "$LAST_MOD" ]; then
            echo
            print_step "Change detected, rebuilding..."
            build_document
            LAST_MOD=$CURRENT_MOD
            echo
            print_warning "Watching for changes... (Ctrl+C to exit)"
        fi
        
        sleep 2
    done
}

# Cleanup function for watch mode
cleanup_watch() {
    print_step "Exiting watch mode..."
    rm -f "$WATCH_FLAG"
    print_success "Watch mode disabled"
    exit 0
}

# Main script logic
main() {
    # Initialize log
    echo "Build log for $PROJECT_NAME - $(date)" > "$LOG_FILE"
    
    print_header
    
    case "${1:-build}" in
        "build"|"")
            check_latex
            build_document
            ;;
        "watch")
            check_latex
            trap cleanup_watch INT TERM
            build_document
            watch_mode
            ;;
        "clean")
            print_step "Cleaning all build files..."
            cleanup_aux_files
            rm -rf "$LOG_DIR"
            rm -f "$OUTPUT_DIR/Arliz.pdf"
            print_success "All build files cleaned"
            ;;
        "help"|"-h"|"--help")
            echo -e "${CYAN}Usage:${NC}"
            echo "  $0 [command]"
            echo
            echo -e "${CYAN}Commands:${NC}"
            echo "  build       Build the document (default)"
            echo "  watch       Build and watch for changes"
            echo "  clean       Clean all build files"
            echo "  warnings    Show build warnings from last build"
            echo "  help        Show this help message"
            ;;
        "warnings")
            if [ -f "$LOG_FILE" ]; then
                print_step "Warnings from last build:"
                echo -e "${YELLOW}────────────────────────────────────────────────────────────${NC}"
                grep -i "warning\|underfull\|overfull" "$LOG_FILE" | head -20 | while IFS= read -r line; do
                    echo -e "${YELLOW}$line${NC}"
                done
                echo -e "${YELLOW}────────────────────────────────────────────────────────────${NC}"
                local warning_count=$(grep -c "Warning\|warning" "$LOG_FILE" 2>/dev/null || echo 0)
                echo -e "${BLUE}Total warnings: $warning_count${NC}"
            else
                print_error "No build log found. Run a build first."
            fi
            ;;
        *)
            print_error "Unknown command: $1"
            echo "Use '$0 help' for usage information"
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
