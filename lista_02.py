import pandas as pd
import matplotlib.pyplot as plt


#pressao Sanguinea
pressao = pd.read_csv("C://Users/gcram/Desktop/UFMG/FECD/DatasetsExercicios/pressaoSanguinea.txt",sep = ',')
pressao.shape
pressao = pressao.iloc[:,1:18]
pressao.columns

#populacao por municu=ipio
df = pd.read_csv("C://Users/gcram/Desktop/UFMG/FECD/DatasetsExercicios/POP2006.csv",sep = ',',encoding='latin-1')
df.hist()

#Campeonato Brasileiro 2014
brasileirao = pd.read_csv("C://Users/gcram/Desktop/UFMG/FECD/DatasetsExercicios/brasileirao.txt",sep = ',')


# importing the module
#import stemgraphic
#fig, ax = stemgraphic.stem_graphic(brasileirao)

#pressao.boxplot()


import seaborn as sns


mtcars = pd.read_csv("C://Users/gcram/Desktop/UFMG/FECD/DatasetsExercicios/mtcars.csv",sep = ',',encoding='latin-1')
sns.pairplot(mtcars)
plt.show()

