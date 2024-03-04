from flask import Flask, request, jsonify
import cv2
import numpy as np
import pickle
import mediapipe as mp

app = Flask(__name__)

model_dict = pickle.load(open('./model_with_labels.p', 'rb'))
model = model_dict['model']

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=True, min_detection_confidence=0.3)

labels_dict = {0: 'A', 1: 'B', 2: 'C', 3 :'D', 4:'E', 5:'F', 6:'G', 7:'H', 8:'I', 9:'J',
               10:'k', 11:'L', 12:'M', 13:'N', 14:'O', 15:'P', 16:'Q', 17:'R', 18:'S',
               19:'T', 20:'U', 21:'V', 22:'W', 23:'X', 24:'Y', 25:'Z'}

@app.route('/')
def index():
    return 'Flask server is running!'

@app.route('/predict', methods=['GET', 'POST'])
def predict():
    if request.method == 'POST':
        try:
            image_data = request.files['image'].read()
            nparr = np.frombuffer(image_data, np.uint8)
            img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

            data_aux = []
            x_ = []
            y_ = []

            H, W, _ = img.shape

            img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

            results = hands.process(img_rgb)
            if results.multi_hand_landmarks:
                for hand_landmarks in results.multi_hand_landmarks:
                    for i in range(len(hand_landmarks.landmark)):
                        x = hand_landmarks.landmark[i].x
                        y = hand_landmarks.landmark[i].y

                        x_.append(x)
                        y_.append(y)

                    for i in range(len(hand_landmarks.landmark)):
                        x = hand_landmarks.landmark[i].x
                        y = hand_landmarks.landmark[i].y
                        data_aux.append(x - min(x_))
                        data_aux.append(y - min(y_))

                prediction = model.predict([np.asarray(data_aux)])
                predicted_letter = labels_dict[int(prediction[0])]
                confidence = round(max(model.predict_proba([np.asarray(data_aux)])[0]) * 100, 2)

                return jsonify({
                    'predicted_letter': predicted_letter,
                    'confidence': confidence
                })

        except Exception as e:
            return jsonify({'error': str(e)})

    return 'Method not allowed'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
