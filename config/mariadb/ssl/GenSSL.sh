#!/bin/bash

# SSL Certificate Generator Script for MariaDB
# Author: lfelipe1501
# Usage: sh GenSSL.sh

# Colors for messages
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display information messages
info() {
    echo ""
    echo "${BLUE}[INFO]${NC} $1"
    echo ""
}

# Function to display success messages
success() {
    echo "${GREEN}[SUCCESS]${NC} $1"
}

# Function to display warning messages
warning() {
    echo "${YELLOW}[WARNING]${NC} $1"
}

# Function to display error messages
error() {
    echo ""
    echo "${RED}[ERROR]${NC} $1"
    exit 1
}

# Create directory structure if it doesn't exist
create_directories() {
    info "Creating directory structure..."
    
    if [ ! -d "CA" ]; then
        mkdir -p CA
        success "CA folder created"
    else
        warning "CA folder already exists"
    fi
    
    if [ ! -d "Server" ]; then
        mkdir -p Server
        success "Server folder created"
    else
        warning "Server folder already exists"
    fi
    
    if [ ! -d "Client" ]; then
        mkdir -p Client
        success "Client folder created"
    else
        warning "Client folder already exists"
    fi
    
    echo ""
}

# Clean existing files
clean_existing_files() {
    info "Cleaning existing files..."
    
    # Remove existing files in CA
    if [ -f "CA/ca-key.pem" ] || [ -f "CA/ca-cert.pem" ]; then
        rm -f CA/ca-*.pem
        success "Existing files in CA deleted"
    fi
    
    # Remove existing files in Server
    if [ -f "Server/server-key.pem" ] || [ -f "Server/server-cert.pem" ]; then
        rm -f Server/server-*.pem
        success "Existing files in Server deleted"
    fi
    
    # Remove existing files in Client
    if [ -f "Client/client-key.pem" ] || [ -f "Client/client-cert.pem" ]; then
        rm -f Client/client-*.pem
        success "Existing files in Client deleted"
    fi
    
    # Remove existing files in root directory
    if [ -f "ca-cert.pem" ] || [ -f "server-cert.pem" ] || [ -f "client-cert.pem" ]; then
        rm -f *.pem
        success "Existing files in root directory deleted"
    fi
    
    # Remove temporary files if they exist
    rm -f ext.cnf
    
    echo ""
}

# Create extensions configuration file
create_extensions_file() {
    echo "subjectAltName=DNS:mariadb,DNS:localhost,DNS:*.lfsystems.com.co,IP:127.0.0.1,IP:172.17.0.1,IP:10.10.0.103" > ext.cnf
}

# Generate CA (Certificate Authority) certificate
generate_ca_cert() {
    info "Generating CA (Certificate Authority) certificate..."
    
    # Change to CA directory
    cd CA || error "Could not access CA directory"
    
    # Generate CA private key (silent mode)
    echo -n "Generating private key for CA... "
    openssl genrsa 4096 > ca-key.pem 2>/dev/null || error "Error generating CA private key"
    echo "✓"
    success "CA private key generated: ca-key.pem"
    
    # Generate CA certificate
    echo -n "Generating self-signed CA certificate... "
    openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert.pem \
    -subj "/C=CO/ST=Valle/L=Cali/O=MariaDB-Certificates/OU=MariaDB-Certificates/CN=mariadb/emailAddress=lfelipe1501@gmail.com" \
    2>/dev/null || error "Error generating CA certificate"
    echo "✓"
    success "CA certificate generated: ca-cert.pem"
    
    # Return to main directory
    cd ..
    
    echo ""
}

# Generate server certificate
generate_server_cert() {
    info "Generating server certificate..."
    
    # Change to Server directory
    cd Server || error "Could not access Server directory"
    
    # Generate server certificate request
    echo -n "Generating server certificate request... "
    openssl req -newkey rsa:4096 -days 365000 -nodes -keyout server-key.pem -out server-req.pem \
    -subj "/C=CO/ST=Valle/L=Cali/O=MariaDB-Server/OU=MariaDB-Server/CN=mariadb/emailAddress=lfelipe1501@gmail.com" \
    -addext "subjectAltName=DNS:mariadb,DNS:localhost,DNS:*.lfsystems.com.co,IP:127.0.0.1,IP:172.17.0.1,IP:10.10.0.103" \
    2>/dev/null || error "Error generating server certificate request"
    echo "✓"
    success "Server certificate request generated: server-req.pem"
    
    # Optimize server private key
    echo -n "Optimizing server private key... "
    openssl rsa -in server-key.pem -out server-key.pem 2>/dev/null || error "Error optimizing server private key"
    echo "✓"
    success "Server private key optimized: server-key.pem"
    
    # Generate server certificate signed by CA
    echo -n "Generating server certificate signed by CA... "
    openssl x509 -req -in server-req.pem -days 365000 -CA ../CA/ca-cert.pem -CAkey ../CA/ca-key.pem \
    -set_serial 01 -out server-cert.pem -extfile ../ext.cnf 2>/dev/null || error "Error generating server certificate"
    echo "✓"
    success "Server certificate generated: server-cert.pem"
    
    # Remove request file
    rm -f server-req.pem
    
    # Return to main directory
    cd ..
    
    echo ""
}

