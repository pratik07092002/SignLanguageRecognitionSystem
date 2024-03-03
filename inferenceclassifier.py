import pickle
import cv2
import mediapipe as mp
import numpy as np
from flask import Flask, jsonify, request, render_template
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

model_dict = pickle.load(open('./model_with_labels.p', 'rb'))
model = model_dict['model']

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles

hands = mp_hands.Hands(static_image_mode=True, min_detection_confidence=0.3)

labels_dict = {0: 'A', 1: 'B', 2: 'C', 3 :'D', 4:'E', 5:'F', 6:'G', 7:'H', 8:'I', 9:'J',
               10:'k', 11:'L', 12:'M', 13:'N', 14:'O', 15:'P', 16:'Q', 17:'R', 18:'S',
               19:'T', 20:'U', 21:'V', 22:'W', 23:'X', 24:'Y', 25:'Z'}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict_gesture', methods=['POST'])
def predict_gesture():
    data_aux = []
    x_ = []
    y_ = []

    # Assuming the client sends an image file
    image_file = request.files.get('image')
    image = cv2.imdecode(np.frombuffer(image_file.read(), np.uint8), cv2.IMREAD_COLOR)

    H, W, _ = image.shape

    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    results = hands.process(image_rgb)
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(
                image,  
                hand_landmarks,  
                mp_hands.HAND_CONNECTIONS,  
                mp_drawing_styles.get_default_hand_landmarks_style(),
                mp_drawing_styles.get_default_hand_connections_style())

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

        x1 = int(min(x_) * W) - 10
        y1 = int(min(y_) * H) - 10

        x2 = int(max(x_) * W) - 10
        y2 = int(max(y_) * H) - 10

        prediction = model.predict([np.asarray(data_aux)])
        predicted_letter = labels_dict[int(prediction[0])]
        confidence = round(max(model.predict_proba([np.asarray(data_aux)])[0]) * 100, 2)

        cv2.rectangle(image, (x1, y1), (x2, y2), (0, 0, 0), 6)
        cv2.putText(image, predicted_letter, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.3, (0, 0, 0), 3,
                    cv2.LINE_AA)

    _, img_encoded = cv2.imencode('.png', image)
    img_bytes = img_encoded.tobytes()

    response_data = {
        'predicted_letter': predicted_letter,
        'confidence': confidence,
        'image': img_bytes
    }

    return jsonify(response_data)

if __name__ == '__main__':
    app.run(debug=True)
