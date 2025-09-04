-- Enhanced Symptom-Advice Relationships
-- Creating intelligent connections between symptoms and advice

-- Continue the enhanced schema with comprehensive symptom-advice mappings
USE health_expert_system;

-- Create comprehensive symptom-advice relationships with weighted relevance
INSERT INTO symptom_advice (symptom_id, advice_id, weight) VALUES
-- Emergency Conditions
(1, 1, 1.00),   -- Chest pain -> Chest Pain Emergency
(3, 2, 1.00),   -- Shortness of breath -> Severe Breathing Difficulty  
(24, 2, 0.80),  -- Difficulty breathing -> Severe Breathing Difficulty
(10, 3, 1.00),  -- Seizures -> Seizure Emergency
(13, 4, 1.00),  -- Severe abdominal pain -> Severe Abdominal Pain
(49, 5, 1.00),  -- Allergic reactions -> Allergic Reaction Emergency
(43, 6, 1.00),  -- Blood in urine -> Blood in Urine Emergency
(45, 7, 1.00),  -- Kidney pain -> Kidney Pain Crisis
(29, 8, 1.00),  -- Skin lesions -> Skin Lesion Emergency
(12, 9, 1.00),  -- Vision changes -> Vision Loss Emergency
(48, 10, 1.00), -- Unexplained bleeding -> Abnormal Bleeding Emergency

-- High Priority Cardiovascular
(2, 11, 1.00),  -- Heart palpitations -> Heart Palpitation Management
(4, 32, 1.00),  -- Leg swelling -> Leg Swelling Management
(5, 33, 1.00),  -- High BP symptoms -> High Blood Pressure Crisis
(1, 11, 0.70),  -- Chest pain -> Heart Palpitation Management (secondary)
(3, 32, 0.60),  -- Shortness of breath -> Leg Swelling Management (related)

-- High Priority Respiratory  
(6, 12, 1.00),  -- Wheezing -> Wheezing Treatment
(7, 41, 1.00),  -- Persistent cough -> Persistent Cough Management
(24, 12, 0.90), -- Difficulty breathing -> Wheezing Treatment

-- High Priority Neurological
(7, 13, 1.00),  -- Severe headache -> Severe Headache Relief
(12, 14, 1.00), -- Vision changes -> Vision Problem Assessment
(9, 36, 1.00),  -- Memory problems -> Memory Problem Assessment
(8, 21, 1.00),  -- Dizziness -> Dizziness Management
(11, 22, 1.00), -- Numbness/tingling -> Numbness and Tingling Relief

-- High Priority Gastrointestinal
(16, 15, 1.00), -- Blood in stool -> Blood in Stool Evaluation
(13, 4, 0.80),  -- Severe abdominal pain -> Severe Abdominal Pain (secondary)

-- High Priority Endocrine
(19, 16, 1.00), -- Unexplained weight loss -> Unexplained Weight Loss Investigation
(21, 30, 1.00), -- Extreme fatigue -> Extreme Fatigue Recovery

-- High Priority Musculoskeletal
(24, 17, 1.00), -- Bone pain -> Bone Pain Assessment

-- High Priority Gynecological
(39, 18, 1.00), -- Abnormal bleeding -> Abnormal Gynecological Bleeding

-- High Priority ENT
(47, 19, 1.00), -- Hearing loss -> Hearing Loss Evaluation

-- High Priority Hematological
(48, 20, 1.00), -- Unexplained bleeding -> Unexplained Bleeding Assessment
(47, 51, 1.00), -- Easy bruising -> Easy Bruising Assessment

-- Medium Priority Respiratory
(6, 21, 0.80),  -- Persistent cough -> Persistent Cough Management
(9, 22, 1.00),  -- Sore throat -> Sore Throat Relief
(10, 23, 1.00), -- Runny nose -> Runny Nose Treatment
(12, 24, 1.00), -- Loss of smell/taste -> Loss of Smell/Taste Recovery

