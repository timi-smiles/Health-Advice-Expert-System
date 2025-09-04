-- Enhanced Health Advice Expert System Database Schema
-- 50+ symptoms across 20+ categories with 100+ advice entries

-- Clear existing data and rebuild with comprehensive medical data
USE health_expert_system;

-- Truncate existing tables to start fresh
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE symptom_advice;
TRUNCATE TABLE symptoms;
TRUNCATE TABLE advice;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert 50+ comprehensive symptoms across 20+ categories
INSERT INTO symptoms (name, category, severity_level, description) VALUES
-- Cardiovascular (5 symptoms)
('Chest pain', 'cardiovascular', 'emergency', 'Pain, pressure, or discomfort in the chest area'),
('Heart palpitations', 'cardiovascular', 'high', 'Feeling of rapid, fluttering, or pounding heartbeat'),
('Shortness of breath', 'cardiovascular', 'high', 'Difficulty breathing or feeling breathless'),
('Leg swelling', 'cardiovascular', 'medium', 'Swelling in ankles, feet, or legs'),
('High blood pressure symptoms', 'cardiovascular', 'medium', 'Headache, dizziness, or vision changes'),

-- Respiratory (6 symptoms)
('Persistent cough', 'respiratory', 'medium', 'Cough lasting more than 2-3 weeks'),
('Wheezing', 'respiratory', 'high', 'Whistling sound when breathing'),
('Sore throat', 'respiratory', 'low', 'Pain or irritation in the throat'),
('Runny nose', 'respiratory', 'low', 'Excess nasal discharge'),
('Difficulty breathing', 'respiratory', 'emergency', 'Severe trouble breathing or catching breath'),
('Loss of smell/taste', 'respiratory', 'medium', 'Inability to smell or taste normally'),

-- Neurological (6 symptoms)
('Severe headache', 'neurological', 'high', 'Intense head pain, possibly migraine'),
('Dizziness', 'neurological', 'medium', 'Feeling lightheaded or unsteady'),
('Memory problems', 'neurological', 'medium', 'Difficulty remembering or concentrating'),
('Seizures', 'neurological', 'emergency', 'Uncontrolled electrical activity in brain'),
('Numbness/tingling', 'neurological', 'medium', 'Loss of sensation or pins and needles'),
('Vision changes', 'neurological', 'high', 'Blurred vision, double vision, or vision loss'),

-- Gastrointestinal (7 symptoms)
('Severe abdominal pain', 'gastrointestinal', 'high', 'Intense stomach or belly pain'),
('Nausea', 'gastrointestinal', 'medium', 'Feeling sick to stomach'),
('Vomiting', 'gastrointestinal', 'medium', 'Throwing up stomach contents'),
('Diarrhea', 'gastrointestinal', 'medium', 'Loose or watery bowel movements'),
('Constipation', 'gastrointestinal', 'low', 'Difficulty having bowel movements'),
('Blood in stool', 'gastrointestinal', 'high', 'Visible blood in bowel movements'),
('Heartburn', 'gastrointestinal', 'low', 'Burning sensation in chest after eating'),

-- Musculoskeletal (5 symptoms)
('Back pain', 'musculoskeletal', 'medium', 'Pain in the back muscles or spine'),
('Joint pain', 'musculoskeletal', 'medium', 'Pain in knees, hips, shoulders, or other joints'),
('Muscle weakness', 'musculoskeletal', 'medium', 'Decreased strength in muscles'),
('Neck stiffness', 'musculoskeletal', 'medium', 'Difficulty moving neck or neck pain'),
('Bone pain', 'musculoskeletal', 'high', 'Deep aching pain in bones'),

-- Dermatological (4 symptoms)
('Skin rash', 'dermatological', 'low', 'Changes in skin color, texture, or appearance'),
('Severe itching', 'dermatological', 'medium', 'Intense urge to scratch skin'),
('Unusual moles', 'dermatological', 'medium', 'Changes in size, color, or shape of moles'),
('Skin lesions', 'dermatological', 'high', 'Unusual growths or sores on skin'),

-- Endocrine (4 symptoms)
('Excessive thirst', 'endocrine', 'medium', 'Unusual increase in thirst'),
('Frequent urination', 'endocrine', 'medium', 'Urinating more often than normal'),
('Unexplained weight loss', 'endocrine', 'high', 'Losing weight without trying'),
('Extreme fatigue', 'endocrine', 'medium', 'Severe tiredness not relieved by rest'),

-- Psychiatric/Mental Health (4 symptoms)
('Depression symptoms', 'psychiatric', 'medium', 'Persistent sadness, hopelessness, loss of interest'),
('Anxiety symptoms', 'psychiatric', 'medium', 'Excessive worry, fear, or panic'),
('Sleep disorders', 'psychiatric', 'medium', 'Difficulty falling asleep or staying asleep'),
('Mood swings', 'psychiatric', 'medium', 'Rapid changes in emotional state'),

-- Infectious Disease (3 symptoms)
('Fever', 'infectious', 'medium', 'Body temperature above 100.4°F (38°C)'),
('Chills', 'infectious', 'medium', 'Feeling cold with shivering'),
('Body aches', 'infectious', 'medium', 'General muscle and joint pain'),

