from flask import Flask, request, jsonify
import pickle
import cv2
import numpy as np
import mediapipe as mp

app = Flask(__name__)

model_dict = pickle.load(open('./model_with_labels.p', 'rb'))
model = model_dict['model']

labels_dict = {0: 'A', 1: 'B', 2: 'C', 3 :'D', 4:'E', 5:'F', 6:'G', 7:'H', 8:'I', 9:'J',
               10:'k', 11:'L', 12:'M', 13:'N', 14:'O', 15:'P', 16:'Q', 17:'R', 18:'S',
               19:'T', 20:'U', 21:'V', 22:'W', 23:'X', 24:'Y', 25:'Z'}

# Define the Hands object
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles

hands = mp_hands.Hands(static_image_mode=True, min_detection_confidence=0.3)

@app.route('/recognize_sign_language', methods=['POST'])
def recognize_sign_language():
    try:
        # Get the image data from the request
        image_data = request.json['image_data']
        
        # Convert the base64 image data to a NumPy array
        image_array = np.frombuffer(image_data, np.uint8)
        frame = cv2.imdecode(image_array, cv2.IMREAD_COLOR)

        # Your Sign Language Recognition code
        predicted_letter, confidence = recognize_sign_language_function(frame)

        # Return the result as JSON
        return jsonify({'predicted_letter': predicted_letter, 'confidence': confidence})

    except Exception as e:
        # Handle exceptions as needed
        return jsonify({'error': str(e)}), 500

def recognize_sign_language_function(frame):
    data_aux = []
    x_ = []
    y_ = []

    H, W, _ = frame.shape

    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    results = hands.process(frame_rgb)
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

        x1 = int(min(x_) * W) - 10
        y1 = int(min(y_) * H) - 10

        x2 = int(max(x_) * W) - 10
        y2 = int(max(y_) * H) - 10

        prediction = model.predict([np.asarray(data_aux)])
        predicted_letter = labels_dict[int(prediction[0])]
        confidence = round(max(model.predict_proba([np.asarray(data_aux)])[0]) * 100, 2)

        cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 0, 0), 6)
        cv2.putText(frame, predicted_letter, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.3, (0, 0, 0), 3,
                    cv2.LINE_AA)

        return predicted_letter, confidence

    return None, None

if __name__ == '__main__':
    app.run(debug=True)
