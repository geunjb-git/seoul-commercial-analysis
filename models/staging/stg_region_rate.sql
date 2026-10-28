WITH source AS (
    SELECT *
    FROM {{ source(
        'seoul_commercial_raw',
        'region_rate'
    ) }}
),

renamed AS (
    SELECT
        SAFE_CAST(STDR_YYQU_CD AS INT64)
            AS quarter_code,

        CAST(SIGNGU_CD AS STRING)
            AS district_code,

        SIGNGU_CD_NM
            AS district_name,

        TRDAR_CHNGE_IX
            AS trade_area_change_index,

        TRDAR_CHNGE_IX_NM
            AS trade_area_change_name,

        SAFE_CAST(OPR_SALE_MT_AVRG AS FLOAT64)
            AS operating_month_average,

        SAFE_CAST(CLS_SALE_MT_AVRG AS FLOAT64)
            AS closing_month_average,

        SAFE_CAST(SU_OPR_SALE_MT_AVRG AS FLOAT64)
            AS seoul_operating_month_average,

        SAFE_CAST(SU_CLS_SALE_MT_AVRG AS FLOAT64)
            AS seoul_closing_month_average

    FROM source

    WHERE SAFE_CAST(STDR_YYQU_CD AS INT64)
        BETWEEN 20251 AND 20254
)

SELECT *
FROM renamed