-- Medium Priority Neurological
(8, 25, 1.00),  -- Dizziness -> Dizziness Management
(11, 26, 1.00), -- Numbness/tingling -> Numbness and Tingling Relief

-- Medium Priority Gastrointestinal
(14, 27, 1.00), -- Nausea -> Nausea Control
(15, 28, 1.00), -- Vomiting -> Vomiting Management
(16, 29, 1.00), -- Diarrhea -> Diarrhea Treatment
(18, 30, 1.00), -- Heartburn -> Heartburn Relief

-- Medium Priority Musculoskeletal
(20, 31, 1.00), -- Back pain -> Back Pain Relief
(21, 32, 1.00), -- Joint pain -> Joint Pain Management
(22, 33, 1.00), -- Muscle weakness -> Muscle Weakness Assessment
(23, 34, 1.00), -- Neck stiffness -> Neck Stiffness Relief

-- Medium Priority Dermatological
(27, 35, 1.00), -- Severe itching -> Severe Itching Management

-- Medium Priority Endocrine
(24, 36, 1.00), -- Excessive thirst -> Excessive Thirst Control
(25, 37, 1.00), -- Frequent urination -> Frequent Urination Management
(21, 38, 1.00), -- Extreme fatigue -> Extreme Fatigue Recovery

-- Medium Priority Psychiatric
(30, 39, 1.00), -- Depression symptoms -> Depression Support
(31, 40, 1.00), -- Anxiety symptoms -> Anxiety Management
(32, 41, 1.00), -- Sleep disorders -> Sleep Disorder Treatment
(33, 42, 1.00), -- Mood swings -> Mood Swing Management

-- Medium Priority Infectious
(34, 43, 1.00), -- Fever -> Fever Management
(35, 44, 1.00), -- Chills -> Chills Treatment
(36, 45, 1.00), -- Body aches -> Body Aches Relief

-- Medium Priority Gynecological
(37, 46, 1.00), -- Irregular periods -> Irregular Period Management
(38, 47, 1.00), -- Pelvic pain -> Pelvic Pain Relief

-- Medium Priority Urological
(40, 48, 1.00), -- Painful urination -> Painful Urination Treatment

-- Medium Priority ENT
(44, 49, 1.00), -- Ear pain -> Ear Pain Relief

-- Medium Priority Hematological
(47, 50, 1.00), -- Easy bruising -> Easy Bruising Assessment

-- Low Priority Conditions
(17, 51, 1.00), -- Constipation -> Constipation Relief
(26, 52, 1.00), -- Skin rash -> Skin Rash Care
(46, 53, 1.00), -- Red eyes -> Red Eyes Treatment
(48, 54, 1.00), -- Tinnitus -> Tinnitus Management
(50, 55, 1.00), -- Frequent infections -> Frequent Infections Prevention

-- Complex Multi-symptom Relationships
-- Common Cold Syndrome
(6, 56, 0.90),  -- Persistent cough -> Common Cold Management
(9, 56, 1.00),  -- Sore throat -> Common Cold Management  
(10, 56, 1.00), -- Runny nose -> Common Cold Management
(34, 56, 0.70), -- Fever -> Common Cold Management
(36, 56, 0.60), -- Body aches -> Common Cold Management

-- Migraine/Headache Complex
(7, 57, 1.00),  -- Severe headache -> Mild Headache Relief
(8, 57, 0.70),  -- Dizziness -> Mild Headache Relief
(12, 57, 0.60), -- Vision changes -> Mild Headache Relief

-- Seasonal Allergies
(10, 58, 1.00), -- Runny nose -> Seasonal Allergy Management
(26, 58, 0.80), -- Skin rash -> Seasonal Allergy Management
(46, 58, 0.70), -- Red eyes -> Seasonal Allergy Management

-- Digestive Syndrome
(14, 67, 0.80), -- Nausea -> Occasional Indigestion
(17, 67, 0.90), -- Constipation -> Occasional Indigestion
(18, 67, 1.00), -- Heartburn -> Occasional Indigestion

