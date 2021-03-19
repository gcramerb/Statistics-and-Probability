arq = "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"
wine=read.table(arq, sep=",")
head(wine)
pairs(wine[,2:6])
round(100*cor(wine[,2:14]))
round(apply(wine[,2:14], 2, sd),2)
wine.pca = prcomp(wine[,2:14], scale. = TRUE)
summary(wine.pca)
wine.pca$sdevsum((wine.pca$sdev)^2)
screeplot(wine.pca, type="lines")
# Barplot das variancias acumuladas
barplot(cumsum(wine.pca$sdev^2)/sum(wine.pca$sdev^2))
# os dois primeiros PCA's explicam aprox 60% da variancia total
# os 5 primeiros explicam aprox 80%

# Os autovetores
dim(wine.pca$rot)
#O 1o autovetor
wine.pca$rot[,1]
# O 2o autovetorwine.pca$rot[,2]
# Coordenadas dos pontos ao longo do primeiro componente
fscore1 = wine.pca$x[,1]
fscore2 = wine.pca$x[,2]
# plot dos pontos projetados
plot(fscore1, fscore2, pch="*", col=wine[,1]+8)
z = scale(wine[2:14])
z = scale(wine[2:14])
round(apply(z, 2, mean), 5)
round(apply(z, 2, sd), 5)

x = c(13.95, 3.65, 2.25, 18.4, 90.18, 1.55, 0.48, 0.5, 1.34, 10.2, 0.71, 1.48, 587.14)
z = (x - apply(wine[,2:14], 2, mean))/apply(wine[,2:14], 2, sd)
y1 = sum( wine.pca$rot[,1] * z)
y2 = sum( wine.pca$rot[,2] * z)
plot(fscore1, fscore2, pch="*", col=wine[,1]+8)
points(y1, y2, pch="*", cex=4)













