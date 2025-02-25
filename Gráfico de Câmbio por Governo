library(rbcb)
library(dplyr)
library(ggplot2)

# Baixar dados do Banco Central do Brasil desde 2011 (início do governo Dilma)
taxa_cambio_compra <- get_series(10813, start_date = "2011-01-01")

# Ajustar os dados
cambio_compra <- taxa_cambio_compra %>%
  rename(data = date, taxa_cambio = "10813") %>%
  mutate(
    ano_mes = format(data, "%Y-%m"),
    governo = case_when(
      data >= as.Date("2011-01-01") & data <= as.Date("2016-08-31") ~ "Dilma",
      data >= as.Date("2016-09-01") & data <= as.Date("2018-12-31") ~ "Temer",
      data >= as.Date("2019-01-01") & data <= as.Date("2022-12-31") ~ "Bolsonaro",
      data >= as.Date("2023-01-01") ~ "Lula"
    )
  )

# Criar o gráfico com cores diferentes por governo
ggplot(cambio_compra, aes(x = data, y = taxa_cambio, color = governo)) + 
  geom_line(linewidth = 0.9) +  
  scale_color_manual(values = c("Dilma" = "red", "Temer" = "blue", "Bolsonaro" = "green", "Lula" = "red")) +  
  labs(
    title = "Taxa de Câmbio de Compra (USD/BRL)",
    subtitle = "Evolução conforme o governo",
    x = "Data",
    y = "Taxa de Câmbio (R$)",
    caption = "Fonte: Banco Central do Brasil",
    color = "Governo"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 12),
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
