#!/bin/bash

# Deploy Claude Code commands to ~/.claude/commands

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/commands"
TARGET_DIR="$HOME/.claude/commands"

echo "🚀 Deploying Claude Code commands..."
echo ""

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "📁 Creating $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Count commands
COMMAND_COUNT=$(find "$SOURCE_DIR" -name "*.md" | wc -l | tr -d ' ')

if [ "$COMMAND_COUNT" -eq 0 ]; then
    echo "❌ No command files found in $SOURCE_DIR"
    exit 1
fi

# Copy all .md files from commands/ to ~/.claude/commands/
echo "📋 Copying $COMMAND_COUNT command(s):"
for cmd in "$SOURCE_DIR"/*.md; do
    if [ -f "$cmd" ]; then
        filename=$(basename "$cmd")
        cp "$cmd" "$TARGET_DIR/$filename"
        echo "   ✓ $filename"
    fi
done

echo ""
echo "✅ Deployment complete!"
echo ""
echo "Commands installed to: $TARGET_DIR"
echo "Available commands:"
echo ""

# List the deployed commands with their descriptions
for cmd in "$TARGET_DIR"/*.md; do
    if [ -f "$cmd" ]; then
        cmdname=$(basename "$cmd" .md)
        # Extract description from frontmatter if present
        description=$(grep "^description:" "$cmd" | sed 's/description: //' || echo "")
        if [ -n "$description" ]; then
            echo "   /$cmdname - $description"
        else
            echo "   /$cmdname"
        fi
    fi
done

echo ""
echo "💡 Use these commands in Claude Code by typing /<command-name>"
