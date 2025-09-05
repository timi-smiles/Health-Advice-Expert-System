# Health Advice Expert System - Chatbot

An intelligent chatbot-based health advice system that provides personalized health recommendations through natural language conversation. Users can describe their symptoms in plain English, and the system provides relevant, evidence-based advice using advanced symptom analysis and expert system logic.

## 🚀 Features

- **💬 Natural Language Processing**: Describe symptoms in your own words
- **🤖 Intelligent Chatbot Interface**: Conversational health advice experience  
- **🎯 Smart Symptom Detection**: Automatically identifies symptoms from user text
- **📊 Weighted Scoring System**: Advanced relevance filtering for precise advice
- **⚡ Real-time Responses**: Instant health recommendations
- **📱 Responsive Design**: Works seamlessly on desktop and mobile
- **🔒 Privacy-Focused**: No personal data storage, secure conversations
- **✨ Clean Interface**: Modern, user-friendly chatbot design

## 🏗️ System Architecture

```
Health-Advice-Expert-System/
├── chatbot.html             # Main chatbot interface
├── js/
│   └── chatbot.js          # Chatbot frontend logic
├── backend/                # Server-side application
│   ├── api/
│   │   ├── chatbot.php     # Main chatbot API endpoint
│   │   ├── advice.php      # Health advice API
│   │   ├── symptoms.php    # Symptom management API
│   │   └── status.php      # System status API
│   ├── config/
│   │   └── database.php    # Database configuration
│   ├── models/
│   │   └── ExpertSystem.php # Core expert system logic
│   └── setup.php           # Database setup script
└── database/
    ├── enhanced_schema.sql  # Complete database schema
    ├── schema.sql          # Basic schema
    └── symptom_advice_relationships.sql # Relationship mappings
```

## 📋 Prerequisites

- **Web Server**: Apache/Nginx with PHP support (XAMPP recommended)
- **PHP**: Version 7.4 or higher
- **MySQL**: Version 5.7 or higher (or MariaDB 10.2+)
- **Web Browser**: Modern browser with JavaScript enabled

## 🛠️ Installation Guide

### 1. Environment Setup

#### Option A: XAMPP (Recommended for Development)
1. Download and install [XAMPP](https://www.apachefriends.org/)
2. Start Apache and MySQL services from XAMPP Control Panel
3. Place project folder in `htdocs` directory (usually `C:\xampp\htdocs\`)

#### Option B: Manual Setup
1. Install Apache/Nginx, PHP 7.4+, and MySQL 5.7+
2. Configure web server to serve PHP files
3. Ensure MySQL is running and accessible

### 2. Database Setup

1. **Import Database Schema**:
   ```bash
   # Using MySQL command line
   mysql -u root -p -e "CREATE DATABASE health_expert_system;"
   mysql -u root -p health_expert_system < database/enhanced_schema.sql
   ```

2. **Update Database Configuration**:
   Edit `backend/config/database.php` if needed:
   ```php
   private $host = 'localhost';
   private $db_name = 'health_expert_system';
   private $username = 'root';        // Default XAMPP username
   private $password = '';            // Default XAMPP password (empty)
   ```

3. **Run Setup Script** (Optional):
   ```bash
   cd backend
   php setup.php
   ```

### 3. Access the Chatbot

1. **Start XAMPP Services**: Apache and MySQL
2. **Navigate to**: `http://localhost/ENT-STREAM2-PROJECT/chatbot.html`
3. **Start Chatting**: Type your symptoms in natural language

## 💬 Usage Guide

### Basic Usage
1. Open the chatbot in your web browser
2. Type your symptoms naturally, for example:
   - "I have a headache and feel tired"
   - "My stomach hurts after eating"
   - "I've been coughing for 2 days"
3. The system will analyze your symptoms and provide relevant advice
4. Continue the conversation for more specific guidance

### Sample Conversations

**Example 1:**
```
User: "I have a headache and feel nauseous"
Bot: "I understand you're experiencing headache and nausea. Here's some advice..."
```

**Example 2:**
```
User: "My throat is sore and I have a fever"
Bot: "I can help with sore throat and fever symptoms. Here are my recommendations..."
```

## 🔧 Technical Details

### Expert System Logic
- **Natural Language Processing**: Extracts symptoms from user text
- **Weighted Scoring**: Each symptom-advice pair has relevance weights
- **Smart Filtering**: Returns only the most relevant advice (minimum score: 1.0)
- **Relevance Ranking**: Orders advice by symptom matches and relevance scores

### Database Structure
- **79 Symptoms**: Comprehensive symptom database
- **110 Advice Entries**: Evidence-based health recommendations  
- **248 Relationships**: Symptom-advice mappings with weights
- **Weighted Scoring**: Advanced relevance calculation system

### API Endpoints
- `POST /backend/api/chatbot.php` - Main chatbot conversation endpoint
- `GET /backend/api/symptoms.php` - Retrieve all symptoms
- `GET /backend/api/advice.php` - Retrieve advice by symptom IDs
- `GET /backend/api/status.php` - System health check

## 🏥 Medical Disclaimer

⚠️ **IMPORTANT MEDICAL DISCLAIMER** ⚠️

This chatbot provides **general health information only** and is **NOT a substitute for professional medical advice, diagnosis, or treatment**. 

- Always consult with qualified healthcare professionals for medical concerns
- Seek immediate medical attention for serious or emergency symptoms
- Do not delay seeking medical care based on information from this system
- This system is for educational and informational purposes only

## 🐛 Troubleshooting

### Common Issues

**Issue**: "Database connection failed"
- **Solution**: Check MySQL is running and credentials in `database.php` are correct

**Issue**: "Symptoms not detected"  
- **Solution**: Try rephrasing symptoms or use simpler language

**Issue**: "No advice found"
- **Solution**: System may not have advice for that specific symptom combination

**Issue**: Chatbot not loading
- **Solution**: Ensure Apache is running and check browser console for errors

### Debug Mode
Add to chatbot.js for debugging:
```javascript
const DEBUG_MODE = true; // Enable console logging
```

## 📊 System Requirements

### Minimum Requirements
- **RAM**: 512MB available memory
- **Storage**: 50MB disk space  
- **PHP Memory**: 128MB (php.ini: `memory_limit = 128M`)
- **Database**: MySQL 5.7+ or MariaDB 10.2+

### Recommended Requirements  
- **RAM**: 1GB+ available memory
- **Storage**: 100MB+ disk space
- **PHP Memory**: 256MB+ 
- **Connection**: Stable internet connection

## 🚀 Deployment

### Production Deployment
1. Upload files to your web server
2. Configure database connection for production
3. Set proper file permissions (755 for directories, 644 for files)
4. Configure SSL certificate for HTTPS
5. Update any hardcoded localhost URLs

### Security Considerations
- Use HTTPS in production
- Implement rate limiting for API endpoints
- Sanitize all user inputs (already implemented)
- Regular database backups
- Keep PHP and MySQL updated

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit changes (`git commit -am 'Add new feature'`)
4. Push to branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## 📞 Support

For technical support or questions about the Health Advice Expert System:

- **GitHub Issues**: [Report bugs or request features](https://github.com/timi-smiles/Health-Advice-Expert-System/issues)
- **Documentation**: Check this README for detailed setup instructions
- **Community**: Join discussions in the repository discussions section

---

**Made with ❤️ for better health awareness and education**
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
