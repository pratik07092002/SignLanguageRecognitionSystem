from flask import Flask, jsonify, request
import mediapipe as mp
import cv2
from PIL import Image
import numpy as np
import io
import pickle
app = Flask(__name__)

@app.route('/upload' , methods =['POST'] )
def sendImg():
    data_aux = []
    x_ = []
    y_ = []
    labels_dict = {0: 'A', 1: 'B', 2: 'C', 3 :'D', 4:'E', 5:'F', 6:'G', 7:'H', 8:'I', 9:'J',
               10:'k', 11:'L', 12:'M', 13:'N', 14:'O', 15:'P', 16:'Q', 17:'R', 18:'S',
               19:'T', 20:'U', 21:'V', 22:'W', 23:'X', 24:'Y', 25:'Z'}
    model_dict = pickle.load(open('./model_with_labels.p', 'rb'))
    model = model_dict['model']
    imagefile = request.files['image']
    mp_hands = mp.solutions.hands
    mp_drawing = mp.solutions.drawing_utils
    mp_drawing_styles = mp.solutions.drawing_styles
    hands = mp_hands.Hands(static_image_mode = True , min_detection_confidence = 0.3)
    image_stream = io.BytesIO(imagefile.read())
    img = cv2.imdecode(np.frombuffer(image_stream.read(), np.uint8), cv2.IMREAD_COLOR)
    img_rgb = cv2.cvtColor(img , cv2.COLOR_BGR2RGB)
    results = hands.process(img_rgb)
    for hand_landmarks in results.multi_hand_landmarks:
        mp_drawing.draw_landmarks(
            img_rgb,
            hand_landmarks,
            mp_hands.HAND_CONNECTIONS,
            mp_drawing_styles.get_default_hand_landmarks_style(),
            mp_drawing_styles.get_default_hand_connections_style(),
            
        )
        
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
    predicted_char = labels_dict[int(prediction[0])]
    print(predicted_char)
    cv2.imwrite('output_image_with_landmarks.jpg', cv2.cvtColor(img_rgb, cv2.COLOR_RGB2BGR))
    
    return jsonify({'predicted_char': predicted_char}), 200

if __name__ == '__main__':
    app.run(debug=True , host= 'HOST_IP')