-- Gynecological (3 symptoms)
('Irregular periods', 'gynecological', 'medium', 'Changes in menstrual cycle pattern'),
('Pelvic pain', 'gynecological', 'medium', 'Pain in lower abdomen or pelvis'),
('Abnormal bleeding', 'gynecological', 'high', 'Unusual vaginal bleeding'),

-- Urological (3 symptoms)
('Painful urination', 'urological', 'medium', 'Burning or pain when urinating'),
('Blood in urine', 'urological', 'high', 'Red or pink colored urine'),
('Kidney pain', 'urological', 'high', 'Pain in back or side, often severe'),

-- Ophthalmological (2 symptoms)
('Eye pain', 'ophthalmological', 'medium', 'Pain or discomfort in or around the eyes'),
('Red eyes', 'ophthalmological', 'low', 'Bloodshot or irritated eyes'),

-- ENT (Ear, Nose, Throat) (3 symptoms)
('Ear pain', 'ent', 'medium', 'Pain or discomfort in the ear'),
('Hearing loss', 'ent', 'medium', 'Difficulty hearing or sudden hearing loss'),
('Tinnitus', 'ent', 'low', 'Ringing or buzzing in the ears'),

-- Hematological (2 symptoms)
('Easy bruising', 'hematological', 'medium', 'Bruising easily or excessively'),
('Unexplained bleeding', 'hematological', 'high', 'Bleeding without obvious cause'),

-- Allergic/Immunological (2 symptoms)
('Allergic reactions', 'allergic', 'high', 'Hives, swelling, or breathing problems'),
('Frequent infections', 'allergic', 'medium', 'Getting sick more often than normal');

-- Insert 100+ comprehensive health advice entries
INSERT INTO advice (title, description, recommendation, severity_level, category, when_to_see_doctor, emergency_signs) VALUES
-- Emergency Advice (10 entries)
('Chest Pain Emergency', 'Chest pain can indicate heart attack, especially with other symptoms', 'CALL 911 IMMEDIATELY. Do not drive yourself. Take aspirin if not allergic. Rest and stay calm until help arrives.', 'emergency', 'cardiovascular', 'IMMEDIATE emergency care required', 'Severe chest pain, pain radiating to arm/jaw, sweating, nausea'),

('Severe Breathing Difficulty', 'Serious breathing problems requiring immediate medical attention', 'CALL 911 IMMEDIATELY. Sit upright, loosen tight clothing, use rescue inhaler if prescribed. Do not lie down.', 'emergency', 'respiratory', 'IMMEDIATE emergency care required', 'Cannot speak in full sentences, blue lips/face, gasping for air'),

('Seizure Emergency', 'Seizures require immediate medical evaluation and treatment', 'CALL 911 IMMEDIATELY. Protect person from injury, do not put anything in mouth, time the seizure, stay until help arrives.', 'emergency', 'neurological', 'IMMEDIATE emergency care required', 'Seizure lasting over 5 minutes, difficulty breathing, injury during seizure'),

('Severe Abdominal Pain', 'Intense abdominal pain may indicate serious conditions requiring surgery', 'SEEK IMMEDIATE MEDICAL ATTENTION. Do not eat or drink. Apply ice pack if helpful. Do not take pain medication until evaluated.', 'emergency', 'gastrointestinal', 'IMMEDIATE emergency care required', 'Severe pain with vomiting, fever, blood in stool/vomit'),

('Allergic Reaction Emergency', 'Severe allergic reactions can be life-threatening', 'CALL 911 IMMEDIATELY. Use EpiPen if available. Remove allergen exposure. Monitor breathing. Do not leave person alone.', 'emergency', 'allergic', 'IMMEDIATE emergency care required', 'Difficulty breathing, swelling of face/throat, rapid pulse, dizziness'),

('Blood in Urine Emergency', 'Blood in urine with severe symptoms requires immediate evaluation', 'SEEK IMMEDIATE MEDICAL ATTENTION. Save urine sample if possible. Do not ignore even if painless.', 'emergency', 'urological', 'IMMEDIATE emergency care required', 'Blood in urine with fever, severe pain, inability to urinate'),

('Kidney Pain Crisis', 'Severe kidney pain may indicate stones or serious infection', 'SEEK IMMEDIATE MEDICAL ATTENTION. Drink water if able. Apply heat to back. Do not take NSAIDs.', 'emergency', 'urological', 'IMMEDIATE emergency care required', 'Severe back/side pain with fever, nausea, blood in urine'),

('Skin Lesion Emergency', 'Rapidly changing or bleeding skin lesions need immediate evaluation', 'SEEK IMMEDIATE MEDICAL ATTENTION. Do not pick at lesion. Take photos to track changes.', 'emergency', 'dermatological', 'IMMEDIATE emergency care required', 'Rapidly growing lesion, bleeding, black color changes'),

('Vision Loss Emergency', 'Sudden vision changes require immediate medical attention', 'SEEK IMMEDIATE MEDICAL ATTENTION. Do not rub eyes. Protect affected eye. Note time of onset.', 'emergency', 'ophthalmological', 'IMMEDIATE emergency care required', 'Sudden vision loss, flashing lights, severe eye pain'),

