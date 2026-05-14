# Dashboard de Cuota de Ventas

Este ejemplo ilustra los conceptos descritos en `Modelos_BI/R_para_BI.md` para crear un dashboard interactivo con **Shiny** y **flexdashboard** que muestra el KPI de **cuota de ventas**.

## Conceptos ilustrados

Del documento `R_para_BI.md`:

- **Sección 3 (Shiny)**: Aplicaciones interactivas y dashboards para BI
  - Subsección: "Shiny en el trabajo estratégico: tableros de control y dashboards"
  - Implementación de un dashboard ejecutivo de ventas con KPIs
  - Visualización del cumplimiento de cuota mensual con indicadores visuales (color verde/rojo)

## Estructura

| Archivo | Propósito |
|---------|-----------|
| `dashboard_cuota.Rmd` | Archivo fuente R Markdown con código R, flexdashboard y Shiny |
| `dashboard_cuota.html` | Dashboard renderizado (listo para abrir en navegador) |
| `generar_datos.R` | Script opcional que genera los datos artificiales usados |

## Cómo usar

1. Abrir `dashboard_cuota.html` directamente en el navegador para ver el dashboard estático.
2. Para la versión interactiva con Shiny, abrir `dashboard_cuota.Rmd` en RStudio y hacer click en **Run Document** (requiere los paquetes `flexdashboard`, `shiny`, `dplyr`, `ggplot2`, `plotly`, `scales`).

## Datos artificiales

Los datos se generan con `set.seed(123)` para garantizar reproducibilidad. Se simulan:
- Ventas diarias de 4 regiones durante un mes (30 días)
- Montos entre USD 1,000 y USD 25,000 por día
- Cuota mensual por región de USD 150,000




## NOTAS:

El dashboard __funciona correctamente__. Lo que ocurrió es que:

__El problema con el HTML estático__: El archivo `dashboard_cuota.Rmd` tiene `runtime: shiny` (línea 11), lo que significa que es una __aplicación web interactiva__, no un documento HTML estático. Al abrir `dashboard_cuota.html` directamente en el navegador, solo ves la plantilla vacía porque los gráficos se cargan dinámicamente cuando el servidor Shiny está activo.

__Prueba exitosa__: Ejecuté el dashboard con Shiny y se inició correctamente en `http://127.0.0.1:3939`, respondiendo sin errores.

__Para usarlo correctamente, tienes dos opciones:__

1. ✅ __Desde RStudio__ (recomendado):

   - Abre `Ejemplos/dashboard_cuota/dashboard_cuota.Rmd` en RStudio
   - Haz clic en __"Run Document"__ (botón justo arriba del editor)
   - Se abrirá automáticamente el dashboard funcional en tu navegador

2. ✅ __Desde terminal__ (si no tienes RStudio):

   ```bash
   R -e 'rmarkdown::run("Ejemplos/dashboard_cuota/dashboard_cuota.Rmd")'
   ```

   Luego abre `http://127.0.0.1:3939` en tu navegador

__Los datos artificiales se generan en tiempo real__ con `set.seed(123)` para reproducibilidad, así que cada vez que inicies la app verás los mismos datos: ventas diarias de 4 regiones, con una cuota mensual de $150,000 cada una.
