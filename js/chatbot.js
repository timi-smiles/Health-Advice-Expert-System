// Health Assistant Chatbot - Powered by Expert System
class HealthChatbot {
    constructor() {
        this.apiBaseUrl = '/health-expert/backend/api';
        this.symptoms = [];
        this.selectedSymptoms = new Set();
        this.conversationState = 'greeting';
        this.init();
    }

    init() {
        this.loadSymptoms();
        this.bindEvents();
        this.addBotMessage("Ready to help! What symptoms are you experiencing?");
    }

    bindEvents() {
        const input = document.getElementById('user-input');
        const sendBtn = document.getElementById('send-btn');

        // Send message on Enter key
        input.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                this.sendMessage();
            }
        });

        // Send message on button click
        sendBtn.addEventListener('click', (e) => {
            e.preventDefault();
            this.sendMessage();
        });

        // Enable/disable send button based on input
        input.addEventListener('input', () => {
            const hasText = input.value.trim() !== '';
            sendBtn.disabled = !hasText;
            if (hasText) {
                sendBtn.style.background = '#667eea';
                sendBtn.style.cursor = 'pointer';
            } else {
                sendBtn.style.background = '#ccc';
                sendBtn.style.cursor = 'not-allowed';
            }
        });

        // Initially enable the button
        sendBtn.disabled = false;
    }

    async loadSymptoms() {
        try {
            const response = await fetch(`${this.apiBaseUrl}/symptoms.php`);
            const data = await response.json();
            if (data.success) {
                this.symptoms = data.symptoms;
                console.log(`Loaded ${this.symptoms.length} symptoms`);
            }
        } catch (error) {
            console.error('Error loading symptoms:', error);
            this.symptoms = this.getFallbackSymptoms();
        }
    }

    getFallbackSymptoms() {
        return [
            {id: 1, name: 'Headache', category: 'neurological'},
            {id: 2, name: 'Fever', category: 'general'},
            {id: 3, name: 'Cough', category: 'respiratory'},
            {id: 4, name: 'Chest pain', category: 'cardiac'},
            {id: 5, name: 'Fatigue', category: 'general'}
        ];
    }

    async sendMessage() {
        const input = document.getElementById('user-input');
        const sendBtn = document.getElementById('send-btn');
        const message = input.value.trim();
        
        console.log('Send message called with:', message);
        
        if (!message) {
            console.log('Empty message, returning');
            return;
        }

        // Disable send button temporarily
        sendBtn.disabled = true;
        sendBtn.style.background = '#ccc';

        // Add user message
        this.addUserMessage(message);
        input.value = '';
        
        // Show typing indicator
        this.showTyping();
        
        try {
            // Process message
            await this.processUserMessage(message);
        } catch (error) {
            console.error('Error in sendMessage:', error);
            this.addBotMessage("Sorry, I encountered an error. Please try again.");
        } finally {
            // Hide typing indicator and re-enable button
            this.hideTyping();
            sendBtn.disabled = false;
            sendBtn.style.background = '#667eea';
        }
    }

    async processUserMessage(message) {
        console.log('Processing message:', message);
        
        try {
            // Send message to chatbot API for natural language processing
            const apiUrl = `${this.apiBaseUrl}/chatbot.php`;
            console.log('Calling API:', apiUrl);
            
            const response = await fetch(apiUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message: message })
            });
            
            console.log('API Response status:', response.status);
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const data = await response.json();
            console.log('API Response data:', data);
            
            if (data.success) {
                if (data.type === 'advice') {
                    this.displayChatbotAdvice(data);
                } else if (data.type === 'no_symptoms') {
                    this.addBotMessage(data.message);
                    this.showSuggestions(data.suggestions);
                } else if (data.type === 'no_advice') {
                    this.addBotMessage(`I found these symptoms: **${data.symptoms.join(', ')}**\n\n${data.message}`);
                }
            } else {
                console.error('API returned error:', data.message);
                this.addBotMessage("Sorry, I'm having trouble understanding. Can you describe your symptoms more specifically?");
            }
            
        } catch (error) {
            console.error('Error processing message:', error);
            this.addBotMessage("I'm experiencing technical difficulties. Let me try a simpler approach...");
            
            // Fallback to simple keyword matching
            this.handleFallbackProcessing(message);
        }
    }

    extractSymptoms(message) {
        const foundSymptoms = [];
        
        this.symptoms.forEach(symptom => {
            const symptomName = symptom.name.toLowerCase();
            
            // Check for exact matches and partial matches
            if (message.includes(symptomName) || 
                this.fuzzyMatch(message, symptomName)) {
                foundSymptoms.push(symptom);
            }
        });
        
        return foundSymptoms;
    }

    fuzzyMatch(text, symptom) {
        // Handle common variations
        const variations = {
            'headache': ['head ache', 'head pain', 'migraine'],
            'stomach pain': ['stomach ache', 'belly pain', 'abdominal pain'],
            'chest pain': ['chest ache', 'heart pain'],
            'sore throat': ['throat pain', 'throat ache'],
            'runny nose': ['runny nose', 'nasal congestion', 'stuffy nose']
        };
        
        if (variations[symptom]) {
            return variations[symptom].some(variation => text.includes(variation));
        }
        
        return false;
    }

    async getHealthAdvice(foundSymptoms) {
        try {
            const symptomIds = Array.from(this.selectedSymptoms);
            
            // Acknowledge found symptoms
            const symptomNames = foundSymptoms.map(s => s.name).join(', ');
            this.addBotMessage(`I understand you're experiencing: **${symptomNames}**\n\nLet me analyze this...`);
            
            // Get advice from expert system
            const response = await fetch(`${this.apiBaseUrl}/advice.php`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ symptoms: symptomIds })
            });
            
            const data = await response.json();
            
            if (data.success && data.advice && data.advice.length > 0) {
                this.displayAdviceResults(data.advice, foundSymptoms.length);
            } else {
                this.addBotMessage(`I couldn't find specific advice for your symptoms. Here's what I recommend:\n\n• Monitor your symptoms\n• Stay hydrated\n• Get adequate rest\n• Consult a healthcare provider if symptoms persist`);
            }
            
        } catch (error) {
            console.error('Error getting advice:', error);
            this.addBotMessage("Sorry, I'm having trouble connecting to my medical database. Please try again or consult a healthcare professional.");
        }
    }

    displayChatbotAdvice(data) {
        let response = `Here are a few advice according to your symptoms:\n\n`;
        
        data.advice_items.forEach((advice, index) => {
            response += `**${advice.title}**\n`;
            response += `${advice.recommendation}\n`;
            
            if (advice.doctor_advice) {
                response += `See a doctor: ${advice.doctor_advice}\n`;
            }
            
            response += `\n`;
        });
        
        response += `Need more help? Describe additional symptoms.`;
        
        this.addBotMessage(response);
    }

    showSuggestions(suggestions) {
        let response = "Try describing your symptoms like:\n\n";
        suggestions.forEach((suggestion, index) => {
            response += `• ${suggestion}\n`;
        });
        this.addBotMessage(response);
    }

    handleGeneralMessage(message) {
        if (message.includes('hello') || message.includes('hi') || message.includes('hey')) {
            this.addBotMessage("Hello! I'm here to help with your health concerns. What symptoms are you experiencing?");
        } else if (message.includes('help')) {
            this.addBotMessage("I can help you with:\n\n• Symptom analysis\n• Health recommendations\n• When to see a doctor\n\nJust describe your symptoms in natural language!");
        } else {
            this.addBotMessage("I specialize in symptom analysis. Please describe any symptoms you're experiencing, and I'll provide targeted medical advice.\n\n**Example:** \"I have a headache and feel tired\"");
        }
    }

    addUserMessage(message) {
        const messagesContainer = document.getElementById('chat-messages');
        const messageDiv = document.createElement('div');
        messageDiv.className = 'message user-message';
        messageDiv.textContent = message;
        messagesContainer.appendChild(messageDiv);
        this.scrollToBottom();
    }

    addBotMessage(message) {
        const messagesContainer = document.getElementById('chat-messages');
        const messageDiv = document.createElement('div');
        messageDiv.className = 'message bot-message';
        
        // Handle markdown-style formatting
        const formattedMessage = message
            .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
            .replace(/\n/g, '<br>');
        
        messageDiv.innerHTML = formattedMessage;
        messagesContainer.appendChild(messageDiv);
        this.scrollToBottom();
    }

    showTyping() {
        document.getElementById('typing-indicator').style.display = 'block';
        this.scrollToBottom();
    }

    hideTyping() {
        document.getElementById('typing-indicator').style.display = 'none';
    }

    scrollToBottom() {
        const messagesContainer = document.getElementById('chat-messages');
        setTimeout(() => {
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }, 100);
    }

    handleFallbackProcessing(message) {
        const lowerMessage = message.toLowerCase();
        
        // Simple keyword detection for common symptoms
        const commonSymptoms = {
            'headache': 'head pain or migraine',
            'fever': 'high temperature',
            'cough': 'persistent coughing',
            'fatigue': 'tiredness or exhaustion',
            'chest pain': 'pain in chest area',
            'sore throat': 'throat pain',
            'stomach': 'abdominal discomfort',
            'nausea': 'feeling sick',
            'dizzy': 'dizziness or lightheadedness'
        };
        
        let foundSymptoms = [];
        for (let [keyword, description] of Object.entries(commonSymptoms)) {
            if (lowerMessage.includes(keyword)) {
                foundSymptoms.push(description);
            }
        }
        
        if (foundSymptoms.length > 0) {
            let response = `Here are a few advice according to your symptoms:\n\n`;
            response += `• Monitor your symptoms\n`;
            response += `• Stay hydrated and rest\n`;
            response += `• Consider over-the-counter remedies if appropriate\n`;
            response += `• Consult a healthcare provider if symptoms persist`;
            
            this.addBotMessage(response);
        } else {
            this.addBotMessage("Describe what you're feeling, like:\n\n• I have a headache\n• I feel tired and have fever\n• My stomach hurts");
        }
    }
}

// Initialize chatbot when page loads
document.addEventListener('DOMContentLoaded', () => {
    new HealthChatbot();
});