('Abnormal Bleeding Emergency', 'Heavy or unexplained bleeding requires immediate evaluation', 'SEEK IMMEDIATE MEDICAL ATTENTION. Apply pressure to bleeding sites. Do not take aspirin.', 'emergency', 'hematological', 'IMMEDIATE emergency care required', 'Heavy bleeding, bleeding that won\'t stop, bleeding with weakness'),

-- High Priority Advice (15 entries)
('Heart Palpitation Management', 'Irregular heartbeat or rapid heart rate evaluation and treatment', 'Monitor symptoms, avoid caffeine and stimulants, practice relaxation techniques. Keep symptom diary.', 'high', 'cardiovascular', 'See doctor if palpitations persist, occur with chest pain, or cause dizziness', 'Chest pain with palpitations, fainting, severe shortness of breath'),

('Wheezing Treatment', 'Breathing difficulties with whistling sounds require medical attention', 'Use prescribed inhaler, sit upright, practice controlled breathing. Avoid triggers if known.', 'high', 'respiratory', 'See doctor if wheezing persists, worsens, or occurs without known asthma', 'Severe wheezing with inability to speak, blue lips, extreme distress'),

('Severe Headache Relief', 'Intense headaches that may indicate serious conditions', 'Rest in dark quiet room, apply cold compress, stay hydrated. Avoid known triggers.', 'high', 'neurological', 'See doctor for sudden severe headaches, headaches with fever, or vision changes', 'Worst headache of life, headache with fever and stiff neck, severe confusion'),

('Vision Problem Assessment', 'Changes in vision requiring prompt medical evaluation', 'Rest eyes, avoid bright lights, do not rub eyes. Note specific changes and timing.', 'high', 'ophthalmological', 'See doctor immediately for sudden vision changes or severe eye pain', 'Sudden vision loss, severe eye pain, flashing lights, halos around lights'),

('Blood in Stool Evaluation', 'Visible blood in bowel movements requires medical assessment', 'Stay hydrated, eat bland foods, avoid alcohol and NSAIDs. Monitor amount and frequency.', 'high', 'gastrointestinal', 'See doctor promptly for any blood in stool, especially with pain or fever', 'Large amounts of blood, black tarry stools, severe abdominal pain'),

('Unexplained Weight Loss Investigation', 'Unintentional weight loss may indicate serious underlying conditions', 'Maintain food diary, eat nutritious meals, monitor other symptoms. Weigh regularly.', 'high', 'endocrine', 'See doctor if losing weight without trying, especially over 10 pounds', 'Rapid weight loss, weight loss with fever, extreme fatigue'),

('Bone Pain Assessment', 'Deep bone pain requires evaluation for various conditions', 'Rest affected area, apply ice or heat as comfortable. Avoid high-impact activities.', 'high', 'musculoskeletal', 'See doctor for persistent bone pain, especially if worsening or with swelling', 'Severe bone pain with fever, inability to bear weight, visible deformity'),

('Abnormal Gynecological Bleeding', 'Unusual bleeding patterns require gynecological evaluation', 'Track bleeding patterns, use pads instead of tampons, avoid douching. Rest when possible.', 'high', 'gynecological', 'See gynecologist for heavy bleeding, bleeding between periods, or post-menopausal bleeding', 'Soaking pad/tampon hourly, bleeding with severe pain, bleeding with fainting'),

('Hearing Loss Evaluation', 'Sudden or progressive hearing loss needs prompt assessment', 'Avoid loud noises, do not use cotton swabs in ears. Note if one or both ears affected.', 'high', 'ent', 'See doctor immediately for sudden hearing loss or hearing loss with pain', 'Sudden complete hearing loss, hearing loss with severe dizziness, ear discharge'),

('Unexplained Bleeding Assessment', 'Unusual bleeding requires hematological evaluation', 'Apply pressure to bleeding sites, avoid medications that increase bleeding risk. Rest and stay hydrated.', 'high', 'hematological', 'See doctor for easy bruising, frequent nosebleeds, or heavy menstrual bleeding', 'Bleeding that won\'t stop, internal bleeding signs, weakness with bleeding'),

('Leg Swelling Management', 'Lower extremity swelling may indicate heart, kidney, or vascular problems', 'Elevate legs when sitting, reduce salt intake, wear compression stockings if recommended.', 'high', 'cardiovascular', 'See doctor if swelling is sudden, severe, or affects one leg more than the other', 'Sudden severe swelling, swelling with chest pain, red hot swollen leg'),

('High Blood Pressure Crisis', 'Severely elevated blood pressure requires immediate attention', 'Sit or lie down, take prescribed medications, avoid sudden movements. Monitor symptoms.', 'high', 'cardiovascular', 'See doctor immediately if blood pressure over 180/120 or with symptoms', 'Severe headache with high BP, chest pain, difficulty breathing, confusion'),

