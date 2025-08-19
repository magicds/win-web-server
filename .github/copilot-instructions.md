# Windows Local Web Server Setup (win-web-server)

**ALWAYS follow these instructions first and only fallback to additional search and context gathering if the information here is incomplete or found to be in error.**

Windows Local Web Server is a portable local development environment using nginx and PHP on Windows, managed as system services via Windows Service Wrapper (winsw). This project provides an alternative to XAMPP/phpStudy with support for multiple PHP versions, virtual hosts, and custom configurations.

## CRITICAL: Windows-Only Project

**This project ONLY works on Windows. Do NOT attempt to build or run on Linux/macOS.**
- All executable files (.exe) are Windows PE32 binaries using Windows Service Wrapper (winsw)
- Configuration files reference Windows-specific paths (D:\ drives)
- Service installation requires Windows Administrator privileges
- **NEVER CANCEL service operations** - Service registration can take 30-60 seconds. Set timeout to 120+ seconds.

## Working Effectively

### Prerequisites (Windows Only)
- Windows operating system with Administrator privileges
- Download nginx from [nginx.org](https://nginx.org/en/download.html)
- Download PHP from [php.net](https://www.php.net/downloads.php)
- **NEVER CANCEL downloads** - Large PHP/nginx archives can take 5-15 minutes depending on connection

### Initial Setup Process (Windows Only)
1. **Download and extract nginx:**
   ```cmd
   # Download nginx from nginx.org and extract to nginx/ directory
   # Example: nginx-1.24.0 extracted to nginx/nginx-1.24.0/
   ```

2. **Download and extract PHP:**
   ```cmd
   # Download PHP from php.net and extract to php/ directory  
   # Example: php-8.2.0-nts-Win32-vs16-x64.zip extracted to php/php-8.2.0-nts/
   ```

3. **Configure paths in service XML files:**
   - Edit `nginx/nginx-server.xml` - update `<executable>` path to your nginx.exe location
   - Edit `php/php-server.xml` - update `<executable>` path to your php-cgi.exe location and port

4. **Install as Windows services (Administrator required):**
   ```cmd
   # NEVER CANCEL - Service registration takes 30-60 seconds
   cd nginx
   nginx-server.exe install
   
   cd ../php  
   php-server.exe install
   ```

5. **Start services:**
   ```cmd
   # NEVER CANCEL - Service startup can take 15-30 seconds
   net start nginx
   net start php-cgi
   ```

### Configuration Management
- **nginx configuration:** Copy `nginx/examples/nginx.conf` to your nginx installation's `conf/` directory
- **Virtual hosts:** Copy files from `nginx/examples/vhosts/` to your nginx `conf/vhosts/` directory
- **Web root:** Place web files in directories referenced by virtual host configurations (default: `D:/server/root/`)

### Validation (Windows Only)
- **Test nginx config:** `nginx.exe -t` (from nginx directory)
- **Check services:** `sc query nginx` and `sc query php-cgi`
- **Test web server:** Open `http://localhost` in browser
- **Validate PHP:** Create `<?php phpinfo(); ?>` file and access via web browser
- **ALWAYS test virtual host configurations** after making changes to nginx configs

### Service Management Commands (Windows Only)
```cmd
# Service installation (Administrator required)
nginx-server.exe install     # NEVER CANCEL - takes 30-60 seconds
php-server.exe install       # NEVER CANCEL - takes 30-60 seconds

# Service control
net start nginx              # NEVER CANCEL - takes 15-30 seconds  
net stop nginx               # NEVER CANCEL - takes 10-15 seconds
net start php-cgi            # NEVER CANCEL - takes 10-20 seconds
net stop php-cgi             # NEVER CANCEL - takes 5-10 seconds

# Service uninstallation
nginx-server.exe uninstall   # NEVER CANCEL - takes 15-30 seconds
php-server.exe uninstall     # NEVER CANCEL - takes 15-30 seconds
```

## Cross-Platform Development Notes

### Linux/macOS Limitations
- **Cannot run:** Windows .exe files will not execute on Linux/macOS
- **Can validate:** XML configuration syntax using `xmllint --noout *.xml`
- **Can check:** nginx configuration syntax if nginx is installed: `nginx -t -c path/to/nginx.conf`
- **File paths:** All D:\ paths in configs must be updated for Windows deployments

### Configuration Validation (Any Platform)
```bash
# Validate XML service configurations
xmllint --noout nginx/nginx-server.xml  # Should return no errors
xmllint --noout php/php-server.xml      # Should return no errors

# Check nginx configuration syntax (if nginx installed)
nginx -t -c nginx/examples/nginx.conf   # May fail due to missing Windows paths - this is expected

# Verify repository structure
tree .  # Should show organized nginx/, php/, root/ directories
```

## Common Tasks

### Repository Structure
```
win-web-server/
├── README.md                    # Main project documentation
├── nginx/
│   ├── README.md               # nginx-specific setup instructions
│   ├── nginx-server.exe        # Windows Service Wrapper for nginx
│   ├── nginx-server.xml        # Service configuration for nginx
│   └── examples/
│       ├── nginx.conf          # Main nginx configuration template
│       └── vhosts/
│           ├── default.conf    # Default virtual host example
│           └── fastadmin.conf  # FastAdmin PHP application example
├── php/
│   ├── README.md               # PHP-specific setup instructions
│   ├── php-server.exe          # Windows Service Wrapper for PHP
│   └── php-server.xml          # Service configuration for PHP-CGI
└── root/                       # Web root directory (placeholder)
```

### Key Configuration Files
- **nginx/nginx-server.xml:** Service wrapper config for nginx - update `<executable>` path
- **php/php-server.xml:** Service wrapper config for PHP-CGI - update `<executable>` path and port
- **nginx/examples/nginx.conf:** Main nginx configuration with fastcgi and proxy settings
- **nginx/examples/vhosts/default.conf:** Feature-rich virtual host with SSL, auth, and caching
- **nginx/examples/vhosts/fastadmin.conf:** Simple PHP application virtual host

### Configuration Paths to Update (Windows)
When setting up on Windows, update these paths in service XML files:
- `nginx/nginx-server.xml`: `<executable>D:\server\nginx\nginx.exe</executable>`
- `php/php-server.xml`: `<executable>D:\server\php\php7.3.4nts\php-cgi.exe</executable>`

## Troubleshooting

### Service Installation Issues
- **Permission denied:** Must run as Administrator on Windows
- **Service already exists:** Uninstall existing service first
- **Invalid executable path:** Verify nginx.exe/php-cgi.exe paths in XML files
- **NEVER CANCEL:** Service operations require patience - allow full completion

### Web Server Issues  
- **nginx won't start:** Check `nginx -t` for configuration errors
- **PHP not processing:** Verify PHP-CGI service is running and port 9000 is available
- **404 errors:** Check document root paths and file permissions
- **SSL issues:** Update certificate paths in virtual host configurations

### Development Workflow
1. **ALWAYS validate configurations** before deploying to Windows
2. **Test virtual host configs** by copying to running nginx instance
3. **Use version control** for configuration changes
4. **Backup service XML files** before making path changes
5. **Document custom configurations** for team members

## FAQ

### Can this run on Linux/macOS?
No, this is a Windows-specific solution using Windows Service Wrapper. For cross-platform development, consider Docker or native package managers.

### How to add new PHP versions?
1. Download and extract new PHP version to php/ directory
2. Copy php-server.xml to new filename (e.g., php81-server.xml)
3. Update executable path and service name in XML
4. Install as separate service with different port number

### How to add virtual hosts?
1. Create new .conf file in nginx/examples/vhosts/
2. Update server_name and document root paths
3. Copy to nginx installation's conf/vhosts/ directory
4. Reload nginx configuration

### Why not XAMPP/phpStudy?
- **Multiple PHP versions:** Better support for running different PHP versions simultaneously  
- **nginx-based:** Closer to production environment configurations
- **Portable:** Easier to migrate configurations between machines
- **Current versions:** Use latest nginx/PHP releases instead of bundled older versions