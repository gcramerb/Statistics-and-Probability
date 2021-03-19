#Fazer exerc 2, 4, 8 e 10 do Capítulo 9 do Livro de Exercícios

#================================ exercicio 2 ===========================================================#
library(RCurl)
f <- getURL('https://www.datascienceblog.net/data-sets/phoneme.csv')
df <- read.csv(textConnection(f), header=T)
print(dim(df))
#logical vector: TRUE if entry belongs to train set, FALSE else
train <- grepl("^train", df$speaker)
# remove non-feature columns
to.exclude <- c("row.names", "speaker", "g")
feature.df <- df[, !colnames(df) %in% to.exclude]
test.set <- subset(feature.df, !train)
train.set <- subset(feature.df, train)
train.responses <- subset(df, train)$g
test.responses <- subset(df, !train)$g
library(MASS)
lda.model <- lda(train.set, grouping = train.responses)

# 1. Manual transformation
# center data around weighted means & transform
means <- colSums(lda.model$prior * lda.model$means)
train.mod <- scale(train.set, center = means, scale = FALSE) %*% 
  lda.model$scaling
# 2. Use the predict function to transform:
lda.prediction.train <- predict(lda.model, train.set)
all.equal(lda.prediction.train$x, train.mod)

# visualize the features in the two LDA dimensions
plot.df <- data.frame(train.mod, "Outcome" = train.responses)
library(ggplot2)
ggplot(plot.df, aes(x = LD1, y = LD2, color = Outcome)) + geom_point()


library(RColorBrewer)
colors <- brewer.pal(8, "Accent")
my.cols <- colors[match(lda.prediction.train$class, levels(df$g))]
plot(lda.model, dimen = 4, col = my.cols)

plot_lda_centroids <- function(lda.model, train.set, response) {
  centroids <- predict(lda.model, lda.model$means)$x
  library(RColorBrewer)
  colors <- brewer.pal(8, "Accent")
  my.cols <- colors[match(lda.prediction.train$class, levels(df$g))]
  my.points <- predict(lda.model, train.set)$x
  no.classes <- length(unique(response))
  par(mfrow=c(no.classes -1, no.classes -1), mar=c(1,1,1,1), oma=c(1,1,1,10))
  for (i in 1:(no.classes - 1)) {
    for (j in 1:(no.classes - 1)) {
      y <- my.points[, i]
      x <- my.points[, j]
      cen <- cbind(centroids[, j], centroids[, i])
      if (i == j) {
        plot(x, y, type="n") 
        max.y <- max(my.points[, i])
        max.x <- max(my.points[, j])
        min.y <- min(my.points[, i])
        min.x <- min(my.points[, j])
        max.both <- max(c(max.x, max.y))
        min.both <- max(c(min.x, min.y))
        center <- min.both + ((max.both - min.both) / 2)
        text(center, center, colnames(my.points)[i], cex = 3)}
      else {
        plot(x, y, col = my.cols, pch = as.character(response), xlab ="", ylab="")
        points(cen[,1], cen[,2], pch = 21, col = "black", bg = colors, cex = 3)
      }
    }
  }
  par(xpd = NA)
  legend(x=par("usr")[2] + 1, y = mean(par("usr")[3:4]) + 20, 
         legend = rownames(centroids), col = colors, pch = rep(20, length(colors)), cex = 3)
}
plot_lda_centroids(lda.model, train.set, train.responses)

# ============================== questao 4 ===================================
# VVFVF


# ============================== questao 10 ===================================

skull <- read.table(file="EgyptianSkull.txt",header=T)
dim(skull)
head(skull)
period = skull[,5]
period[skull[,5] < -3000] = 1
period[skull[,5] < -1000 & skull[,5] > -3000] = 2
period[skull[,5] > -1000] = 3
colsk = c("red","green","blue")[period]
pairs(skull[,1:4], main="Egyptian skull", pch=21, bg=colsk)

skull = skull[period == 1 | period == 3, 1:4]
row.names(skull) = 1:120
period = period[period == 1 | period == 3]period[period==3] = 2
colsk = c("red","blue")[period]
pairs(skull[,1:4], main="Egyptian skull, 2 periods", pch=21, bg=colsk)

teste = skull[c(23, 52, 88, 111), ]
treino = skull[-c(23, 52, 88, 111), ]
period.treino = rep(1:2, c(58,58))



