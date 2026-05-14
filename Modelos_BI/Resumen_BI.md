# Business Intelligence (BI)

## 1. ¿Qué es Business Intelligence?

**Business Intelligence (BI)** es el conjunto de procesos, tecnologías y herramientas que permiten transformar datos brutos en información significativa y útil para la toma de decisiones estratégicas, tácticas y operativas dentro de una organización.

El objetivo principal del BI es proporcionar a los tomadores de decisiones acceso rápido y fácil a información relevante, histórica y actual, para comprender el desempeño del negocio, identificar tendencias, detectar problemas y descubrir oportunidades de mejora.

### 1.1. Componentes clave del BI

- **Fuentes de datos:** Sistemas transaccionales (ERP, CRM), bases de datos operacionales, archivos planos (CSV, Excel), datos externos (API, web scraping), etc.
- **ETL (Extract, Transform, Load):** Proceso de extraer datos de las fuentes originales, transformarlos (limpiar, estandarizar, integrar) y cargarlos en un repositorio centralizado.
- **Almacenamiento de datos:** Data Warehouse, Data Mart o Data Lake, donde los datos se organizan para consultas analíticas.
- **Herramientas de análisis y visualización:** Software que permite explorar los datos, generar reportes, dashboards y gráficos interactivos (por ejemplo, Power BI, Tableau, R, Python).
- **Entrega de información:** Reportes periódicos, dashboards en tiempo real, alertas y análisis ad-hoc.

---

## 2. Arquitectura de Business Intelligence

Una arquitectura típica de BI sigue un flujo de varias capas:

### 2.1. Capa de fuentes de datos
Comprende todos los sistemas y repositorios donde se generan o almacenan los datos operacionales. Pueden ser bases de datos relacionales (MySQL, PostgreSQL, SQL Server), sistemas ERP (SAP, Oracle), CRM (Salesforce), archivos planos, logs de aplicaciones, etc.

### 2.2. Capa de integración de datos (ETL/ELT)
Aquí los datos son extraídos, transformados (limpieza, deduplicación, validación, cálculo de métricas) y cargados en el almacén de datos. En enfoques modernos se utiliza **ELT** (Extract, Load, Transform), donde los datos se cargan primero y se transforman después dentro del Data Warehouse.

### 2.3. Capa de almacenamiento
- **Data Warehouse (DW):** Repositorio centralizado, orientado a sujetos, integrado, no volátil y variante en el tiempo. Almacena datos históricos y actuales optimizados para consultas analíticas (modelo estrella, copo de nieve).
- **Data Mart:** Subconjunto del Data Warehouse orientado a un área específica del negocio (ventas, finanzas, marketing).
- **Data Lake:** Repositorio que almacena datos en su formato original (estructurados, semiestructurados, no estructurados), ideal para big data y machine learning.

### 2.4. Capa de análisis y presentación
Herramientas que permiten a los usuarios finales consultar, visualizar y analizar los datos: dashboards interactivos, reportes estáticos, OLAP (Online Analytical Processing), minería de datos y modelos predictivos.

---

## 3. Modelado Dimensional

El modelado dimensional es la técnica más utilizada en BI para diseñar Data Warehouses y Data Marts. Fue propuesto por Ralph Kimball y se basa en dos tipos de tablas:

### 3.1. Tablas de hechos (Fact Tables)
Contienen las medidas cuantitativas del negocio (ventas, cantidad, ingresos, costos) y claves foráneas que las conectan con las tablas de dimensiones. Son largas y angostas, y su granularidad define el nivel de detalle de los datos.

### 3.2. Tablas de dimensiones (Dimension Tables)
Contienen los atributos descriptivos del negocio (tiempo, producto, cliente, ubicación, empleado). Son más cortas y anchas, y proporcionan el contexto para analizar las métricas de las tablas de hechos.

### 3.3. Esquemas comunes

- **Esquema estrella (Star Schema):** Una tabla de hechos central rodeada de tablas de dimensiones desnormalizadas. Es simple, rápido de consultar y fácil de entender.
- **Esquema copo de nieve (Snowflake Schema):** Las tablas de dimensiones están normalizadas en múltiples tablas relacionadas. Requiere más joins pero ahorra espacio de almacenamiento.
- **Esquema constelación (Fact Constellation):** Múltiples tablas de hechos que comparten tablas de dimensiones comunes (bus de dimensiones conforme).

---

## 4. Proceso ETL/ELT

### 4.1. Extracción
Obtención de datos desde las fuentes de origen. Puede ser completa (full load) o incremental (solo cambios desde la última extracción).

### 4.2. Transformación
Limpieza (valores nulos, duplicados, outliers), estandarización (formatos de fecha, unidades), integración (combinar datos de múltiples fuentes), enriquecimiento (cálculo de nuevas métricas), y aplicación de reglas de negocio.

### 4.3. Carga
Inserción de los datos transformados en el Data Warehouse. Puede ser sobreescritura total, carga incremental (UPSERT), o carga histórica (SCD — Slowly Changing Dimensions).

### 4.4. Tipos de SCD (Slowly Changing Dimensions)
- **Tipo 0:** No se actualizan los datos históricos.
- **Tipo 1:** Se sobrescribe el valor anterior (no se guarda historial).
- **Tipo 2:** Se crea un nuevo registro con fechas de vigencia (se guarda historial completo).
- **Tipo 3:** Se agrega una columna adicional para almacenar el valor anterior (historial limitado).

