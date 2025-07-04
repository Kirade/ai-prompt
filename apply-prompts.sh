#!/bin/bash

# AI Prompt Apply Script
# This script applies AI prompts from this repository to a target project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_DIR="$SCRIPT_DIR/claude"

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS] [TARGET_PATH]

Apply AI prompts to a project directory.

OPTIONS:
    -h, --help      Show this help message
    -f, --force     Force overwrite existing files without prompting
    -b, --backup    Create backups of existing files
    -s, --symlink   Create symbolic links instead of copying files
    -g, --global    Apply to home directory (~/.claude) for global use
    -l, --local     Install CLAUDE.md as CLAUDE.local.md for project-specific settings

TARGET_PATH:
    Path to the target project directory (default: current directory)

EXAMPLES:
    $0                  # Apply to current directory
    $0 ~/my-project     # Apply to specific project
    $0 -b ~/my-project  # Apply with backup
    $0 -s ~/my-project  # Create symbolic links
    $0 -g               # Apply globally to home directory
    $0 -g -s            # Create global symbolic links
    $0 -l               # Install CLAUDE.md as CLAUDE.local.md

EOF
}

# Parse command line arguments
FORCE=false
BACKUP=false
LINK=false
GLOBAL=false
LOCAL_MODE=false
TARGET_PATH="."

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -b|--backup)
            BACKUP=true
            shift
            ;;
        -s|--symlink)
            LINK=true
            shift
            ;;
        -g|--global)
            GLOBAL=true
            shift
            ;;
        -l|--local)
            LOCAL_MODE=true
            shift
            ;;
        -*)
            print_error "Unknown option: $1"
            usage
            exit 1
            ;;
        *)
            TARGET_PATH="$1"
            shift
            ;;
    esac
done

# If global option is set, override target path
if [ "$GLOBAL" = true ]; then
    TARGET_PATH="$HOME"
    print_info "Global mode: applying to home directory"
fi

# Resolve absolute path
TARGET_PATH=$(cd "$TARGET_PATH" 2>/dev/null && pwd || echo "$TARGET_PATH")

# Check if target path exists
if [ ! -d "$TARGET_PATH" ]; then
    print_error "Target directory does not exist: $TARGET_PATH"
    exit 1
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    print_error "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

print_info "Applying AI prompts to: $TARGET_PATH"

# Create .claude directory if it doesn't exist
CLAUDE_DIR="$TARGET_PATH/.claude"
if [ ! -d "$CLAUDE_DIR" ]; then
    print_info "Creating .claude directory..."
    mkdir -p "$CLAUDE_DIR"
fi

# Function to backup a file
backup_file() {
    local file="$1"
    local backup_file="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$file" "$backup_file"
    print_info "Backed up: $file -> $backup_file"
}

# Function to apply a prompt file
apply_file() {
    local source_file="$1"
    local target_file="$2"
    local filename=$(basename "$source_file")
    
    # Check if target file already exists
    if [ -f "$target_file" ]; then
        if [ "$FORCE" = false ]; then
            print_warning "File already exists: $target_file"
            read -p "Overwrite? (y/n) [n]: " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_info "Skipping: $filename"
                return
            fi
        fi
        
        # Create backup if requested
        if [ "$BACKUP" = true ]; then
            backup_file "$target_file"
        fi
    fi
    
    # Apply the file (copy or link)
    if [ "$LINK" = true ]; then
        print_info "Creating symbolic link: $filename"
        ln -sf "$source_file" "$target_file"
    else
        print_info "Copying: $filename"
        cp "$source_file" "$target_file"
    fi
    
    print_success "Applied: $filename"
}

# Apply all prompt files
applied_count=0
skipped_count=0

for file in "$SOURCE_DIR"/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # Handle local mode - rename CLAUDE.md to CLAUDE.local.md
        if [ "$LOCAL_MODE" = true ] && [ "$filename" = "CLAUDE.md" ]; then
            target_file="$CLAUDE_DIR/CLAUDE.local.md"
            print_info "Installing CLAUDE.md as CLAUDE.local.md for project-specific settings"
        else
            target_file="$CLAUDE_DIR/$filename"
        fi
        
        if apply_file "$file" "$target_file"; then
            ((applied_count++))
        else
            ((skipped_count++))
        fi
    fi
done

# Summary
echo
print_success "Process completed!"
print_info "Applied files: $applied_count"
if [ $skipped_count -gt 0 ]; then
    print_info "Skipped files: $skipped_count"
fi

# Instructions for the user
echo
if [ "$GLOBAL" = true ]; then
    print_info "To use these global prompts with Claude Code:"
    print_info "1. Open any project in Claude Code"
    print_info "2. The prompts in ~/.claude/ will be available globally"
    print_info "3. Project-specific prompts in .claude/ will override global ones"
else
    print_info "To use these prompts with Claude Code:"
    print_info "1. Open your project in Claude Code"
    print_info "2. The prompts in .claude/ will be automatically loaded"
    print_info "3. Reference them using @claude/CLAUDE.md"
    
    # Check if this is a git repository and remind about .gitignore
    if [ -d "$TARGET_PATH/.git" ]; then
        echo
        print_info "Don't forget to add .claude/settings.local.json to your .gitignore!"
    fi
fi