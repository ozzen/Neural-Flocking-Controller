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
#time
dt = 0.1

#calculating Euclidean distance between agents
eucd_dist = pd.DataFrame()
for i in range(2,n+1):
    eucd_dist['%d' % (i)] = np.sqrt((df['px1'] - df['px' '%d' % (i)]) ** 2 + (df['py1'] - df['py' '%d' % (i)]) ** 2)

#finding the k-nearest neighbors
arank = eucd_dist.apply(np.argsort, axis = 1)
ranked_cols = eucd_dist.columns.to_series()[arank.values[:, ::1][:, :k + 1]]
new_frame = pd.DataFrame(ranked_cols, index = eucd_dist.index)
new_frame.columns = ['n0','n1','n2','n3','n4','n5']

#collecting final data for training
l = len(df) - 1
print(new_frame.head())
final_train_df = pd.DataFrame()
for index in range(0,l):
    for i in range(0,k+1):
        j = int(new_frame.iloc[index,i])
        final_train_df['px' '%d' % (i)] = df['px' '%d' % (j)]
        final_train_df['py' '%d' % (i)] = df['py' '%d' % (j)]
        final_train_df['qx' '%d' % (i)] = df['qx' '%d' % (j)]
        final_train_df['qy' '%d' % (i)] = df['qy' '%d' % (j)]
        final_train_df['ax' '%d' % (i)] = df['ax' '%d' % (j)]
        final_train_df['ay' '%d' % (i)] = df['ay' '%d' % (j)]
print(final_train_df.head())

#position and velocities of all the agents
inputs = ['px0', 'px1', 'px2', 'px3', 'px4', 'px5', 'py0', 'py1', 'py2', 'py3', 'py4', 'py5',
          'qx0', 'qx1', 'qx2', 'qx3', 'qx4', 'qx5', 'qy0', 'qy1', 'qy2', 'qy3', 'qy4', 'qy5']

#acceleration of an agent
outputs = ['ax0', 'ay0']

#convert into dataframes
x = final_train_df[inputs]
y = final_train_df[outputs]

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
model.add(Dense(64, activation='sigmoid'))
model.add(Dense(64, activation='sigmoid'))
model.add(Dense(64, activation='sigmoid'))
model.add(Dense(64, activation='sigmoid'))

#output layers
model.add(Dense(2))

#optimization
adam = keras.optimizers.Adam(lr=0.0001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, decay=0.0, amsgrad=False)
model.compile(optimizer='adam', loss='mean_squared_error', metrics =['accuracy'])
model.summary()

start = time.perf_counter()

#training
history = model.fit(X_train, Y, batch_size = 100 , epochs=100, verbose = 2)

end = time.perf_counter()

#output training time
print(end - start)

#training error visualization
plt.plot(history.history['loss'])
plt.title('Model Loss')
plt.ylabel('Error')
plt.xlabel('Epoch')
plt.show()

#testing phase

#initial configuration for testing
test_input = df.head(1)
testdf = pd.DataFrame()

#stores distance for knn neighbors for all 30 agents for each time steps
test_dist = pd.DataFrame()
step_test_dist = pd.DataFrame(columns=['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15',
                                       '16', '17', '18', '19', '20', '21','22','23','24','25','26','27','28','29','30'])

#stores data used for testing
test_final = pd.DataFrame(columns=['px0', 'py0', 'qx0', 'qy0', 'px1', 'py1', 'qx1', 'qy1', 'px2', 'py2', 'qx2', 'qy2',
                                   'px3', 'py3', 'qx3', 'qy3', 'px4', 'py4', 'qx4', 'qy4', 'px5', 'py5', 'qx5', 'qy5'])

#final dataframe after testing
COLUMN_NAMES = test_input.columns
finaldf = pd.DataFrame(columns=COLUMN_NAMES)

#repeat for number of time steps for the neural controller
steps = 1
while steps < 335:

    #generating inter-agent distance data at each time step
    for i in range(1, n+1):
        for j in range(1, n+1):
            test_dist['%d' % (j)] = np.sqrt((test_input['px' '%d' % (i)] - test_input['px' '%d' % (j)]) ** 2 + (
                    test_input['py' '%d' % (i)] - test_input['py' '%d' % (j)]) ** 2)
        step_test_dist.loc[test_dist.index[0] + i] = test_dist.iloc[0]

    t_rank = step_test_dist.apply(np.argsort, axis=1)
    t_ranked_cols = step_test_dist.columns.to_series()[t_rank.values[:, ::1][:, :k + 1]]
    test_frame = pd.DataFrame(t_ranked_cols, index=step_test_dist.index)

    # generating k-nearest neighbor data for every agent at each time steps
    for index in range(0, n):
        for p in range(0, k+1):
            j = int(test_frame.iloc[index, p])
            testdf['px' '%d' % (p)] = test_input['px' '%d' % (j)]
            testdf['py' '%d' % (p)] = test_input['py' '%d' % (j)]
            testdf['qx' '%d' % (p)] = test_input['qx' '%d' % (j)]
            testdf['qy' '%d' % (p)] = test_input['qy' '%d' % (j)]
        test_final.loc[testdf.index[0] + index] = testdf.iloc[0]

    #testing
    testinput = test_final[inputs]
    test = testinput.values
    X_test = sc.fit_transform(test)
    y_pred = model.predict(X_test)
    # print(y_pred)

    #storing the controller generated accelearations for all agents
    for i in range(0, n):
        test_input['ax' '%d' % (i + 1)] = y_pred[i, 0]
        test_input['ay' '%d' % (i + 1)] = y_pred[i, 1]

    #generating positions and velocities for all agents for next time step using motion dynamics
    for j in range(1, n+1):
        test_input['qx' '%d' % (j)] = test_input['qx' '%d' % (j)] + dt * test_input['ax' '%d' % (j)]
        test_input['qy' '%d' % (j)] = test_input['qy' '%d' % (j)] + dt * test_input['ay' '%d' % (j)]
        test_input['px' '%d' % (j)] = test_input['px' '%d' % (j)] + dt * test_input['qx' '%d' % (j)]
        test_input['py' '%d' % (j)] = test_input['py' '%d' % (j)] + dt * test_input['qy' '%d' % (j)]

    #stores the final dataframe outputting the results
    finaldf.loc[test_input.index[0] + steps] = test_input.iloc[0]
    steps = steps + 1

    #keeping track of progress
    print(steps)

#output results to a csv file
finaldf.to_csv('/Users/admin/Desktop/supervised_flocking/data/finaldf.csv', index=False)