---

## 5. KPIs y Métricas

Los **Indicadores Clave de Desempeño (KPIs)** son métricas cuantificables que reflejan el rendimiento de la organización respecto a sus objetivos estratégicos. Un buen KPI debe ser:

- **Específico:** Relacionado directamente con un objetivo.
- **Medible:** Cuantificable con datos disponibles.
- **Alcanzable:** Realista en su meta.
- **Relevante:** Importante para la toma de decisiones.
- **Temporal:** Definido en un marco de tiempo.

Ejemplos de KPIs comunes: Ingresos mensuales, tasa de retención de clientes, margen bruto, costo de adquisición de clientes (CAC), valor de vida del cliente (CLV), rotación de inventario.

---

## 6. Visualización de Datos

La visualización de datos es la representación gráfica de la información para facilitar su comprensión y análisis. Principios fundamentales:

- **Claridad:** El gráfico debe comunicar el mensaje de forma intuitiva.
- **Contexto:** Incluir referencias (metas, promedios, periodos anteriores) para dar significado.
- **Evitar distorsiones:** Escalas adecuadas, no truncar ejes engañosamente.
- **Tipo de gráfico adecuado:** Barras (comparaciones), líneas (tendencias temporales), tortas (proporciones, limitado a pocas categorías), dispersión (correlaciones), mapas de calor (densidad).

Herramientas populares: Power BI, Tableau, Looker Studio, R (ggplot2), Python (Matplotlib, Seaborn, Plotly).

---

## 7. BI Moderno: Self-Service y Big Data

### 7.1. Self-Service BI
Permite a los usuarios de negocio generar sus propios reportes y análisis sin depender del departamento de TI. Características:
- Interfaces drag-and-drop intuitivas.
- Conexión directa a múltiples fuentes de datos.
- Lenguaje natural para consultas (NLQ).
- Colaboración y compartición de dashboards.

### 7.2. Big Data y BI
El volumen, velocidad y variedad de los datos modernos requieren infraestructuras escalables:
- **Procesamiento distribuido:** Hadoop, Spark.
- **Bases de datos NoSQL:** MongoDB, Cassandra.
- **Data Lakes en la nube:** Amazon S3, Azure Data Lake, Google Cloud Storage.
- **Procesamiento en streaming:** Kafka, Flink para análisis en tiempo real.

### 7.3. BI Prescriptivo y Predictivo
- **BI Descriptivo:** ¿Qué pasó? (reportes históricos, dashboards).
- **BI Diagnóstico:** ¿Por qué pasó? (análisis de causas raíz, drill-down).
- **BI Predictivo:** ¿Qué pasará? (modelos de machine learning, forecasting).
- **BI Prescriptivo:** ¿Qué deberíamos hacer? (optimización, simulación, recomendaciones).

---

## 8. Ciclo de Vida de un Proyecto de BI

1. **Definición del negocio:** Identificar objetivos, requerimientos y KPIs.
2. **Análisis de fuentes de datos:** Evaluar disponibilidad, calidad y estructura de los datos disponibles.
3. **Diseño del modelo de datos:** Esquema dimensional (estrella/copo de nieve), definición de hechos y dimensiones.
4. **Implementación ETL/ELT:** Construcción de pipelines de integración de datos.
5. **Desarrollo de reportes y dashboards:** Creación de visualizaciones que respondan a los requerimientos.
6. **Validación y testing:** Verificar la precisión de los datos, rendimiento de las consultas y usabilidad.
7. **Despliegue y capacitación:** Poner en producción y capacitar a los usuarios finales.
8. **Mantenimiento y evolución:** Monitoreo del rendimiento, actualización de fuentes, incorporación de nuevos requerimientos.

---

## 9. Herramientas Populares en BI

| Herramienta | Tipo | Características principales |
|---|---|---|
| **Power BI** | Visualización | Integración con Microsoft, DAX, Power Query, dashboards interactivos |
| **Tableau** | Visualización | Potente visualización, drag-and-drop, Tableau Prep para ETL |
| **Looker Studio** | Visualización | Gratuito, integración con Google Cloud, lenguaje LookML |
| **R** | Análisis estadístico | Gráficos con ggplot2, modelado, machine learning, código abierto |
| **Python** | Análisis general | Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn, gran ecosistema |
| **SQL** | Consulta de datos | Lenguaje estándar para acceder y manipular bases de datos relacionales |
| **Apache Spark** | Procesamiento big data | Procesamiento distribuido en memoria, MLlib, streaming |
| **dbt** | Transformación de datos | Transformaciones SQL en Data Warehouse, testing y documentación |

---

## 10. Observaciones

Business Intelligence es un campo fundamental en la era de los datos. Permite a las organizaciones pasar de decisiones basadas en la intuición a decisiones basadas en evidencia cuantitativa. Un proyecto de BI exitoso no solo depende de la tecnología, sino también de una comprensión profunda del negocio, datos de calidad, y una cultura organizacional orientada a la toma de decisiones informada. Con la evolución hacia el Big Data, el machine learning y las herramientas de Self-Service, el BI continúa siendo un pilar estratégico para la competitividad empresarial.

---
