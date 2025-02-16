# CAMBIO
install.packages("BETS")
install.packages(c("ggplot2", "scales", "Quandl"))

# ggplot2 <- criar gráficos
library(ggplot2)
# scales <- formatar o eixo X com datas
library(scales)
# Quandl <- dados temporais do site quandl
library(Quandl)
# BETS <- pacote "Brazilian Economic Time Series" que acessa diretamente do BC
library(BETS)

# Pegando os dados de câmbio desde 1999
cambio <- BETSget(3697, from = "1999-07-01")
head(cambio)
str(cambio)

# Plotando o gráfico
ggplot(cambio, aes(x = date, y = value)) +
  geom_line(linewidth = 0.8, colour = "darkblue") +  # Corrigido 'size' para 'linewidth'
  xlab("") + 
  ylab("R$/US$") +
  ggtitle("Taxa de Câmbio R$/US$") +
  scale_x_date(breaks = date_breaks("1 year"), labels = date_format("%Y")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
