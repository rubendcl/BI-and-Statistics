# R como solución de Business Intelligence

## ¿Qué es R?

**R** es un lenguaje de programación y entorno de software libre especializado en **análisis estadístico**, **minería de datos** y **visualización de información**. Fue desarrollado inicialmente por Ross Ihaka y Robert Gentleman en la Universidad de Auckland, Nueva Zelanda, y hoy en día es mantenido por el **R Core Team** y una comunidad activa de más de dos millones de usuarios en todo el mundo.

R se distribuye bajo la licencia **GNU General Public License**, lo que lo convierte en una herramienta **completamente gratuita y de código abierto**, sin restricciones de uso comercial.

---

## Ventajas de usar R como solución BI

### 1. Gratuito y de código abierto
- Sin costos de licencias, a diferencia de herramientas propietarias como SAS, SPSS o Tableau.
- Acceso al código fuente, lo que permite auditoría, personalización y transparencia total en los algoritmos utilizados.

### 2. Amplio ecosistema de paquetes (CRAN)
- El **Comprehensive R Archive Network (CRAN)** alberga más de **20,000 paquetes** desarrollados por la comunidad.
- Paquetes clave para BI:
  - **`dplyr`** / **`data.table`** — manipulación y transformación de datos.
  - **`ggplot2`** — visualización de datos de alto nivel (gramática de gráficos).
  - **`tidyr`** — limpieza y reestructuración de datos.
  - **`shiny`** — creación de dashboards y aplicaciones web interactivas.
  - **`rmarkdown`** — generación de reportes dinámicos en HTML, PDF y Word.
  - **`plotly`** — gráficos interactivos.
  - **`DBI`** / **`odbc`** — conexión a bases de datos relacionales.

### 3. Capacidades estadísticas y analíticas avanzadas
- R fue diseñado desde sus orígenes para el análisis estadístico, lo que le otorga una ventaja frente a herramientas de BI puramente visuales.
- Modelos soportados de forma nativa:
  - Regresiones lineales y logísticas.
  - Series temporales (ARIMA, Prophet, etc.).
  - Análisis de clustering (k-means, jerárquico).
  - Árboles de decisión y random forests.
  - Análisis de componentes principales (PCA).
  - Pruebas de hipótesis (t-test, ANOVA, chi-cuadrado).

### 4. Visualización de datos de alta calidad
- Con **`ggplot2`** se pueden crear gráficos publicables con un control fino sobre cada elemento visual.
- Integración con librerías interactivas como **`plotly`**, **`highcharter`** y **`leaflet`** (mapas).
- Posibilidad de generar dashboards completos con **`shiny`** y **`flexdashboard`**.

### 5. Reproducibilidad y reportes automatizados
- **R Markdown** y **Quarto** permiten combinar código, texto explicativo y resultados en un solo documento.
- Los análisis pueden ejecutarse de forma programada, generando reportes actualizados automáticamente.
- Ideal para auditoría y cumplimiento normativo, ya que cada paso del análisis queda documentado.

### 6. Integración con múltiples fuentes de datos
- R puede conectarse a:
  - Bases de datos SQL (MySQL, PostgreSQL, SQL Server, Oracle) mediante **`DBI`** y **`odbc`**.
  - Archivos planos (CSV, Excel, JSON, XML).
  - APIs REST y web scraping (**`httr`**, **`rvest`**, **`jsonlite`**).
  - Big Data: **`sparklyr`** (Apache Spark), **`arrow`** (formatos columnar).
  - Almacenes en la nube: AWS S3, Google Cloud Storage, Azure Blob.

### 7. Comunidad activa y soporte continuo
- Foros como **Stack Overflow**, **RStudio Community** y **R-bloggers** ofrecen soporte constante.
- Múltiples conferencias anuales (useR!, RStudio Conference, LatinR).
- Documentación extensa y tutoriales disponibles en múltiples idiomas.

