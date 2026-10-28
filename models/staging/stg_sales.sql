WITH source AS (
    SELECT *
    FROM {{ source('seoul_commercial_raw', 'sales') }}
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

        SVC_INDUTY_CD
            AS industry_code,

        SVC_INDUTY_CD_NM
            AS industry_name,

        SAFE_CAST(THSMON_SELNG_AMT AS FLOAT64)
            AS sales_amount,

        SAFE_CAST(THSMON_SELNG_CO AS FLOAT64)
            AS sales_count,

        SAFE_CAST(MDWK_SELNG_AMT AS FLOAT64)
            AS weekday_sales,

        SAFE_CAST(WKEND_SELNG_AMT AS FLOAT64)
            AS weekend_sales,

        SAFE_CAST(TMZON_00_06_SELNG_AMT AS FLOAT64)
            AS sales_00_06,

        SAFE_CAST(TMZON_06_11_SELNG_AMT AS FLOAT64)
            AS sales_06_11,

        SAFE_CAST(TMZON_11_14_SELNG_AMT AS FLOAT64)
            AS sales_11_14,

        SAFE_CAST(TMZON_14_17_SELNG_AMT AS FLOAT64)
            AS sales_14_17,

        SAFE_CAST(TMZON_17_21_SELNG_AMT AS FLOAT64)
            AS sales_17_21,

        SAFE_CAST(TMZON_21_24_SELNG_AMT AS FLOAT64)
            AS sales_21_24

    FROM source

    WHERE SAFE_CAST(STDR_YYQU_CD AS INT64)
        BETWEEN 20251 AND 20254
)

SELECT *
FROM renamed
