##
#  This dockerfile is used for local development and testing
##
# FROM apache/airflow:2.5.0

# USER root

# RUN sudo apt-get update \
#     && apt-get install -y --no-install-recommends \
#     gcc \
#     python3-distutils \
#     libpython3.9-dev

# USER airflow

# COPY --chown=airflow . .

# # We've had issues disabling poetry venv
# # See: https://github.com/python-poetry/poetry/issues/1214
# RUN python -m pip install .

# RUN pip install dbt-core dbt-snowflake

# # Setup dbt for the example project
# RUN pip install dbt-postgres==1.5.9

# RUN dbt deps --project-dir /opt/airflow/example_dbt_project



# FROM apache/airflow:2.5.0
# #root
# USER root 
# RUN apt-get update && apt-get install -y gcc python3-dev libffi-dev

# USER airflow

# # Project dependencies
# COPY --chown=airflow . .

# RUN pip install --upgrade pip

# # DBT + Adapters
# RUN pip install dbt-core==1.5.9 dbt-snowflake==1.5.1

# # SQLAlchemy Snowflake connector
# RUN pip install sqlalchemy==1.4.49 \
#     snowflake-connector-python==3.5.0 \
#     snowflake-sqlalchemy==1.4.7 \
#     "pyarrow>=10.0.1,<10.1.0" 
# # Dbt deps
# RUN dbt deps --project-dir /opt/airflow/example_dbt_project


FROM apache/airflow:2.5.0

# ✅ Chuyển về root để cài gói hệ thống
USER root
RUN apt-get update && apt-get install -y gcc python3-dev libffi-dev

# ✅ Quay lại user airflow (rất quan trọng!)
USER airflow

# Copy project code
COPY --chown=airflow . .

# Upgrade pip và cài các dependencies Python
RUN pip install --upgrade pip

# DBT + Snowflake Adapter
RUN pip install dbt-core==1.5.9 dbt-snowflake==1.5.1

# SQLAlchemy + Snowflake connector
RUN pip install \
    sqlalchemy==1.4.49 \
    snowflake-connector-python==2.7.12 \
    snowflake-sqlalchemy==1.4.7 \
    "pyarrow>=10.0.1,<10.1.0"

# Dbt deps (tùy chỉnh đường dẫn nếu cần)
RUN dbt deps --project-dir /opt/airflow/crypto_pipeline_project