### 8. Curva de aprendizaje accesible
- Aunque es un lenguaje de programación, su sintaxis está orientada a facilitar operaciones con datos.
- Entornos como **RStudio** (hoy **Posit**) proporcionan una interfaz amigable con editor, consola, visor de gráficos y gestor de archivos integrados.

---

## Comparativa con otras herramientas BI

| Característica               | R                     | Power BI / Tableau     | Python (con pandas)     |
|------------------------------|-----------------------|------------------------|-------------------------|
| Costo                        | Gratuito              | Licencias costosas     | Gratuito                |
| Análisis estadístico         | Excelente (nativo)    | Limitado               | Excelente               |
| Visualización                | Muy buena             | Excelente (interactiva)| Buena                   |
| Curva de aprendizaje         | Moderada              | Baja                   | Moderada-alta           |
| Reproducibilidad             | Alta                  | Media                  | Alta                    |
| Integración con bases de datos| Muy buena             | Buena                  | Muy buena               |
| Dashboards interactivos      | Shiny / Flexdashboard | Nativo                 | Dash / Streamlit        |

---

## Flujo de trabajo típico de BI con R

```
+---------------+    +----------------+    +----------------+    +--------------------+
|  Extraccion   | -> |   Limpieza     | -> |   Analisis     | -> |  Visualizacion     |
|  (lectura     |    |  y             |    |  estadistico   |    |  y reportes        |
|   de datos)   |    |  transformacion|    |  y modelado    |    |  (ggplot2,         |
|               |    |  (dplyr,       |    |  (modelos      |    |   Shiny,           |
|               |    |   tidyr)       |    |   predictivos) |    |   R Markdown)      |
+---------------+    +----------------+    +----------------+    +--------------------+
```

---

## Ejemplo mínimo de análisis BI con R

```r
# Cargar librerías
library(dplyr)
library(ggplot2)

# Leer datos
ventas <- read.csv("ventas.csv")

# Resumen por región
resumen <- ventas %>%
  group_by(region) %>%
  summarise(
    total_ventas = sum(monto),
    promedio      = mean(monto),
    transacciones = n()
  )

# Visualización
ggplot(resumen, aes(x = region, y = total_ventas, fill = region)) +
  geom_col() +
  labs(title = "Ventas totales por región", x = "Región", y = "Total ventas") +
  theme_minimal()
```

---

## Trabajo colaborativo con R y GitHub

En un entorno BI real, los análisis rara vez los realiza una sola persona. Los equipos de datos necesitan colaborar sobre el mismo código, compartir reportes, revisar cambios y mantener un historial de todas las transformaciones y modelos desarrollados. Aquí es donde **GitHub** se convierte en un pilar fundamental de la solución BI con R.

### 1. Control de versiones para análisis de datos

- **Git** permite llevar un historial completo de cada cambio en scripts `.R`, reportes `.Rmd`, dashboards Shiny y configuraciones.
- Cada análisis queda registrado con fecha, autor y mensaje descriptivo, facilitando la **auditoría** y la **reproducibilidad**.
- Si un cambio introduce un error, es posible revertir a una versión anterior con un solo comando.

### 2. GitHub como repositorio central del equipo BI

- GitHub actúa como el **único origen de verdad (*single source of truth*)** para todo el código de análisis.
- Los miembros del equipo clonan, actualizan y sincronizan sus cambios desde un mismo repositorio, eliminando la confusión de versiones locales dispersas.
- Ejemplo de estructura de repositorio BI con R:

```
proyecto-bi/
|-- .Rprofile
|-- renv.lock               # Dependencias reproducibles (renv)
|-- data/
|   |-- raw/                 # Datos crudos (inmutables)
|   |-- processed/           # Datos transformados
|-- scripts/
|   |-- 01_extraccion.R
|   |-- 02_limpieza.R
|   |-- 03_modelo.R
|-- reports/
|   |-- informe_ventas.Rmd
|   |-- dashboard/
|   |   |-- app.R            # Aplicacion Shiny
|-- tests/                   # Pruebas unitarias (testthat)
|-- README.md
|-- .gitignore
```