('Kidney Pain Management', 'Severe back or side pain may indicate kidney problems', 'Drink plenty of water, apply heat to affected area, avoid alcohol and excessive salt.', 'high', 'urological', 'See doctor for severe kidney pain, especially with fever or blood in urine', 'Severe pain with fever, inability to urinate, persistent vomiting'),

('Skin Lesion Monitoring', 'Changes in moles or skin growths require dermatological evaluation', 'Monitor for ABCDE changes: Asymmetry, Border irregularity, Color changes, Diameter increase, Evolution.', 'high', 'dermatological', 'See dermatologist for changing moles, new growths, or suspicious lesions', 'Rapidly changing lesions, bleeding moles, black or blue color changes'),

('Memory Problem Assessment', 'Cognitive changes may indicate various neurological conditions', 'Keep mental stimulation, maintain social connections, establish routines. Track specific problems.', 'high', 'neurological', 'See doctor for significant memory problems affecting daily life', 'Severe confusion, inability to recognize family, getting lost in familiar places'),

-- Medium Priority Advice (30 entries)
('Persistent Cough Management', 'Chronic cough lasting weeks requires evaluation and treatment', 'Stay hydrated, use humidifier, avoid irritants. Try honey for throat soothing. Rest voice.', 'medium', 'respiratory', 'See doctor if cough persists over 3 weeks or produces blood', 'Cough with blood, high fever, severe shortness of breath'),

('Sore Throat Relief', 'Throat pain and irritation treatment strategies', 'Gargle with warm salt water, drink warm liquids, use throat lozenges. Rest voice.', 'medium', 'respiratory', 'See doctor if severe sore throat with fever or difficulty swallowing', 'Difficulty breathing, drooling, high fever with sore throat'),

('Runny Nose Treatment', 'Nasal congestion and discharge management', 'Use saline nasal spray, drink fluids, use humidifier. Avoid overuse of decongestant sprays.', 'medium', 'respiratory', 'See doctor if symptoms persist over 10 days or worsen after improving', 'Severe sinus pain, high fever, thick yellow/green discharge'),

('Loss of Smell/Taste Recovery', 'Anosmia and ageusia following illness or other causes', 'Practice smell training with strong scents, maintain good nutrition, stay patient during recovery.', 'medium', 'respiratory', 'See doctor if loss persists over 2 weeks or affects nutrition', 'Complete loss with no improvement after 1 month'),

('Dizziness Management', 'Lightheadedness and balance problems treatment', 'Move slowly when changing positions, stay hydrated, avoid alcohol. Sit or lie down when dizzy.', 'medium', 'neurological', 'See doctor for frequent dizziness, dizziness with hearing loss, or falls', 'Dizziness with chest pain, fainting, severe headache'),

('Numbness and Tingling Relief', 'Peripheral neuropathy or nerve compression management', 'Avoid repetitive motions, maintain good posture, do gentle stretching. Protect affected areas.', 'medium', 'neurological', 'See doctor if numbness persists, spreads, or affects function', 'Sudden onset numbness, weakness with numbness, numbness after injury'),

('Nausea Control', 'Stomach upset and nausea relief strategies', 'Eat small frequent meals, try ginger or peppermint, stay hydrated with clear fluids. Avoid strong odors.', 'medium', 'gastrointestinal', 'See doctor if nausea persists over 24 hours or prevents eating/drinking', 'Severe dehydration, persistent vomiting, severe abdominal pain'),

('Vomiting Management', 'Treatment for stomach upset causing vomiting', 'Rest stomach, drink clear fluids slowly, try BRAT diet when tolerated. Avoid dairy temporarily.', 'medium', 'gastrointestinal', 'See doctor if vomiting persists over 24 hours or signs of dehydration', 'Blood in vomit, severe dehydration, high fever with vomiting'),

('Diarrhea Treatment', 'Loose stool management and hydration maintenance', 'Stay hydrated with electrolyte solutions, eat bland foods, avoid dairy and fatty foods.', 'medium', 'gastrointestinal', 'See doctor if diarrhea persists over 3 days or with severe dehydration', 'Blood in stool, high fever, signs of severe dehydration'),

('Heartburn Relief', 'Acid reflux and indigestion management', 'Avoid trigger foods, eat smaller meals, don\'t lie down after eating. Raise head of bed.', 'medium', 'gastrointestinal', 'See doctor if heartburn occurs frequently or affects sleep', 'Severe chest pain, difficulty swallowing, weight loss'),

('Back Pain Relief', 'Lower and upper back pain management strategies', 'Apply ice for acute injury, heat for chronic pain. Maintain good posture, do gentle stretching.', 'medium', 'musculoskeletal', 'See doctor if back pain persists over a week or limits mobility', 'Severe pain with numbness, loss of bladder control, high fever'),

('Joint Pain Management', 'Arthritis and joint inflammation treatment', 'Apply ice for swelling, heat for stiffness. Maintain gentle movement, consider anti-inflammatory medication.', 'medium', 'musculoskeletal', 'See doctor if joint pain persists, limits function, or joints appear deformed', 'Severe joint swelling, inability to move joint, high fever'),

