import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import keras
from keras.layers import Dense
from keras.models import Sequential
from keras.layers import LSTM
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error
import time

#collecting trajectory data
df = pd.read_csv('/Users/admin/Desktop/supervised_flocking/data/cmpc.csv')

#verifying data shape
print(df.shape)

#flock parameter
#number of neighjbors
k = 5
#total birds
n = 30

#calculating Euclidean distance between agents
df1 = pd.DataFrame()
for i in range(2,n+1):
    df1['%d' %(i)] = np.sqrt((df['px1'] - df['px' '%d' %(i)])**2 + (df['py1'] - df['py' '%d' %(i)])**2)

#finding the k-nearest neighbors
arank = df1.apply(np.argsort, axis = 1)
ranked_cols = df1.columns.to_series()[arank.values[:,::1][:,:k+1]]
new_frame = pd.DataFrame(ranked_cols, index = df1.index)
new_frame.columns = ['n1','n2','n3','n4','n5','n6']
new_frame['n0'] = '1'
new_frame = new_frame[['n0','n1','n2','n3','n4','n5','n6']]

#collecting final data for training
l = len(df) - 1
print(new_frame.head())
finaldf = pd.DataFrame()
for index in range(0,l):
    for i in range(0,k+1):
        j = int(new_frame.iloc[index,i])
        finaldf['px' '%d' %(i)] = df['px' '%d' %(j)]
        finaldf['py' '%d' %(i)] = df['py' '%d' %(j)]
        finaldf['qx' '%d' %(i)] = df['qx' '%d' %(j)]
        finaldf['qy' '%d' %(i)] = df['qy' '%d' %(j)]
        finaldf['ax' '%d' %(i)] = df['ax' '%d' %(j)]
        finaldf['ay' '%d' %(i)] = df['ay' '%d' %(j)]
print(finaldf.head())

#position and velocities of all the agents
inputs = ['px0', 'px1', 'px2', 'px3', 'px4', 'px5', 'py0', 'py1', 'py2', 'py3', 'py4', 'py5',
          'qx0', 'qx1', 'qx2', 'qx3', 'qx4', 'qx5', 'qy0', 'qy1', 'qy2', 'qy3', 'qy4', 'qy5']

#acceleration of an agent
outputs = ['ax0', 'ay0']

#convert into dataframes
x = finaldf[inputs]
y = finaldf[outputs]

#adjust for NN usage
X = x.values
Y = y.values

#fit data for training
sc = StandardScaler()
X_train = sc.fit_transform(X)

#DNN training
model = Sequential()

#gives the number of input features
n_cols = X.shape[1]

#hidden layers
model.add(Dense(64, activation='sigmoid', input_shape=(n_cols,)))
model.add(Dense(64))
model.add(Dense(64))
model.add(Dense(64))
model.add(Dense(64))

#output layers
model.add(Dense(2))

#optimization
adam = keras.optimizers.Adam(lr=0.0001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, decay=0.0, amsgrad=False)
model.compile(optimizer='adam', loss='mean_squared_error', metrics =['accuracy'])
model.summary()

start = time.perf_counter()

#training
history = model.fit(X_train, Y, batch_size = 100 , epochs=1000, verbose = 2)

end = time.perf_counter()

#output training time
print(end - start)


#training error visualization
plt.plot(history.history['loss'])
plt.title('Model Loss')
plt.ylabel('Error')
plt.xlabel('Epoch')
plt.show()

dft1 = pd.DataFrame()
dft = pd.DataFrame(columns=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20',
                           '21','22','23','24','25','26','27','28','29','30'])
testdf1 = pd.DataFrame(columns=['px0', 'py0', 'qx0', 'qy0', 'px1', 'py1', 'qx1', 'qy1', 'px2', 'py2', 'qx2', 'qy2',
                                'px3', 'py3', 'qx3', 'qy3', 'px4', 'py4', 'qx4', 'qy4', 'px5', 'py5', 'qx5', 'qy5'])
df2 = df.head(1)
testdf = pd.DataFrame()
COLUMN_NAMES = df2.columns
df3 = pd.DataFrame(columns=COLUMN_NAMES)
steps = 1
tinput = ['px0', 'px1', 'px2', 'px3', 'px4', 'px5', 'py0', 'py1', 'py2', 'py3', 'py4', 'py5',
          'qx0', 'qx1', 'qx2', 'qx3', 'qx4', 'qx5', 'qy0', 'qy1', 'qy2', 'qy3', 'qy4', 'qy5']

while steps < 335:
    for ix in range(1, 31):
        for jx in range(1, 31):
            dft1['%d' % (jx)] = np.sqrt((df2['px' '%d' % (ix)] - df2['px' '%d' % (jx)]) ** 2 + (
                        df2['py' '%d' % (ix)] - df2['py' '%d' % (jx)]) ** 2)
        dft.loc[dft1.index[0] + ix] = dft1.iloc[0]

    trank = dft.apply(np.argsort, axis=1)
    tranked_cols = dft.columns.to_series()[trank.values[:, ::1][:, :6]]
    test_frame = pd.DataFrame(tranked_cols, index=dft.index)
    for index in range(0, 30):
        for p in range(0, 6):
            j = int(test_frame.iloc[index, p])
            testdf['px' '%d' % (p)] = df2['px' '%d' % (j)]
            testdf['py' '%d' % (p)] = df2['py' '%d' % (j)]
            testdf['qx' '%d' % (p)] = df2['qx' '%d' % (j)]
            testdf['qy' '%d' % (p)] = df2['qy' '%d' % (j)]
        testdf1.loc[testdf.index[0] + index] = testdf.iloc[0]

    testinput = testdf1[tinput]
    test = testinput.values
    X_test = sc.fit_transform(test)
    y_pred = model.predict(X_test)
    # print(y_pred)

    for i in range(0, 30):
        df2['ax' '%d' % (i + 1)] = y_pred[i, 0]
        df2['ay' '%d' % (i + 1)] = y_pred[i, 1]

    for j in range(1, 31):
        df2['qx' '%d' % (j)] = df2['qx' '%d' % (j)] + 0.1 * df2['ax' '%d' % (j)]
        df2['qy' '%d' % (j)] = df2['qy' '%d' % (j)] + 0.1 * df2['ay' '%d' % (j)]
        df2['px' '%d' % (j)] = df2['px' '%d' % (j)] + 0.1 * df2['qx' '%d' % (j)]
        df2['py' '%d' % (j)] = df2['py' '%d' % (j)] + 0.1 * df2['qy' '%d' % (j)]

    df3.loc[df2.index[0] + steps] = df2.iloc[0]
    steps = steps + 1
print(df3)

#mean squared error calculation
# mse_test = mean_squared_error(y.head(1), y_pred)
# print (mse_test)
# print(y_pred)
#
# model1 = Sequential()
#
# model1.add(LSTM(35, input_shape=(334,24),return_sequences = True, activation='sigmoid'))
# model1.add(LSTM(35,return_sequences=True))
# model1.add(LSTM(2,return_sequences=True))
#
# model1.compile(loss='mean_squared_error', optimizer='adam', metrics=['accuracy'])
# model1.summary()
#history1 = model1.fit(X1, Y1, batch_size=1000, epochs=10000, verbose = 2)