### 3. Flujo de trabajo colaborativo con pull requests

El flujo típico de trabajo en equipo utilizando GitHub incluye:

1. **Crear una rama (*branch*)** para una tarea específica (nuevo modelo, corrección de reporte, limpieza de datos).
2. **Desarrollar y confirmar cambios (*commit*)** localmente, con mensajes descriptivos.
3. **Subir la rama a GitHub (*push*)** y abrir un **Pull Request (PR)**.
4. **Revisión de código (*code review*)** por parte de otros miembros del equipo, asegurando calidad y consistencia.
5. **Integración continua** mediante GitHub Actions que ejecutan los scripts de R automáticamente.
6. **Fusión (*merge*)** a la rama principal una vez aprobado y verificado.

### 4. Integración continua con GitHub Actions

GitHub Actions permite automatizar la ejecución de análisis de R directamente desde el repositorio:

```yaml
# .github/workflows/analisis-bi.yml
name: Análisis BI automatizado

on:
  push:
    branches: [ main ]
  schedule:
    - cron: '0 6 * * 1'   # Todos los lunes a las 06:00 UTC

jobs:
  render:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: r-lib/actions/setup-r@v2
      - uses: r-lib/actions/setup-renv@v2
      - name: Renderizar reporte R Markdown
        run: Rscript -e 'rmarkdown::render("reports/informe_ventas.Rmd")'
      - name: Subir reporte generado
        uses: actions/upload-artifact@v4
        with:
          name: informe-ventas
          path: reports/informe_ventas.html
```

Este flujo permite:
- **Actualizar reportes automáticamente** cada semana o tras cada cambio en los datos.
- **Ejecutar pruebas** (`testthat`) para validar que las transformaciones y modelos siguen funcionando.
- **Notificar al equipo** si algún análisis falla después de un cambio.

### 5. Integración con RStudio / Posit

- RStudio (hoy Posit) incluye soporte nativo para Git, permitiendo realizar commits, push, pull y crear ramas desde la interfaz gráfica.
- **GitHub Copilot** puede asistir en la escritura de código R directamente desde RStudio.
- **Posit Cloud** y **Posit Connect** se integran con repositorios de GitHub para desplegar dashboards Shiny y reportes R Markdown automáticamente.

### 6. Gestión de dependencias reproducibles con `renv`

- El paquete **`renv`** crea un archivo `renv.lock` que registra las versiones exactas de cada paquete de R utilizado.
- Al incluir `renv.lock` en el repositorio de GitHub, todo el equipo (y la CI) puede restaurar el mismo entorno con `renv::restore()`.
- Esto elimina los problemas de *"en mi máquina funciona"* y garantiza reproducibilidad total.

### 7. Beneficios de integrar GitHub en la solución BI con R

| Beneficio                  | Descripción                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| **Trazabilidad total**     | Cada análisis, modelo y reporte tiene un historial completo de cambios.     |
| **Colaboración asíncrona** | Varios analistas pueden trabajar en paralelo sin pisarse el trabajo.        |
| **Calidad del código**     | Las revisiones mediante PR mejoran la calidad y detectan errores a tiempo.  |
| **Automatización**         | GitHub Actions ejecuta análisis y genera reportes sin intervención manual.  |
| **Reproducibilidad**       | `renv` + Git garantizan que el análisis se puede replicar en cualquier momento. |
| **Onboarding rápido**      | Un nuevo miembro del equipo clona el repositorio y tiene todo listo.        |

En definitiva, **GitHub no es solo un lugar donde almacenar código**: es una plataforma completa que potencia el trabajo en equipo, automatiza procesos y eleva la calidad y confiabilidad de una solución de Business Intelligence basada en R.

---

## Documentación del trabajo BI con R Markdown y Markdown

En toda solución de Business Intelligence, el análisis de datos es solo una parte del ciclo. Para que los resultados generen valor real en la organización, es necesario **documentar, exponer y distribuir** el conocimiento de manera clara, accesible y reutilizable. Aquí es donde **R Markdown (`.Rmd`)** y **Markdown (`.md`)** juegan un papel central.