# Generate client certificate
generate_client_cert() {
    info "Generating client certificate..."
    
    # Change to Client directory
    cd Client || error "Could not access Client directory"
    
    # Generate client certificate request
    echo -n "Generating client certificate request... "
    openssl req -newkey rsa:4096 -days 365000 -nodes -keyout client-key.pem -out client-req.pem \
    -subj "/C=CO/ST=Valle/L=Cali/O=MariaDB-Server/OU=MariaDB-Server/CN=mariadb/emailAddress=lfelipe1501@gmail.com" \
    -addext "subjectAltName=DNS:mariadb,DNS:localhost,DNS:*.lfsystems.com.co,IP:127.0.0.1,IP:172.17.0.1,IP:10.10.0.103" \
    2>/dev/null || error "Error generating client certificate request"
    echo "✓"
    success "Client certificate request generated: client-req.pem"
    
    # Optimize client private key
    echo -n "Optimizing client private key... "
    openssl rsa -in client-key.pem -out client-key.pem 2>/dev/null || error "Error optimizing client private key"
    echo "✓"
    success "Client private key optimized: client-key.pem"
    
    # Generate client certificate signed by CA
    echo -n "Generating client certificate signed by CA... "
    openssl x509 -req -in client-req.pem -days 365000 -CA ../CA/ca-cert.pem -CAkey ../CA/ca-key.pem \
    -set_serial 01 -out client-cert.pem -extfile ../ext.cnf 2>/dev/null || error "Error generating client certificate"
    echo "✓"
    success "Client certificate generated: client-cert.pem"
    
    # Remove request file
    rm -f client-req.pem
    
    # Return to main directory
    cd ..
    
    echo ""
}

# Set appropriate permissions
set_permissions() {
    info "Setting appropriate permissions for certificate files..."
    
    # Set permissions for CA certificates
    chmod 644 CA/ca-cert.pem
    chmod 600 CA/ca-key.pem
    
    # Set permissions for server certificates
    chmod 644 Server/server-cert.pem
    chmod 600 Server/server-key.pem
    
    # Set permissions for client certificates
    chmod 644 Client/client-cert.pem
    chmod 600 Client/client-key.pem
    
    success "Permissions set correctly"
    echo ""
}

# Final cleanup
cleanup() {
    info "Performing final cleanup..."
    
    # Remove temporary files
    rm -f ext.cnf
    
    success "Cleanup completed"
    echo ""
}

# Show summary
show_summary() {
    info "Summary of generated certificates:"
    echo "----------------------------------------------------"
    echo "CA Certificates:"
    echo "  - CA/ca-cert.pem"
    echo "  - CA/ca-key.pem"
    echo ""
    echo "Server Certificates:"
    echo "  - Server/server-cert.pem"
    echo "  - Server/server-key.pem"
    echo ""
    echo "Client Certificates:"
    echo "  - Client/client-cert.pem"
    echo "  - Client/client-key.pem"
    echo "----------------------------------------------------"
    echo ""
}

# Main function
main() {
    echo ""
    echo "======================================================"
    echo "  SSL CERTIFICATE GENERATOR FOR MARIADB"
    echo "======================================================"
    echo ""
    
    create_directories
    clean_existing_files
    create_extensions_file
    generate_ca_cert
    generate_server_cert
    generate_client_cert
    set_permissions
    cleanup
    show_summary
    
    success "SSL certificate generation process completed successfully!"
    success "The certificates are ready to be used by MariaDB."
    echo ""
    info "You can restart the services with 'docker compose down && docker compose up -d'"
    echo "======================================================"
    echo ""
}

# Execute main function
main