# Visualizando os conjuntos de teste e treino
colsk = c("red","blue")[period]
colsk[c(23, 52, 88, 111)] = "green"
mark = rep(21, nrow(skull))
mark[c(23, 52, 88, 111)] = 22
pairs(skull[,1:4], pch=mark, bg=colsk)
# Regra de classificacao otima supondo Sigma_1 = Sigma_2
# vetor de medias das 4 variaveis
mu1 = apply(treino[period.treino ==1, ], 2, mean)
mu2 = apply(treino[period.treino ==2, ], 2, mean)
matcov1 = cov(treino[period.treino ==1, ])
matcov2 = cov(treino[period.treino ==2, ])
matcov = (matcov1 + matcov2)/2
maha1 = mahalanobis(teste, mu1, matcov)
maha2 = mahalanobis(teste, mu2, matcov)
maha1 - maha2# O segundo ponto eh alocado a pop1, os demais a pop2# Assim, cometemos um erro com o primeiro ponto,
#que# deveria ser alocado a pop1# Agora, vamos refazer os calculos supondo Sigma_1 != Sigma_2
mu1 = apply(treino[period.treino ==1, ], 2, mean)
mu2 = apply(treino[period.treino ==2, ], 2, mean)
matcov1 = cov(treino[period.treino ==1, ])
matcov2 = cov(treino[period.treino ==2, ])
det1 = log(det(matcov1))# este termo adicional, log da matriz de covariancia,
# precisa ser subtraido da distancia de Mahalanobis
det2 = log(det(matcov2))
d1 = mahalanobis(teste, mu1, matcov) - det1d2 = mahalanobis(teste, mu2, matcov) - det2d1-d2
# Como a amostra e' muito pequena, vamos avaliar a classificacao# omitindo um ponto x de cada vez da base,
#ajustando os parametros# mu e Sigma SEM ESTE ponto x e calculando# a distancia de Mahalanobis entre x e mu
# Esta seia a distancia que usariamos caso quisessemos alocar
# o novo ponto x usando os outros dados.
# Vamosavaliar as taxas de erro cometidos.
# Assumimos custo iguais e proporcoes iguais nas
# duas populacoes
maha = matrix(0, nrow=nrow(skull), ncol=2)
pop1 = skull[period == 1, ]
pop2 = skull[period == 2, ]
mu1 = apply(pop1, 2, mean); 
mu2 = apply(pop2, 2, mean)
matcov1 = cov(pop1);
matcov2 = cov(pop2)
det1 = log(det(matcov1)); 
det2 = log(det(matcov2))
for(i in 1:60){
  aux1 = pop1[-i,]
  aux2 = pop2[-i,]
  mu1i = apply(aux1, 2, mean)
  mu2i = apply(aux2, 2, mean)
  matcov1i = cov(pop1[-i,])
  matcov2i = cov(pop1[-i,])
  det1i = log(det(matcov1i))
  det2i = log(det(matcov2i))
  maha[i,1]  = mahalanobis(pop1[i,], mu1i, matcov1i) - det1i
  maha[i,2]  = mahalanobis(pop1[i,], mu2, matcov2) - det2
  maha[i+60,1] = mahalanobis(pop2[i,], mu1, matcov1) - det1
  maha[i+60,2] = mahalanobis(pop2[i,], mu2i, matcov2i) - det2i
  }

difmaha = maha[,1] - maha[,2]
boxplot(difmaha ~ period)
## Vemos que a maioria dos pontos da pop1 possuem distancia de## Mahalanobis a pop1 menor que a distancia a 
#pop 2 (isto eh,## difmaha < 0 quando pop1 ==1), enquanto o oposto ocorre## com os pontos da pop2.
# binaria indicando quem seria classificado em pop2class2 = difmaha > 0
tabmaha = table(class2, period)tabmaha
# proporcao de acerto global
sum(diag(tabmaha)) / sum(tabmaha)
# acerta 65.8% dos dados, independentemente de onde venham
# propocao de acerto dentro de cada populacao, estimativa de
# P(classif em k | pertence a k)
prop.table(table(class2, period), margin = 2)
# Acerta 61.7% para x vindo da pop1 e acerta 70% para x vindo de pop2
# A probab reversa: P(pertence a k | classif em k)
prop.table(table(class2, period), margin = 1)

