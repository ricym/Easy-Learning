import numpy as np
import pandas as pd
from scipy.interpolate import interp1d
from scipy.integrate import trapz

# file = np.loadtxt('data.csv')
file = pd.read_csv(r'C:\Users\ricym\source\code\data.csv', header=None)
column_name = '1'
data = file.iloc[:,3]
# data = np.array(file[:,1])

# 将数据连接成曲线
#x = np.linspace(0, 1, data.shape[0])
x = np.linspace(data.index[0], data.index[-1], data.shape[0])
f = interp1d(x, data, kind='linear')
curve = f(x)

threshold = 0.9
mask = curve >= threshold
range_above_threshold = x[mask]
print(range_above_threshold)

l = range_above_threshold[0] - range_above_threshold[-1]
print(l)
