WITH source AS (
    SELECT *
    FROM {{ source('seoul_commercial_raw', 'store') }}
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

        SAFE_CAST(SIMILR_INDUTY_STOR_CO AS FLOAT64)
            AS total_store_count,

        SAFE_CAST(STOR_CO AS FLOAT64)
            AS non_franchise_store_count,

        SAFE_CAST(FRC_STOR_CO AS FLOAT64)
            AS franchise_store_count,

        SAFE_CAST(OPBIZ_STOR_CO AS FLOAT64)
            AS open_store_count,

        SAFE_CAST(CLSBIZ_STOR_CO AS FLOAT64)
            AS close_store_count,

        SAFE_CAST(OPBIZ_RT AS FLOAT64)
            AS open_business_rate,

        SAFE_CAST(CLSBIZ_RT AS FLOAT64)
            AS close_business_rate

    FROM source

    WHERE SAFE_CAST(STDR_YYQU_CD AS INT64)
        BETWEEN 20251 AND 20254
)

SELECT *
FROM renamed
