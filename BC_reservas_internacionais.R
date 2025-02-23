library(rbcb)
library(dplyr)
library(ggplot2)
library(scales)

reservas = get_series(13621, start_date = "2024-01-01")

reservas_renomeado <- reservas %>%
  rename(data = date, reservas = "13621") %>%
  mutate(ano_mes = format(data, "%Y-%m")) # Criar coluna Ano-Mês

# Plotar o gráfico com valores em milhões de reais
ggplot(reservas_renomeado, aes(x = data, y = reservas / 1e3)) +  # Divide os valores por 1 milhão
  geom_line(color = "blue") +  # Linha do gráfico
  labs(title = "Reservas Internacionais Banco Central",  # Título do gráfico
       y = "Reservas (em milhões de dólares)") +  # Rótulo do eixo Y
  scale_y_continuous(labels = label_number(big.mark = ".", decimal.mark = ",")) +  # Formata os rótulos do eixo Y
  theme_minimal()  # Tema minimalista para o gráfico
