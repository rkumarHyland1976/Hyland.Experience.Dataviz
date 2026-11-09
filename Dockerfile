# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder

WORKDIR /src

# Copy solution and project files
COPY ["*.sln", "."]
COPY ["src/", "src/"]
COPY ["test/", "test/"]

# Restore dependencies
RUN dotnet restore

# Build the solution
RUN dotnet build -c Release --no-restore

# Run unit tests (component tests need a Docker daemon and run in CI instead)
RUN dotnet test test/Hyland.Experience.SampleProject.Api.UnitTests -c Release --no-build --logger "trx;LogFileName=test-results.trx"

# Publish API
RUN dotnet publish src/Hyland.Experience.SampleProject.Api/Hyland.Experience.SampleProject.Api.csproj -c Release --no-build -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Install security updates
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy published application
COPY --from=builder /app/publish .

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD dotnet-health || exit 1

EXPOSE 8080

ENTRYPOINT ["dotnet", "Hyland.Experience.SampleProject.Api.dll"]
