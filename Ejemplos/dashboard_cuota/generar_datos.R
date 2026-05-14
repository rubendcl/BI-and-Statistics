# =============================================================================
# Generar datos artificiales de ventas para el dashboard de cuota de ventas
# =============================================================================
# Este script genera un data.frame con ventas diarias simuladas para 4 regiones
# durante un período de 30 días.
#
# Concepto ilustrado de R_para_BI.md:
#   - Seccion 3: Shiny en el trabajo estrategico: tableros de control y dashboards
#   - Uso de dplyr para manipulacion y ggplot2/plotly para visualizacion
# =============================================================================

library(dplyr)

# Fijar semilla para reproducibilidad
set.seed(123)

# Parametros de la simulacion
meses <- c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
           "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")
region <- c("Norte", "Sur", "Este", "Oeste")
cuota_mensual <- 150000  # Cuota mensual por region (USD)

# Generar datos: 30 dias x 4 regiones = 120 registros
ventas <- expand.grid(
  dia       = 1:30,
  region    = region,
  mes       = meses[6],           # Junio
  anio      = 2026,
  stringsAsFactors = FALSE
) %>%
  mutate(
    # Monto diario con tendencia creciente y ruido aleatorio
    # Las regiones tienen distintos rendimientos base
    monto_base = case_when(
      region == "Norte" ~ 5000,
      region == "Sur"   ~ 4500,
      region == "Este"  ~ 5500,
      region == "Oeste" ~ 4000
    ),
    # Tendencia semanal: lunes mas bajo, viernes mas alto
    dia_semana  = (dia - 1) %% 7 + 1,
    factor_dia  = case_when(
      dia_semana == 1 ~ 0.8,   # Lunes
      dia_semana == 2 ~ 0.9,   # Martes
      dia_semana == 3 ~ 1.0,   # Miercoles
      dia_semana == 4 ~ 1.1,   # Jueves
      dia_semana == 5 ~ 1.2,   # Viernes
      TRUE            ~ 0.7    # Fin de semana
    ),
    # Tendencia creciente a lo largo del mes (efecto "cierre de mes")
    factor_mes = 1 + (dia / 30) * 0.3,
    # Monto final = base * factor_dia * factor_mes + ruido aleatorio
    monto = round(
      monto_base * factor_dia * factor_mes +
        rnorm(n(), mean = 0, sd = 1000),
      0
    ),
    # Asegurar montos positivos
    monto = pmax(monto, 500),
    # Fecha
    fecha = as.Date(paste(anio, match(mes, meses), dia, sep = "-"))
  ) %>%
  select(fecha, mes, anio, region, monto, dia)

# Verificar resumen
cat("========================================\n")
cat("Resumen de datos generados\n")
cat("========================================\n")
print(ventas %>% group_by(region) %>%
        summarise(
          total_ventas = sum(monto),
          promedio_diario = mean(monto),
          cuota_asignada = cuota_mensual,
          cumplimiento = scales::percent(total_ventas / cuota_mensual),
          .groups = "drop"
        ))

cat("\nTotal acumulado:", scales::dollar(sum(ventas$monto)), "\n")
cat("Cuota total (4 regiones):", scales::dollar(cuota_mensual * 4), "\n")

# Guardar como CSV
write.csv(ventas, "ventas_mensuales.csv", row.names = FALSE)
cat("\nDatos guardados en: ventas_mensuales.csv\n")