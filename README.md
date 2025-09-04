# Health Advice Expert System

A web-based expert system that provides basic health advice based on user-input symptoms. The system uses a knowledge base of symptoms and recommended actions stored in a MySQL database, with a PHP backend and a clean HTML/CSS/JavaScript frontend.

## Features

- **Intuitive Symptom Selection**: Smart autocomplete search for symptoms
- **Expert System Logic**: AI-like reasoning based on symptom combinations
- **Severity Assessment**: Automatic evaluation of symptom severity
- **Emergency Detection**: Identifies potentially serious conditions
- **Responsive Design**: Works on desktop and mobile devices
- **Real-time Advice**: Instant health recommendations
- **Professional UI**: Clean, medical-grade interface

## System Architecture

```
Health-Advice-Expert-System/
├── frontend/                 # Client-side application
│   ├── index.html           # Main application page
│   ├── css/
│   │   └── styles.css       # Responsive styling
│   └── js/
│       └── app.js           # Frontend logic & API calls
├── backend/                 # Server-side application
│   ├── api/                 # REST API endpoints
│   │   ├── symptoms.php     # Symptom management API
│   │   └── advice.php       # Health advice API
│   ├── config/
│   │   └── database.php     # Database configuration
│   ├── models/
│   │   └── ExpertSystem.php # Core expert system logic
│   └── setup.php            # Database setup script
└── database/
    └── schema.sql           # Database schema & sample data
```

## Prerequisites

- **Web Server**: Apache/Nginx with PHP support
- **PHP**: Version 7.4 or higher
- **MySQL**: Version 5.7 or higher (or MariaDB 10.2+)
- **Web Browser**: Modern browser with JavaScript enabled

## Installation Guide

### 1. Environment Setup

#### Option A: XAMPP (Recommended for Development)
1. Download and install [XAMPP](https://www.apachefriends.org/)
2. Start Apache and MySQL services
3. Place project folder in `htdocs` directory

#### Option B: Manual Setup
1. Install Apache/Nginx, PHP, and MySQL
2. Configure web server to serve PHP files
3. Ensure MySQL is running

### 2. Database Configuration

1. **Update Database Credentials**:
   Edit `backend/config/database.php`:
   ```php
   private $host = 'localhost';         // Your MySQL host
   private $db_name = 'health_expert_system';
   private $username = 'your_username'; // Your MySQL username
   private $password = 'your_password'; // Your MySQL password
   ```

2. **Run Database Setup**:
   ```bash
   cd backend
   php setup.php
   ```

   Or manually import the database:
   ```sql
   mysql -u username -p < database/schema.sql
   ```

### 3. File Permissions

Ensure proper permissions for PHP to read/write:
```bash
chmod -R 755 backend/
chmod -R 644 frontend/
```

### 4. Web Server Configuration

#### Apache (.htaccess)
Create `.htaccess` in project root:
```apache
RewriteEngine On
RewriteRule ^api/(.*)$ backend/api/$1 [L]
```

#### Nginx
Add to server configuration:
```nginx
location /api/ {
    rewrite ^/api/(.*)$ /backend/api/$1 last;
}
```

## Usage

### For End Users

1. **Access the Application**:
   - Open `http://localhost/your-project-folder/frontend/` in your browser

2. **Using the System**:
   - Type symptoms in the search box
   - Select relevant symptoms from suggestions
   - Click "Get Health Advice" for recommendations
   - Follow the provided advice and warnings

### For Developers

#### API Endpoints

**Get Symptoms**
```http
GET /api/symptoms.php
GET /api/symptoms.php?search=headache
```

**Get Health Advice**
```http
POST /api/advice.php
Content-Type: application/json

{
  "symptoms": [1, 3, 5]
}
```

#### Adding New Symptoms
```sql
INSERT INTO symptoms (name, category, severity_level, description) 
VALUES ('New Symptom', 'category', 'medium', 'Description');
```

#### Adding New Advice
```sql
INSERT INTO advice (title, description, recommendation, severity_level, category) 
VALUES ('Title', 'Description', 'Recommendation', 'medium', 'category');

-- Link to symptoms
INSERT INTO symptom_advice (symptom_id, advice_id, weight) 
VALUES (symptom_id, advice_id, 1.0);
```

## Configuration

### Database Settings
- **Host**: Default localhost
- **Port**: Default 3306
- **Database**: `health_expert_system`
- **Charset**: UTF-8

### Security Settings
- Enable HTTPS in production
- Validate and sanitize all inputs
- Use prepared statements (already implemented)
- Set appropriate CORS headers

### Performance Optimization
- Enable PHP OPcache
- Use database indexing (already configured)
- Implement caching for frequent queries
- Optimize images and assets

## Troubleshooting

### Common Issues

**"Database connection failed"**
- Check MySQL is running
- Verify credentials in `database.php`
- Ensure database exists

**"CORS errors"**
- Check API CORS headers
- Ensure frontend and backend are on same domain

**"No symptoms found"**
- Run database setup script
- Check if sample data was imported
- Verify database permissions

**"API endpoints not working"**
- Check web server configuration
- Verify PHP is processing files
- Check error logs

### Error Logs
- PHP errors: Check web server error log
- Application errors: Check browser console
- Database errors: Check MySQL error log

## Development

### Code Structure

**Frontend (JavaScript)**
- `HealthExpertSystem` class handles all interactions
- Modular design with separated concerns
- API communication via fetch()
- Real-time UI updates

**Backend (PHP)**
- `ExpertSystem` model for business logic
- RESTful API design
- PDO for secure database access
- Error handling and logging

### Adding Features

1. **New Symptom Categories**:
   - Add to database
   - Update frontend filtering

2. **Advanced Logic**:
   - Modify `ExpertSystem::getHealthAdvice()`
   - Implement rule-based reasoning

3. **User Management**:
   - Add authentication system
   - Track user history

## Security Considerations

- **Input Validation**: All inputs are validated and sanitized
- **SQL Injection**: Uses prepared statements
- **XSS Protection**: Output escaping implemented
- **CSRF Protection**: Implement tokens for production
- **Data Privacy**: No personal data stored by default

## Medical Disclaimer

⚠️ **IMPORTANT MEDICAL DISCLAIMER**

This system is for educational and informational purposes only. It does NOT:
- Replace professional medical advice
- Provide medical diagnosis
- Substitute for emergency medical care

**Always consult qualified healthcare professionals for medical concerns.**

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## Support

For issues and questions:
1. Check the troubleshooting section
2. Search existing issues
3. Create a new issue with details

## Changelog

### Version 1.0.0
- Initial release
- Basic symptom selection
- Expert system logic
- Responsive design
- Database integration

---

**Built with ❤️ for better health awareness**