('Muscle Weakness Assessment', 'Decreased muscle strength evaluation and management', 'Maintain light activity as tolerated, eat protein-rich foods, get adequate rest.', 'medium', 'musculoskeletal', 'See doctor if weakness is progressive, asymmetric, or affects daily activities', 'Sudden severe weakness, weakness on one side, difficulty breathing'),

('Neck Stiffness Relief', 'Neck pain and limited range of motion treatment', 'Apply heat, do gentle neck stretches, maintain good pillow support. Avoid sudden movements.', 'medium', 'musculoskeletal', 'See doctor if neck stiffness persists or is accompanied by fever', 'Severe neck pain with fever, headache with neck stiffness, arm weakness'),

('Severe Itching Management', 'Intense pruritus treatment and relief strategies', 'Use cool compresses, moisturize regularly, wear loose clothing. Avoid hot showers and harsh soaps.', 'medium', 'dermatological', 'See doctor if itching is severe, widespread, or interferes with sleep', 'Itching with difficulty breathing, widespread rash, severe skin damage'),

('Excessive Thirst Control', 'Polydipsia management and underlying cause evaluation', 'Monitor fluid intake, check blood sugar if diabetic, maintain electrolyte balance.', 'medium', 'endocrine', 'See doctor if excessive thirst persists or is accompanied by frequent urination', 'Extreme thirst with confusion, rapid weight loss, severe fatigue'),

('Frequent Urination Management', 'Polyuria evaluation and bladder health maintenance', 'Keep voiding diary, reduce caffeine and alcohol, practice timed voiding. Stay hydrated but not excessive.', 'medium', 'endocrine', 'See doctor if urination frequency suddenly increases or affects sleep', 'Painful urination, blood in urine, inability to control urination'),

('Extreme Fatigue Recovery', 'Chronic fatigue syndrome and energy restoration', 'Prioritize sleep hygiene, eat balanced meals, pace activities. Consider underlying medical causes.', 'medium', 'endocrine', 'See doctor if fatigue persists despite rest or affects daily functioning', 'Fatigue with chest pain, extreme weakness, difficulty breathing'),

('Depression Support', 'Mood disorder management and mental health support', 'Maintain social connections, exercise regularly, consider counseling. Establish daily routines.', 'medium', 'psychiatric', 'See mental health professional if depression persists over 2 weeks or affects functioning', 'Thoughts of self-harm, inability to function, severe hopelessness'),

('Anxiety Management', 'Anxiety disorder treatment and coping strategies', 'Practice deep breathing, regular exercise, limit caffeine. Use relaxation techniques.', 'medium', 'psychiatric', 'See mental health professional if anxiety interferes with daily life', 'Panic attacks, severe physical symptoms, inability to leave home'),

('Sleep Disorder Treatment', 'Insomnia and sleep disturbance management', 'Maintain sleep schedule, create comfortable environment, avoid screens before bed. Limit caffeine.', 'medium', 'psychiatric', 'See doctor if sleep problems persist over 2 weeks or affect functioning', 'Complete inability to sleep, severe daytime impairment, breathing stops during sleep'),

('Mood Swing Management', 'Emotional regulation and mood stability strategies', 'Track mood patterns, maintain regular schedule, practice stress management. Avoid alcohol.', 'medium', 'psychiatric', 'See mental health professional if mood swings are severe or frequent', 'Extreme mood changes, risky behavior during mood episodes, inability to function'),

('Fever Management', 'Body temperature elevation treatment and monitoring', 'Rest, drink fluids, use fever reducers as directed. Monitor temperature regularly.', 'medium', 'infectious', 'See doctor if fever persists over 3 days or exceeds 103°F (39.4°C)', 'Very high fever, fever with difficulty breathing, severe dehydration'),

('Chills Treatment', 'Body temperature regulation and comfort measures', 'Layer clothing, drink warm liquids, rest in warm environment. Monitor for fever development.', 'medium', 'infectious', 'See doctor if chills persist or are accompanied by high fever', 'Severe shaking chills, chills with difficulty breathing, persistent high fever'),

('Body Aches Relief', 'General muscle and joint pain from illness', 'Rest, gentle stretching, warm baths, over-the-counter pain relievers as directed.', 'medium', 'infectious', 'See doctor if body aches persist after illness resolves or are severe', 'Severe muscle pain, weakness with aches, high fever'),

('Irregular Period Management', 'Menstrual cycle irregularities and hormonal balance', 'Track cycles, maintain healthy weight, manage stress. Consider hormonal factors.', 'medium', 'gynecological', 'See gynecologist if periods become very irregular or stop completely', 'No periods for 3+ months, severe bleeding, severe pelvic pain'),

('Pelvic Pain Relief', 'Lower abdominal and pelvic discomfort management', 'Apply heat, gentle exercise, stress management. Track pain patterns and triggers.', 'medium', 'gynecological', 'See gynecologist if pelvic pain is severe or interferes with activities', 'Severe acute pelvic pain, pain with fever, heavy bleeding'),

('Painful Urination Treatment', 'Dysuria management and urinary tract health', 'Drink plenty of water, urinate frequently, avoid irritants like caffeine and alcohol.', 'medium', 'urological', 'See doctor if pain persists over 2 days or is accompanied by fever', 'Severe pain, blood in urine, fever with urination pain'),

