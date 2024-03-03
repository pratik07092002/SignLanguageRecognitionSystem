import pickle
import cv2
import mediapipe as mp
import numpy as np
import tkinter as tk
from tkinter import Label
from PIL import Image, ImageTk

model_dict = pickle.load(open('./model_with_labels.p', 'rb'))
model = model_dict['model']

cap = cv2.VideoCapture(0)

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles

hands = mp_hands.Hands(static_image_mode=True, min_detection_confidence=0.3)

labels_dict = {0: 'A', 1: 'B', 2: 'C', 3 :'D', 4:'E', 5:'F', 6:'G', 7:'H', 8:'I', 9:'J',
               10:'k', 11:'L', 12:'M', 13:'N', 14:'O', 15:'P', 16:'Q', 17:'R', 18:'S',
               19:'T', 20:'U', 21:'V', 22:'W', 23:'X', 24:'Y', 25:'Z'}


root = tk.Tk()
root.title("Hand Gesture Recognition")


predicted_letter_label = Label(root, text="Predicted Letter: ", font=("Helvetica", 16))
predicted_letter_label.pack(side="top")





confidence_label = Label(root, text="Confidence: ", font=("Helvetica", 16))
confidence_label.pack(side="top")


label = tk.Label(root)
label.pack()


def update_display(frame, predicted_letter, predicted_word, confidence):
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    image = Image.fromarray(frame)
    img = ImageTk.PhotoImage(image)
    label.config(image=img)
    label.image = img

    predicted_letter_label.config(text=f"Predicted Letter: {predicted_letter}")

    confidence_label.config(text=f"Confidence: {confidence}%")

while True:
    data_aux = []
    x_ = []
    y_ = []

    ret, frame = cap.read()

    H, W, _ = frame.shape

    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    results = hands.process(frame_rgb)
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(
                frame,  
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

        cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 0, 0), 6)
        cv2.putText(frame, predicted_letter, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.3, (0, 0, 0), 3,
                    cv2.LINE_AA)

       
        update_display(frame, predicted_letter, predicted_letter, confidence)

   
    root.update_idletasks()
    root.update()


cap.release()
cv2.destroyAllWindows()
