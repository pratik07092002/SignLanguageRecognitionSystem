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
    
    labels_dict = {0: 'K', 1: 'L', 2: 'M', 3 :'N', 4:'O', 5:'A', 6:'P', 7:'Q', 8:'R', 9:'C',
                   10:' ', 11:'T', 12:'U', 13:'V', 14:'W', 15:'X', 16:'Y', 17:'Z', 18:'D',
                   19:'B', 20:'J', 21:'S', 22:'Del', 23:'E', 24:'F', 25:'G', 26:'H', 27:'I'}
    model_dict = pickle.load(open('./model_with_labels.p', 'rb'))
    model = model_dict['model']
    imagefile = request.files['image']
    mp_hands = mp.solutions.hands
    mp_drawing = mp.solutions.drawing_utils
    mp_drawing_styles = mp.solutions.drawing_styles
    hands = mp_hands.Hands(static_image_mode = True , min_detection_confidence = 0.3)
    image_stream = io.BytesIO(imagefile.read())
    img = cv2.imdecode(np.frombuffer(image_stream.read(), np.uint8), cv2.IMREAD_COLOR)
    img_flip = cv2.flip(img , 1)
    img_flip1 = cv2.flip(img_flip,1)
    img_rgb = cv2.cvtColor(img_flip1 , cv2.COLOR_BGR2RGB)
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
    cv2.imwrite('output_image_with_landmarks1.jpg', cv2.cvtColor(img_rgb, cv2.COLOR_RGB2BGR))
    
    return jsonify({'predicted_char': predicted_char}), 200

if __name__ == '__main__':
    app.run(debug=True)