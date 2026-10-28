WITH source AS (
    SELECT *
    FROM {{ source(
        'seoul_commercial_raw',
        'worker_population'
    ) }}
),

renamed AS (
    SELECT
        SAFE_CAST(STDR_YYQU_CD AS INT64)
            AS quarter_code,

        CAST(TRDAR_CD AS STRING)
            AS trade_area_code,

        TRDAR_CD_NM
            AS trade_area_name,

        TRDAR_SE_CD
            AS trade_area_type_code,

        TRDAR_SE_CD_NM
            AS trade_area_type_name,

        SAFE_CAST(TOT_WRC_POPLTN_CO AS FLOAT64)
            AS total_worker_population,

        SAFE_CAST(ML_WRC_POPLTN_CO AS FLOAT64)
            AS male_worker_population,

        SAFE_CAST(FML_WRC_POPLTN_CO AS FLOAT64)
            AS female_worker_population

    FROM source

    WHERE SAFE_CAST(STDR_YYQU_CD AS INT64)
        BETWEEN 20251 AND 20254
)

SELECT *
FROM renamed