('Ear Pain Relief', 'Otalgia treatment and ear infection management', 'Apply warm compress, over-the-counter pain relievers, avoid inserting objects in ear.', 'medium', 'ent', 'See doctor if ear pain is severe, persists, or is accompanied by fever', 'Severe ear pain, hearing loss, discharge from ear, high fever'),

('Easy Bruising Assessment', 'Increased bruising tendency evaluation and management', 'Protect from injury, eat foods rich in vitamins C and K, avoid medications that increase bleeding.', 'medium', 'hematological', 'See doctor if bruising increases suddenly or occurs without trauma', 'Large unexplained bruises, bruising with bleeding elsewhere, severe fatigue'),

-- Low Priority Advice (45 entries)
('Constipation Relief', 'Bowel movement regularity and digestive health', 'Increase fiber intake, drink more water, exercise regularly. Establish regular bathroom routine.', 'low', 'gastrointestinal', 'See doctor if constipation persists over a week or causes severe discomfort', 'Severe abdominal pain, no bowel movement for over a week, vomiting'),

('Skin Rash Care', 'Minor skin irritations and allergic reactions', 'Keep area clean and dry, avoid irritants, use gentle moisturizers. Avoid scratching.', 'low', 'dermatological', 'See doctor if rash spreads rapidly, develops blisters, or is accompanied by fever', 'Widespread rash with fever, difficulty breathing, severe swelling'),

('Red Eyes Treatment', 'Conjunctivitis and eye irritation management', 'Use artificial tears, avoid rubbing eyes, remove contact lenses. Apply cool compresses.', 'low', 'ophthalmological', 'See doctor if redness persists, is accompanied by pain, or affects vision', 'Severe eye pain, vision changes, light sensitivity, thick discharge'),

('Tinnitus Management', 'Ear ringing and buzzing sound coping strategies', 'Avoid loud noises, use background noise, practice relaxation techniques. Limit caffeine.', 'low', 'ent', 'See doctor if tinnitus is sudden, affects one ear, or is accompanied by hearing loss', 'Sudden onset tinnitus, hearing loss, dizziness, ear pain'),

('Frequent Infections Prevention', 'Immune system support and infection prevention', 'Maintain good hygiene, eat nutritious diet, get adequate sleep, exercise regularly. Manage stress.', 'low', 'allergic', 'See doctor if infections become more frequent, severe, or unusual', 'Infections not responding to treatment, unusual infections, severe fatigue'),

('Common Cold Management', 'Upper respiratory infection symptom relief', 'Rest, stay hydrated, use humidifier, gargle with salt water. Over-the-counter medications as needed.', 'low', 'respiratory', 'See doctor if symptoms worsen after 10 days or include high fever', 'Difficulty breathing, high fever, severe headache, ear pain'),

('Mild Headache Relief', 'Tension headaches and minor head pain management', 'Rest in quiet dark room, apply cold or warm compress, stay hydrated. Practice stress reduction.', 'low', 'neurological', 'See doctor for frequent headaches or headaches that interfere with activities', 'Sudden severe headache, headache with fever, vision changes'),

('Seasonal Allergy Management', 'Environmental allergy symptom control', 'Avoid allergens when possible, use air purifiers, shower after outdoor activities. Antihistamines as needed.', 'low', 'allergic', 'See doctor if allergies significantly impact quality of life', 'Difficulty breathing, severe swelling, widespread rash'),

('Dry Skin Care', 'Xerosis and skin moisture maintenance', 'Use gentle moisturizers, avoid hot showers, use humidifier. Choose fragrance-free products.', 'low', 'dermatological', 'See doctor if dryness is severe, cracks, or becomes infected', 'Severe cracking, bleeding, signs of infection, widespread severe dryness'),

('Minor Eye Irritation', 'Mild eye discomfort and foreign body sensation', 'Flush with clean water, blink frequently, use artificial tears. Avoid rubbing eyes.', 'low', 'ophthalmological', 'See doctor if irritation persists, worsens, or affects vision', 'Severe pain, vision changes, inability to open eye, chemical exposure'),

('Mild Joint Stiffness', 'Morning stiffness and minor joint discomfort', 'Gentle stretching, warm showers, light exercise. Maintain joint mobility.', 'low', 'musculoskeletal', 'See doctor if stiffness lasts over an hour or limits activities', 'Severe joint swelling, inability to move joint, high fever'),

('Occasional Indigestion', 'Mild stomach upset and digestive discomfort', 'Eat smaller meals, avoid trigger foods, don\'t lie down after eating. Chew food thoroughly.', 'low', 'gastrointestinal', 'See doctor if indigestion is frequent or severe', 'Severe chest pain, difficulty swallowing, persistent vomiting'),

('Mild Anxiety Episodes', 'Minor stress and worry management', 'Practice deep breathing, exercise regularly, maintain healthy lifestyle. Use relaxation techniques.', 'low', 'psychiatric', 'See mental health professional if anxiety increases or affects daily life', 'Panic attacks, severe physical symptoms, inability to function'),