-- Stress/Anxiety Complex
(31, 68, 0.80), -- Anxiety symptoms -> Mild Anxiety Episodes
(32, 68, 0.70), -- Sleep disorders -> Mild Anxiety Episodes
(33, 68, 0.60), -- Mood swings -> Mild Anxiety Episodes

-- Fatigue Syndrome
(21, 75, 0.80), -- Extreme fatigue -> Mild Fatigue
(32, 69, 1.00), -- Sleep disorders -> Occasional Sleeplessness
(30, 75, 0.60), -- Depression -> Mild Fatigue

-- Upper Respiratory Complex
(6, 76, 0.70),  -- Persistent cough -> Minor Nasal Congestion
(9, 76, 0.80),  -- Sore throat -> Minor Nasal Congestion
(10, 76, 1.00), -- Runny nose -> Minor Nasal Congestion

-- Musculoskeletal Pain Complex
(20, 72, 0.80), -- Back pain -> Minor Muscle Strains
(21, 66, 1.00), -- Joint pain -> Mild Joint Stiffness
(22, 72, 0.90), -- Muscle weakness -> Minor Muscle Strains
(23, 72, 0.70), -- Neck stiffness -> Minor Muscle Strains

-- Eye/Vision Complex
(12, 83, 0.70), -- Vision changes -> Mild Eye Strain
(41, 83, 0.60), -- Eye pain -> Mild Eye Strain
(46, 83, 0.80), -- Red eyes -> Mild Eye Strain

-- Skin Care Complex
(26, 59, 1.00), -- Skin rash -> Dry Skin Care
(27, 59, 0.80), -- Severe itching -> Dry Skin Care
(28, 59, 0.70), -- Unusual moles -> Dry Skin Care

-- Urological Complex
(25, 86, 0.70), -- Frequent urination -> Occasional Urinary Urgency
(40, 86, 0.80), -- Painful urination -> Occasional Urinary Urgency
(43, 86, 0.60), -- Blood in urine -> Occasional Urinary Urgency

-- Additional complex relationships for comprehensive coverage
(34, 78, 0.80), -- Fever -> Minor Aches and Pains
(35, 78, 0.90), -- Chills -> Minor Aches and Pains
(36, 78, 1.00), -- Body aches -> Minor Aches and Pains

-- Endocrine/Metabolic Complex
(24, 91, 0.70), -- Excessive thirst -> Mild Hydration Imbalance
(25, 91, 0.80), -- Frequent urination -> Mild Hydration Imbalance
(19, 84, 0.60), -- Unexplained weight loss -> Mild Appetite Changes

-- Ear/Hearing Complex
(44, 87, 0.70), -- Ear pain -> Minor Hearing Changes
(47, 87, 1.00), -- Hearing loss -> Minor Hearing Changes
(48, 87, 0.80), -- Tinnitus -> Minor Hearing Changes

-- Circulation/Cardiovascular Complex
(2, 92, 0.60), -- Heart palpitations -> Minor Circulation Issues
(4, 92, 0.80), -- Leg swelling -> Minor Circulation Issues
(3, 92, 0.70), -- Shortness of breath -> Minor Circulation Issues

-- Coordination/Balance Complex
(8, 94, 1.00), -- Dizziness -> Minor Balance Fluctuations
(9, 89, 0.60), -- Memory problems -> Minor Coordination Changes
(11, 89, 0.70), -- Numbness/tingling -> Minor Coordination Changes

-- Voice/Throat Complex
(9, 93, 1.00), -- Sore throat -> Occasional Voice Changes
(95, 93, 0.80), -- Minor throat irritation -> Occasional Voice Changes

-- Temperature Regulation Complex
(34, 90, 0.80), -- Fever -> Occasional Temperature Sensitivity
(35, 90, 1.00), -- Chills -> Occasional Temperature Sensitivity

-- Sleep/Energy Complex
(32, 85, 0.80), -- Sleep disorders -> Occasional Energy Dips
(21, 85, 0.90), -- Extreme fatigue -> Occasional Energy Dips
(30, 85, 0.70); -- Depression -> Occasional Energy Dips
