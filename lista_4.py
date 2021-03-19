import pandas as pd
import matplotlib.pyplot as plt
df = pd.read_csv("C://Users/gcram/Desktop/UFMG/FECD/DatasetsExercicios/stagec.csv" ,sep = ',' ,encoding='latin-1',index_col =0)
df = df.drop(['pgtime'],axis = 1)
df = df.dropna()
y = df[['pgstat']]
cleanup_nums = {"ploidy":     {"aneuploid": 4, "tetraploid": 2,'diploid': 1}}
x = df.drop(['pgstat'],axis = 1)
x.replace(cleanup_nums, inplace=True)

train_size = round(len(x)*0.8)
x_train = x.iloc[0:train_size]
x_test = x.iloc[train_size:]
y_train = y.iloc[0:train_size]
y_test = y.iloc[train_size:]

from sklearn import tree
clf = tree.DecisionTreeClassifier()
clf = clf.fit(x_train, y_train)
tree.plot_tree(clf)
plt.show()