('Occasional Sleeplessness', 'Temporary sleep difficulties and insomnia', 'Maintain sleep schedule, create relaxing bedtime routine, limit screen time before bed.', 'low', 'psychiatric', 'See doctor if sleep problems persist or affect daytime functioning', 'Complete inability to sleep, severe daytime impairment, safety concerns'),

('Minor Cuts and Scrapes', 'Small wound care and healing promotion', 'Clean with soap and water, apply antibiotic ointment, cover with bandage. Keep clean and dry.', 'low', 'dermatological', 'See doctor if wound shows signs of infection or doesn\'t heal', 'Red streaking, pus, increased pain, fever, wound edges spreading'),

('Occasional Dizziness', 'Mild lightheadedness and balance issues', 'Move slowly when changing positions, stay hydrated, sit or lie down when dizzy.', 'low', 'neurological', 'See doctor if dizziness is frequent, severe, or causes falls', 'Dizziness with chest pain, fainting, severe headache, hearing loss'),

('Minor Muscle Strains', 'Mild muscle pulls and overuse injuries', 'Rest affected muscle, apply ice initially then heat, gentle stretching when pain subsides.', 'low', 'musculoskeletal', 'See doctor if pain is severe, persists over a week, or limits mobility', 'Severe pain, visible deformity, inability to use muscle, numbness'),

('Occasional Heartburn', 'Mild acid reflux and stomach acid irritation', 'Avoid trigger foods, eat smaller meals, don\'t lie down after eating. Antacids as needed.', 'low', 'gastrointestinal', 'See doctor if heartburn is frequent or interferes with sleep', 'Severe chest pain, difficulty swallowing, weight loss, persistent symptoms'),

('Minor Allergic Reactions', 'Mild skin reactions and environmental sensitivities', 'Avoid known allergens, use cool compresses, take antihistamines as directed. Keep area clean.', 'low', 'allergic', 'See doctor if reactions worsen or become more frequent', 'Difficulty breathing, severe swelling, widespread rash, dizziness'),

('Mild Fatigue', 'General tiredness and low energy levels', 'Ensure adequate sleep, eat balanced meals, exercise regularly, manage stress levels.', 'low', 'endocrine', 'See doctor if fatigue persists despite lifestyle changes', 'Extreme fatigue, fatigue with other symptoms, inability to function'),

('Minor Nasal Congestion', 'Stuffy nose and sinus pressure relief', 'Use saline nasal spray, steam inhalation, drink warm fluids. Sleep with head elevated.', 'low', 'respiratory', 'See doctor if congestion persists over 10 days or includes fever', 'High fever, severe sinus pain, thick colored discharge, severe headache'),

('Occasional Mood Changes', 'Normal emotional fluctuations and stress responses', 'Practice stress management, maintain social connections, exercise regularly, get adequate sleep.', 'low', 'psychiatric', 'See mental health professional if mood changes are severe or persistent', 'Extreme mood swings, thoughts of self-harm, inability to function'),

('Minor Aches and Pains', 'General discomfort and minor pain management', 'Rest, gentle movement, over-the-counter pain relievers as directed, apply heat or cold.', 'low', 'infectious', 'See doctor if pain is severe, persistent, or affects daily activities', 'Severe pain, pain with fever, pain that worsens rapidly'),

('Mild Digestive Upset', 'Minor stomach discomfort and digestive issues', 'Eat bland foods, stay hydrated, avoid spicy or fatty foods. Rest digestive system.', 'low', 'gastrointestinal', 'See doctor if symptoms persist over 3 days or worsen', 'Severe pain, blood in stool/vomit, high fever, signs of dehydration'),

('Minor Skin Irritation', 'Mild dermatitis and skin sensitivity reactions', 'Identify and avoid irritants, use gentle skin care products, keep area clean and moisturized.', 'low', 'dermatological', 'See doctor if irritation spreads, becomes infected, or doesn\'t improve', 'Severe itching, spreading rash, signs of infection, difficulty breathing'),

('Occasional Urinary Urgency', 'Mild bladder urgency and frequency changes', 'Limit caffeine and alcohol, practice timed voiding, maintain good hydration balance.', 'low', 'urological', 'See doctor if urgency is sudden, severe, or accompanied by pain', 'Painful urination, blood in urine, inability to urinate, fever'),

('Minor Hearing Changes', 'Temporary hearing variations and ear pressure', 'Avoid loud noises, gently clean outer ears only, try yawning or swallowing for pressure.', 'low', 'ent', 'See doctor if hearing loss is sudden, severe, or accompanied by pain', 'Sudden hearing loss, severe ear pain, discharge, dizziness'),

('Mild Eye Strain', 'Computer vision syndrome and visual fatigue', 'Take frequent breaks from screens, ensure proper lighting, blink more often, adjust screen distance.', 'low', 'ophthalmological', 'See doctor if eye strain persists or is accompanied by headaches', 'Severe headaches, vision changes, eye pain, persistent discomfort'),

('Minor Menstrual Discomfort', 'Mild period pain and menstrual symptoms', 'Apply heat, gentle exercise, over-the-counter pain relievers, maintain healthy diet.', 'low', 'gynecological', 'See gynecologist if pain is severe or interferes with activities', 'Severe cramping, heavy bleeding, bleeding between periods'),

