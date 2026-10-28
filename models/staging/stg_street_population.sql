WITH source AS (
    SELECT *
    FROM {{ source(
        'seoul_commercial_raw',
        'street_population'
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

        SAFE_CAST(TOT_FLPOP_CO AS FLOAT64)
            AS total_floating_population,

        SAFE_CAST(MON_FLPOP_CO AS FLOAT64)
            + SAFE_CAST(TUES_FLPOP_CO AS FLOAT64)
            + SAFE_CAST(WED_FLPOP_CO AS FLOAT64)
            + SAFE_CAST(THUR_FLPOP_CO AS FLOAT64)
            + SAFE_CAST(FRI_FLPOP_CO AS FLOAT64)
            AS weekday_floating_population,

        SAFE_CAST(SAT_FLPOP_CO AS FLOAT64)
            + SAFE_CAST(SUN_FLPOP_CO AS FLOAT64)
            AS weekend_floating_population,

        SAFE_CAST(TMZON_00_06_FLPOP_CO AS FLOAT64)
            AS flow_00_06,

        SAFE_CAST(TMZON_06_11_FLPOP_CO AS FLOAT64)
            AS flow_06_11,

        SAFE_CAST(TMZON_11_14_FLPOP_CO AS FLOAT64)
            AS flow_11_14,

        SAFE_CAST(TMZON_14_17_FLPOP_CO AS FLOAT64)
            AS flow_14_17,

        SAFE_CAST(TMZON_17_21_FLPOP_CO AS FLOAT64)
            AS flow_17_21,

        SAFE_CAST(TMZON_21_24_FLPOP_CO AS FLOAT64)
            AS flow_21_24

    FROM source

    WHERE SAFE_CAST(STDR_YYQU_CD AS INT64)
        BETWEEN 20251 AND 20254
)

SELECT *
FROM renamed
