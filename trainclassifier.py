import pickle
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import numpy as np

data_dict = pickle.load(open('./data.pickle', 'rb'))

data = np.asarray(data_dict['data'])
labels = np.asarray(data_dict['labels'])

x_train, x_test, y_train, y_test = train_test_split(data, labels, test_size=0.2, shuffle=True, stratify=labels)

model = RandomForestClassifier()
model.fit(x_train, y_train)

y_predict = model.predict(x_test)

score = accuracy_score(y_predict, y_test)

print('{}% of samples were classified correctly!'.format(score * 100))


labels_dict = {0: 'A',
               1: 'B',
               2: 'C',
               3 :'D',
               4:'E',
               5:'F',
               6:'G',
               7:'H',
               8:'I',
               9:'J',
               10:'k',
               11:'L',
               12:'M',
               13:'N',
               14:'O',
               15:'P',
               16:'Q',
               17:'R',
               18:'S',
               19:'T',
               20:'U',
               21:'V',
               22:'W',
               23:'X',
               24:'Y',
               25:'Z'} 


predicted_labels = [str(label) for label in y_predict]


predicted_labels_mapped = [labels_dict[int(label)] for label in predicted_labels]


f = open('model_with_labels.p', 'wb')
pickle.dump({'model': model, 'labels_dict': labels_dict}, f)
f.close()