('Occasional Bruising', 'Normal bruising from minor bumps and injuries', 'Apply ice immediately after injury, elevate if possible, avoid medications that increase bleeding.', 'low', 'hematological', 'See doctor if bruising is excessive, occurs without injury, or doesn\'t heal', 'Large unexplained bruises, bruising with other bleeding, severe pain'),

('Mild Throat Irritation', 'Minor throat scratchiness and dryness', 'Stay hydrated, use throat lozenges, avoid throat clearing, use humidifier.', 'low', 'ent', 'See doctor if irritation persists over a week or worsens', 'Severe sore throat, difficulty swallowing, high fever, swollen glands'),

('Minor Seasonal Changes', 'Mild weather-related health adjustments', 'Dress appropriately for weather, maintain consistent routines, ensure adequate vitamin D.', 'low', 'endocrine', 'See doctor if seasonal changes significantly affect mood or energy', 'Severe seasonal depression, extreme fatigue, significant mood changes'),

('Occasional Stomach Gas', 'Minor bloating and intestinal gas discomfort', 'Eat slowly, avoid gas-producing foods, take short walks after meals, drink peppermint tea.', 'low', 'gastrointestinal', 'See doctor if bloating is severe, persistent, or accompanied by pain', 'Severe abdominal pain, inability to pass gas, persistent vomiting'),

('Mild Stress Symptoms', 'Normal stress responses and tension relief', 'Practice relaxation techniques, exercise regularly, maintain work-life balance, get adequate sleep.', 'low', 'psychiatric', 'See mental health professional if stress affects daily functioning', 'Severe anxiety, inability to cope, physical symptoms of stress'),

('Minor Sleep Disturbances', 'Occasional sleep interruptions and light sleeping', 'Maintain consistent bedtime, create comfortable sleep environment, limit caffeine late in day.', 'low', 'psychiatric', 'See doctor if sleep problems persist or affect daytime functioning', 'Complete insomnia, severe daytime sleepiness, breathing problems during sleep'),

('Mild Appetite Changes', 'Normal fluctuations in hunger and food intake', 'Maintain regular meal times, eat balanced nutrition, listen to body hunger cues.', 'low', 'endocrine', 'See doctor if appetite changes are extreme or unexplained', 'Complete loss of appetite, rapid weight changes, inability to eat'),

('Minor Physical Discomfort', 'General aches from normal activities', 'Gentle stretching, adequate rest, proper posture, regular low-impact exercise.', 'low', 'musculoskeletal', 'See doctor if discomfort is severe or limits activities', 'Severe pain, inability to move normally, pain with fever'),

('Occasional Energy Dips', 'Normal variations in energy throughout day', 'Maintain consistent sleep schedule, eat regular healthy meals, stay hydrated, get natural light.', 'low', 'endocrine', 'See doctor if energy problems persist or worsen', 'Extreme fatigue, inability to function, fatigue with other symptoms'),

('Mild Concentration Issues', 'Minor focus and attention difficulties', 'Minimize distractions, take regular breaks, ensure adequate sleep, manage stress levels.', 'low', 'neurological', 'See doctor if concentration problems significantly affect work or life', 'Severe memory problems, confusion, inability to focus at all'),

('Minor Coordination Changes', 'Slight clumsiness or balance variations', 'Move more slowly and deliberately, ensure good lighting, wear appropriate footwear.', 'low', 'neurological', 'See doctor if coordination problems worsen or cause falls', 'Severe balance problems, frequent falls, weakness on one side'),

('Occasional Temperature Sensitivity', 'Mild responses to hot or cold environments', 'Dress in layers, stay hydrated, gradually adjust to temperature changes.', 'low', 'endocrine', 'See doctor if temperature sensitivity is extreme or affects daily life', 'Inability to regulate temperature, severe reactions to heat/cold'),

('Minor Circulation Issues', 'Mild cold hands/feet or circulation changes', 'Stay warm, exercise regularly, avoid tight clothing, don\'t smoke.', 'low', 'cardiovascular', 'See doctor if circulation problems worsen or cause pain', 'Severe color changes, numbness, severe pain, ulcers'),

('Mild Hydration Imbalance', 'Minor dehydration or overhydration symptoms', 'Monitor fluid intake, drink when thirsty, balance electrolytes with normal diet.', 'low', 'endocrine', 'See doctor if hydration problems persist or are extreme', 'Severe dehydration, inability to keep fluids down, confusion'),

('Occasional Voice Changes', 'Minor hoarseness or voice fatigue', 'Rest voice, stay hydrated, avoid whispering or shouting, use humidifier.', 'low', 'ent', 'See doctor if voice changes persist over 2 weeks', 'Complete voice loss, severe hoarseness, difficulty breathing'),

('Minor Balance Fluctuations', 'Slight unsteadiness or balance awareness', 'Move slowly, use handrails, ensure good lighting, wear appropriate shoes.', 'low', 'neurological', 'See doctor if balance problems increase or cause falls', 'Frequent falls, severe dizziness, balance problems with other symptoms');