### 1. R Markdown: reportes dinámicos que integran código y narrativa

**R Markdown** permite combinar en un solo archivo:
- **Texto explicativo** en Markdown, para describir objetivos, metodología, hipótesis y conclusiones.
- **Código R ejecutable**, que se evalúa al renderizar el documento y produce resultados actualizados automáticamente.
- **Salidas enriquecidas**: tablas, gráficos estáticos e interactivos, y valores calculados en línea.

Esto transforma un script de R tradicional en un **reporte BI completo y reproducible**. Cada vez que se renderiza el `.Rmd`, se actualizan todos los resultados con los datos más recientes, eliminando el trabajo manual de copiar y pegar números o gráficos en presentaciones o correos.

```markdown
---
title: "Informe mensual de ventas"
author: "Equipo BI"
date: "`r Sys.Date()`"
output: html_document
---

## Resumen ejecutivo

En `r month.name[month(Sys.Date()) - 1]` se procesaron
**`r format(total_transacciones, big.mark = ",")`** transacciones,
con un ingreso total de **`r scales::dollar(ingreso_total)`**.

```{r echo=FALSE, message=FALSE}
library(dplyr)
library(ggplot2)

ventas <- read.csv("data/ventas_mensuales.csv")

total_transacciones <- nrow(ventas)
ingreso_total <- sum(ventas$monto)

ventas %>%
  group_by(region) %>%
  summarise(Ventas = sum(monto)) %>%
  ggplot(aes(x = region, y = Ventas, fill = region)) +
  geom_col() +
  labs(title = "Ventas por región") +
  theme_minimal()
```

Los resultados indican que la región con mayor crecimiento fue...
```

### 2. Diferencias y usos de `.Rmd` y `.md` en el proceso BI

