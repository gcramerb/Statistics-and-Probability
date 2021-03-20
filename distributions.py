import matplotlib.pyplot as plt
import seaborn as sb, numpy as np,pandas as pd
from scipy.stats import binom,poisson,norm,pareto

# discrete distributions: 

data_binom = binom.rvs(n=20,p=0.15,loc=0,size=999999)
ax = sb.distplot(data_binom,kde=True,color='blue',hist_kws={"linewidth": 15,'alpha':1})
ax.set(xlabel='Binomial', ylabel='Frequency')
plt.show()
cdf = []
for k in range(15):
    cdf.append(binom.cdf(n=20, p=0.15, k=k))
plt.plot(cdf)
plt.show()

# Resposta 1 : é maxima k = 3. é proxim de 1
#Resposta 2 : entre 2 e 5
#nO ~= 3 , o que corresponde com o valor esperado !
#Subritai-se 0.1 par obter os valores menores que o desejado, sem inclui-lo
# as frequencias são de fato parecidas

# =============================================# =============================================
# Questão 2

fig, ax = plt.subplots(1, 1)
mu = 0.73
mean, var, skew, kurt = poisson.stats(mu, moments='mvsk')
rv = poisson(mu)
x = np.arange(poisson.ppf(0.01, mu), poisson.ppf(0.99, mu))
ax.plot(x, poisson.pmf(x, mu), 'bo', ms=8, label='poisson pmf')

ax.vlines(x, 0, poisson.pmf(x, mu), colors='b', lw=5, alpha=0.5)
ax.vlines(x , 0, rv.pmf(x), colors='k', linestyles='-', lw=1,label='frozen pmf')
ax.legend(loc='best', frameon=False)
plt.show()

# Resposta 1 : é maxima k = 3. é proxim de 1
#Resposta 2 : entre 2 e 5
#nO ~= 3 , o que corresponde com o valor esperado !
#Subritai-se 0.1 par obter os valores menores que o desejado, sem inclui-lo
# as frequencias são de fato parecidas



# =============================================# =============================================
#Questao 4:
n1,n2,n3,n4 = np.random.normal(0,1,999),np.random.normal(2,1,999),np.random.normal(0,4,999),np.random.normal(2,4,999)
norm_ = pd.DataFrame(n1, columns = ['norm1'])
norm_['norm2'] = n2
norm_['norm3'] = n3
norm_['norm4'] = n4
norm_.hist(bins = 100)
plt.show()

# o valor maximo é sempre proximo da media, nao depend de sigma
# eles realmente parecem

# =============================================# =============================================
#Questao 7:

#Os valore ssao :
#E(X) = 0.617
#F(x) = exp(0.33 x )
#P(x > 3) = 0.12



# =============================================# =============================================
#Questao 8:

fig, ax = plt.subplots(1, 1)
b = 2.62

mean, var, skew, kurt = pareto.stats(b, moments='mvsk')
x = np.linspace(pareto.ppf(0.01, b),

                pareto.ppf(0.99, b), 100)

ax.plot(x, pareto.pdf(x, b),

       'r-', lw=5, alpha=0.6, label='pareto pdf')
rv = pareto(b)

ax.plot(x, rv.pdf(x), 'k-', lw=2, label='frozen pdf')
vals = pareto.ppf([0.001, 0.5, 0.999], b)

np.allclose([0.001, 0.5, 0.999], pareto.cdf(vals, b))
r = pareto.rvs(b, size=1000)
ax.hist(r, density=True, histtype='stepfilled', alpha=0.2)

ax.legend(loc='best', frameon=False)

plt.show()


