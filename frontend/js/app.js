// Health Advice Expert System - Frontend JavaScript

class HealthExpertSystem {
    constructor() {
        this.selectedSymptoms = new Set();
        this.apiBaseUrl = '/health-expert/backend/api';
        this.init();
    }

    init() {
        this.bindEvents();
        this.loadSymptoms();
    }

    bindEvents() {
        const symptomInput = document.getElementById('symptom-search');
        const getAdviceBtn = document.getElementById('get-advice-btn');
        const symptomTags = document.getElementById('symptom-tags');

        // Symptom input events
        symptomInput.addEventListener('input', this.handleSymptomSearch.bind(this));
        symptomInput.addEventListener('keydown', this.handleKeydown.bind(this));
        
        // Get advice button
        getAdviceBtn.addEventListener('click', this.getHealthAdvice.bind(this));
        
        // Document click to hide suggestions
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.input-group')) {
                this.hideSuggestions();
            }
        });
    }

    async loadSymptoms() {
        try {
            console.log('Loading symptoms from:', `${this.apiBaseUrl}/symptoms.php`);
            const response = await fetch(`${this.apiBaseUrl}/symptoms.php`);
            console.log('Symptoms response status:', response.status);
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const data = await response.json();
            console.log('Symptoms data:', data);
            
            if (data.success) {
                this.symptoms = data.symptoms;
                console.log('Loaded', this.symptoms.length, 'symptoms');
            } else {
                console.error('Failed to load symptoms:', data.message);
                // Fallback to local symptoms if API fails
                this.symptoms = this.getFallbackSymptoms();
            }
        } catch (error) {
            console.error('Error loading symptoms:', error);
            // Fallback to local symptoms if API fails
            this.symptoms = this.getFallbackSymptoms();
        }
    }

    getFallbackSymptoms() {
        return [
            { id: 1, name: 'Headache', category: 'neurological' },
            { id: 2, name: 'Fever', category: 'general' },
            { id: 3, name: 'Cough', category: 'respiratory' },
            { id: 4, name: 'Sore throat', category: 'respiratory' },
            { id: 5, name: 'Runny nose', category: 'respiratory' },
            { id: 6, name: 'Fatigue', category: 'general' },
            { id: 7, name: 'Nausea', category: 'digestive' },
            { id: 8, name: 'Vomiting', category: 'digestive' },
            { id: 9, name: 'Diarrhea', category: 'digestive' },
            { id: 10, name: 'Stomach pain', category: 'digestive' },
            { id: 11, name: 'Back pain', category: 'musculoskeletal' },
            { id: 12, name: 'Joint pain', category: 'musculoskeletal' },
            { id: 13, name: 'Muscle aches', category: 'musculoskeletal' },
            { id: 14, name: 'Dizziness', category: 'neurological' },
            { id: 15, name: 'Chest pain', category: 'cardiac' },
            { id: 16, name: 'Shortness of breath', category: 'respiratory' },
            { id: 17, name: 'Skin rash', category: 'dermatological' },
            { id: 18, name: 'Itching', category: 'dermatological' },
            { id: 19, name: 'Constipation', category: 'digestive' },
            { id: 20, name: 'Insomnia', category: 'neurological' }
        ];
    }

    handleSymptomSearch(event) {
        const query = event.target.value.trim().toLowerCase();
        
        if (query.length < 2) {
            this.hideSuggestions();
            return;
        }

        const filteredSymptoms = this.symptoms.filter(symptom => 
            symptom.name.toLowerCase().includes(query) && 
            !this.selectedSymptoms.has(symptom.id)
        );

        this.showSuggestions(filteredSymptoms);
    }

    handleKeydown(event) {
        const suggestions = document.querySelectorAll('.suggestion-item');
        const activeSuggestion = document.querySelector('.suggestion-item.active');
        
        if (event.key === 'ArrowDown') {
            event.preventDefault();
            if (activeSuggestion) {
                activeSuggestion.classList.remove('active');
                const next = activeSuggestion.nextElementSibling || suggestions[0];
                next.classList.add('active');
            } else if (suggestions.length > 0) {
                suggestions[0].classList.add('active');
            }
        } else if (event.key === 'ArrowUp') {
            event.preventDefault();
            if (activeSuggestion) {
                activeSuggestion.classList.remove('active');
                const prev = activeSuggestion.previousElementSibling || suggestions[suggestions.length - 1];
                prev.classList.add('active');
            } else if (suggestions.length > 0) {
                suggestions[suggestions.length - 1].classList.add('active');
            }
        } else if (event.key === 'Enter') {
            event.preventDefault();
            if (activeSuggestion) {
                const symptomId = parseInt(activeSuggestion.dataset.id);
                this.addSymptom(symptomId);
            }
        } else if (event.key === 'Escape') {
            this.hideSuggestions();
        }
    }

    showSuggestions(symptoms) {
        const suggestionsContainer = document.getElementById('symptom-suggestions');
        
        if (symptoms.length === 0) {
            this.hideSuggestions();
            return;
        }

        suggestionsContainer.innerHTML = symptoms.map(symptom => 
            `<div class="suggestion-item" data-id="${symptom.id}">
                ${this.highlightMatch(symptom.name, document.getElementById('symptom-search').value)}
            </div>`
        ).join('');

        // Add click events to suggestions
        suggestionsContainer.querySelectorAll('.suggestion-item').forEach(item => {
            item.addEventListener('click', () => {
                const symptomId = parseInt(item.dataset.id);
                this.addSymptom(symptomId);
            });
        });

        suggestionsContainer.style.display = 'block';
    }

    hideSuggestions() {
        const suggestionsContainer = document.getElementById('symptom-suggestions');
        suggestionsContainer.style.display = 'none';
    }

    highlightMatch(text, query) {
        const regex = new RegExp(`(${query})`, 'gi');
        return text.replace(regex, '<strong>$1</strong>');
    }

    addSymptom(symptomId) {
        const symptom = this.symptoms.find(s => s.id === symptomId);
        if (symptom && !this.selectedSymptoms.has(symptomId)) {
            this.selectedSymptoms.add(symptomId);
            this.renderSymptomTags();
            this.clearInput();
            this.hideSuggestions();
            this.updateGetAdviceButton();
        }
    }

    removeSymptom(symptomId) {
        this.selectedSymptoms.delete(symptomId);
        this.renderSymptomTags();
        this.updateGetAdviceButton();
    }

    renderSymptomTags() {
        const symptomTagsContainer = document.getElementById('symptom-tags');
        
        if (this.selectedSymptoms.size === 0) {
            symptomTagsContainer.innerHTML = '<p style="color: #a0aec0; font-style: italic;">No symptoms selected yet</p>';
            return;
        }

        const selectedSymptomsArray = Array.from(this.selectedSymptoms).map(id => 
            this.symptoms.find(s => s.id === id)
        );

        symptomTagsContainer.innerHTML = selectedSymptomsArray.map(symptom => 
            `<span class="symptom-tag">
                ${symptom.name}
                <button class="remove-tag" onclick="healthSystem.removeSymptom(${symptom.id})" title="Remove symptom">
                    ×
                </button>
            </span>`
        ).join('');
    }

    clearInput() {
        document.getElementById('symptom-search').value = '';
    }

    updateGetAdviceButton() {
        const getAdviceBtn = document.getElementById('get-advice-btn');
        getAdviceBtn.disabled = this.selectedSymptoms.size === 0;
    }

    async getHealthAdvice() {
        if (this.selectedSymptoms.size === 0) return;

        this.showLoading();
        this.hideResults();

        try {
            const symptomIds = Array.from(this.selectedSymptoms);
            console.log('Requesting advice for symptoms:', symptomIds);
            console.log('API URL:', `${this.apiBaseUrl}/advice.php`);
            
            const response = await fetch(`${this.apiBaseUrl}/advice.php`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ symptoms: symptomIds })
            });

            console.log('Response status:', response.status);
            console.log('Response ok:', response.ok);

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            console.log('Response data:', data);
            
            if (data.success) {
                this.displayAdvice(data.advice);
            } else {
                this.displayError(data.message || 'Failed to get health advice');
            }
        } catch (error) {
            console.error('Error getting health advice:', error);
            this.displayError('Unable to connect to the server. Please try again. Error: ' + error.message);
        } finally {
            this.hideLoading();
        }
    }

    displayAdvice(adviceList) {
        const adviceContent = document.getElementById('advice-content');
        
        if (!adviceList || adviceList.length === 0) {
            adviceContent.innerHTML = `
                <div class="advice-item">
                    <div class="advice-title">No specific advice found</div>
                    <div class="advice-description">
                        We couldn't find specific advice for your combination of symptoms. 
                        Please consider consulting with a healthcare professional for personalized guidance.
                    </div>
                </div>
            `;
        } else {
            // Show selected symptoms context
            const selectedSymptomsNames = Array.from(this.selectedSymptoms).map(id => 
                this.symptoms.find(s => s.id === id)?.name
            ).filter(Boolean);
            
            adviceContent.innerHTML = `
                <div class="selected-symptoms-info">
                    <h4>💡 Based on your symptoms: ${selectedSymptomsNames.join(', ')}</h4>
                    <p>Showing only the most relevant advice (${adviceList.length} result${adviceList.length > 1 ? 's' : ''})</p>
                </div>
                ${adviceList.map((advice, index) => `
                    <div class="advice-item">
                        <div class="advice-header">
                            <div class="advice-title">${advice.title}</div>
                            <div class="relevance-info">
                                <span class="match-info">Matches ${advice.matching_symptoms} symptom(s)</span>
                                ${advice.symptom_match_percentage ? `
                                    <span class="match-percentage">${advice.symptom_match_percentage}% match</span>
                                ` : ''}
                                <span class="relevance-score">Score: ${advice.relevance_score || 'N/A'}</span>
                            </div>
                        </div>
                        <div class="advice-description">${advice.description}</div>
                        <div class="advice-recommendation">
                            <strong>Recommendation:</strong> ${advice.recommendation}
                        </div>
                        <span class="severity-level severity-${advice.severity_level.toLowerCase()}">
                            ${advice.severity_level} Priority
                        </span>
                        ${advice.when_to_see_doctor ? `
                            <div class="doctor-advice">
                                <strong>When to see a doctor:</strong> ${advice.when_to_see_doctor}
                            </div>
                        ` : ''}
                        ${advice.emergency_signs ? `
                            <div class="emergency-signs">
                                <strong>⚠️ Emergency signs:</strong> ${advice.emergency_signs}
                            </div>
                        ` : ''}
                    </div>
                `).join('')}
            `;
        }

        this.showResults();
    }

    displayError(message) {
        const adviceContent = document.getElementById('advice-content');
        adviceContent.innerHTML = `
            <div class="advice-item" style="border-left-color: #e53e3e;">
                <div class="advice-title" style="color: #e53e3e;">Error</div>
                <div class="advice-description">${message}</div>
            </div>
        `;
        this.showResults();
    }

    showLoading() {
        document.getElementById('loading-section').classList.remove('hidden');
    }

    hideLoading() {
        document.getElementById('loading-section').classList.add('hidden');
    }

    showResults() {
        document.getElementById('results-section').classList.remove('hidden');
        // Smooth scroll to results
        document.getElementById('results-section').scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    }

    hideResults() {
        document.getElementById('results-section').classList.add('hidden');
    }
}

// Initialize the system when the page loads
let healthSystem;
document.addEventListener('DOMContentLoaded', () => {
    healthSystem = new HealthExpertSystem();
});