| Formato | Propósito principal | Contiene código ejecutable | Salida típica                     |
|---------|---------------------|----------------------------|------------------------------------|
| `.Rmd`  | Análisis y reportes dinámicos | Sí (bloques ` ```{r} ... `)  | HTML, PDF, Word, PowerPoint, Dashboard |
| `.md`   | Documentación estática y difusión | No                         | Archivo de texto plano visualizable en GitHub, GitLab, etc. |

**Cuándo usar cada uno:**

- **`.Rmd`**: Para la fase de *análisis y generación de reportes*. Es el archivo fuente que contiene la lógica completa del análisis (código + explicación). Se renderiza para producir el entregable final.
- **`.md`**: Para la fase de *difusión y documentación permanente*. Una vez que el análisis está completo y validado, se puede generar o escribir un `.md` que presente los resultados de forma legible directamente en GitHub, sin necesidad de ejecutar código. También es el formato ideal para documentar procesos, acuerdos, guías de estilo y decisiones del equipo BI.

### 3. Flujo de documentación dentro del proceso BI

La documentación debe integrarse como una fase explícita dentro del flujo de trabajo BI:

```
+---------+    +----------+    +----------+    +-------------+    +----------------+
| Datos   | -> | Análisis | -> | Reporte  | -> | Revisión    | -> | Publicación    |
| crudos  |    | en R     |    | dinámico |    | en GitHub   |    | y difusión     |
|         |    | (.R)     |    | (.Rmd)   |    | (PR + code  |    | (.md, HTML,    |
|         |    |          |    |          |    | review)     |    | PDF, correo)   |
+---------+    +----------+    +----------+    +-------------+    +----------------+
                                                      |
                                                      v
                                             +------------------+
                                             | Documentación    |
                                             | en .md (README,  |
                                             | wiki, guías)     |
                                             +------------------+
```

1. **Los scripts `.R`** contienen la lógica de extracción, limpieza y modelado.
2. **Los archivos `.Rmd`** envuelven esa lógica en un reporte narrativo, explicando el *qué*, *por qué* y *cómo* de cada paso.
3. **La revisión en GitHub** mediante Pull Requests permite que el equipo valide tanto el código como la narrativa antes de publicar.
4. **Los archivos `.md`** (README, documentación de procesos, guías de estilo) mantienen la documentación viva y accesible para toda la organización.
5. **La publicación** puede ser automática (GitHub Actions renderiza el `.Rmd` y despliega el `.html` en GitHub Pages) o manual (se comparte el PDF por correo o se sube a una intranet).

### 4. GitHub Pages como plataforma de difusión

GitHub Pages permite publicar los reportes HTML generados desde `.Rmd` directamente como sitio web, sin necesidad de infraestructura adicional:

```yaml
# .github/workflows/deploy-report.yml
name: Desplegar reporte BI

on:
  push:
    branches: [ main ]
    paths:
      - 'reports/**/*.Rmd'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: r-lib/actions/setup-r@v2
      - uses: r-lib/actions/setup-renv@v2
      - name: Renderizar y publicar
        run: |
          Rscript -e 'rmarkdown::render("reports/informe_ventas.Rmd")'
          mkdir -p docs
          cp reports/informe_ventas.html docs/index.html
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
```

Una vez configurado, el reporte estará disponible en `https://<organizacion>.github.io/<repositorio>/` y cualquier persona en la organización puede acceder a la última versión del análisis sin necesidad de instalar R ni ejecutar código.

### 5. Buenas prácticas de documentación BI con R Markdown

| Práctica                          | Descripción                                                                |
|-----------------------------------|----------------------------------------------------------------------------|
| **Incluir metadatos**             | Título, autor, fecha, versión y propósito del análisis en el encabezado YAML. |
| **Separar código y narrativa**    | Explicar en lenguaje natural cada bloque de código; no asumir que el lector conoce R. |
| **Documentar supuestos**          | Especificar qué filtros, umbrales o transformaciones se aplicaron y por qué. |
| **Incluir advertencias**          | Indicar limitaciones de los datos, tamaño de muestra, o periodos no cubiertos. |
| **Versionar los `.Rmd`**          | Almacenarlos en el repositorio Git junto con los `.R` para mantener la trazabilidad. |
| **Generar siempre una versión `.md`** | Resumir los hallazgos clave en un `.md` visible directamente en GitHub para consulta rápida. |
| **Automatizar la renderización**  | Usar GitHub Actions para regenerar reportes periódicamente o ante cada cambio. |

### 6. Impacto en la organización

Una estrategia de documentación bien implementada con R Markdown y Markdown produce beneficios concretos:

- **Alta dirección y stakeholders**: Reciben reportes ejecutivos (HTML/PDF) con gráficos y conclusiones claras, sin necesidad de ver código.
- **Equipo de datos**: Dispone de documentación técnica (`.md` + `.Rmd`) que explica cada decisión analítica, facilitando el mantenimiento y la rotación de personal.
- **Auditores y cumplimiento**: Pueden rastrear exactamente qué datos y métodos se usaron en cada reporte, gracias al control de versiones de Git y la reproducibilidad de R Markdown.
- **Nuevos integrantes**: Se ponen al día rápidamente leyendo la documentación y ejecutando los reportes existentes.

En resumen, **documentar el trabajo BI en `.Rmd` y `.md` no es un paso opcional**: es el puente que conecta el análisis técnico con la toma de decisiones organizacional, garantizando que los resultados no se queden en el ordenador del analista sino que se difundan, comprendan y aprovechen en toda la empresa.

---

## Conclusión

R es una solución BI **poderosa, flexible y gratuita** que cubre todo el ciclo de vida del análisis de datos: desde la extracción y limpieza hasta la visualización, modelado predictivo y generación de reportes automatizados. Si bien herramientas como Power BI o Tableau ofrecen una experiencia más visual e inmediata, R destaca cuando se requiere **rigor estadístico**, **reproducibilidad** y **personalización avanzada**, convirtiéndolo en una opción ideal para equipos de datos que buscan una solución BI completa y escalable sin depender de software propietario.