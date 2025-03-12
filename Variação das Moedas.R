library(quantmod)
library(ggplot2)

# Definir paleta de cores
cores_padrao <- c( 
  azul_escuro1 = "#002C5E",
  azul_escuro2 = "#02023C",
  amarelo = "#FEB712",
  cinza_claro = "#A6A6A6",
  cinza_escuro = "#3A3A3A",
  azul_claro = "#46B1E1"
)

# Definir as moedas e seus nomes
moedas <- c("BRL=X", "ARS=X", "UYU=X", "EUR=X", "INR=X", "ZAR=X")
nomes_moedas <- c(
  "BRL=X" = "Real Brasileiro",
  "ARS=X" = "Peso Argentino",
  "UYU=X" = "Peso Uruguaio",
  "EUR=X" = "Euro",
  "INR=X" = "Rupia Indiana",
  "ZAR=X" = "Rand Sul-Africano"
)

# Calcular as datas
data_atual <- Sys.Date()
ultima_sexta <- data_atual - ((as.numeric(format(data_atual, "%u")) - 5) %% 7)
penultima_sexta <- ultima_sexta - 7  # Alterado para "penultima_sexta"

# Inicializar data frame para armazenar variações
variacao <- data.frame(
  Moeda = character(),
  Variacao = numeric(),
  stringsAsFactors = FALSE
)

# Loop para cada moeda
for (moeda in moedas) {
  tryCatch({
    # Baixar dados
    dados <- getSymbols(Symbols = moeda, from = penultima_sexta - 3, to = ultima_sexta + 3, auto.assign = FALSE)
    
    # Extrair preços de fechamento
    fechamento_ultima_sexta <- Cl(dados[paste(ultima_sexta)])
    fechamento_penultima_sexta <- Cl(dados[paste(penultima_sexta)])
    
    # Calcular variação percentual
    variacao_percentual <- (as.numeric(fechamento_ultima_sexta) / as.numeric(fechamento_penultima_sexta) - 1) * 100
    
    # Adicionar ao data frame
    variacao <- rbind(variacao, data.frame(
      Moeda = nomes_moedas[moeda],
      Variacao = variacao_percentual,
      stringsAsFactors = FALSE
    ))
  }, error = function(e) {
    warning(paste("Erro ao processar", moeda, ":", conditionMessage(e)))
  })
}
ggplot(variacao, aes(x = Moeda, y = Variacao)) +
  geom_bar(stat = "identity", fill = cores_padrao["azul_escuro1"]) +  # Barras com cor azul
  geom_text(aes(label = paste0(round(Variacao, 2), "%")),  # Adicionar valores em cima das barras
            vjust = -0.5,  # Ajustar a posição vertical do texto
            color = cores_padrao["cinza_claro"],  # Cor do texto
            size = 4) +  # Tamanho do texto
  labs(
    title = paste("Variação Percentual Semanal"), 
    y = "Variação Percentual (%)",
    caption = paste("Fonte: Yahoo Finance | Atualizado em", format(ultima_sexta, "%d/%m/%Y"))
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",  # Remover legenda lateral
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10, color = "black"),  # Ajuste dos rótulos no eixo X
    axis.text.y = element_text(size = 10, color = "black"),
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold", color = "black"),
    plot.caption = element_text(hjust = 0.5, size = 10, color = "gray50")  # Ajuste da legenda
  )
