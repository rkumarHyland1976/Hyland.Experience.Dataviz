#!/bin/bash

# Installation script for sample project dependencies

set -e

echo "🚀 Installing Sample Project Dependencies..."

# Check OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    OS="windows"
else
    echo "❌ Unsupported OS"
    exit 1
fi

echo "📋 Detected OS: $OS"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check .NET SDK
if ! command_exists dotnet; then
    echo "❌ .NET SDK not found. Please install .NET 8.0 SDK"
    exit 1
fi
echo "✅ .NET SDK: $(dotnet --version)"

# Check Docker
if ! command_exists docker; then
    echo "❌ Docker not found. Please install Docker"
    exit 1
fi
echo "✅ Docker: $(docker --version)"

# Restore .NET dependencies
echo "📦 Restoring .NET dependencies..."
dotnet restore

# Build solution
echo "🔨 Building solution..."
dotnet build -c Release

echo ""
echo "🎉 Installation completed successfully!"
