library(rbcb)
library(dplyr)
library(ggplot2)

taxa_cambio_compra = get_series(10813, start_date = "2024-01-01")

# Certifique-se de que o dataframe cambio_compra está correto
cambio_compra <- taxa_cambio_compra %>%
  rename(data = date, taxa_cambio = "10813") %>%
  mutate(ano_mes = format(data, "%Y-%m"))

# Plotar o gráfico
ggplot(cambio_compra, aes(x = data, y = taxa_cambio)) +  # Use taxa_cambio, não cambio_compra
  geom_line(color = "blue", linewidth = 1.5) +  # Use linewidth em vez de size
  labs(
    title = "Taxa de Câmbio de Compra (USD/BRL)",  # Título do gráfico
    x = "Data",  # Rótulo do eixo X
    y = "Taxa de Câmbio (R$)",  # Rótulo do eixo Y
    caption = "Fonte: Banco Central do Brasil"  # Fonte dos dados
  ) +
  theme_minimal() +  # Tema minimalista
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),  # Centralizar e formatar o título
    axis.title.x = element_text(size = 12),  # Formatar rótulo do eixo X
    axis.title.y = element_text(size = 12),  # Formatar rótulo do eixo Y
    axis.text.x = element_text(angle = 45, hjust = 1)  # Rotacionar rótulos do eixo X
  )
