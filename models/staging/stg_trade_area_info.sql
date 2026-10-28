WITH source AS (
    SELECT *
    FROM {{ source(
        'seoul_commercial_raw',
        'trade_area_info'
    ) }}
),

renamed AS (
    SELECT
        CAST(TRDAR_CD AS STRING)
            AS trade_area_code,

        TRDAR_CD_NM
            AS trade_area_name,

        TRDAR_SE_CD
            AS trade_area_type_code,

        TRDAR_SE_CD_NM
            AS trade_area_type_name,

        CAST(SIGNGU_CD AS STRING)
            AS district_code,

        SIGNGU_CD_NM
            AS district_name,

        CAST(ADSTRD_CD AS STRING)
            AS administrative_dong_code,

        ADSTRD_CD_NM
            AS administrative_dong_name,

        SAFE_CAST(XCNTS_VALUE AS FLOAT64)
            AS x_coordinate,

        SAFE_CAST(YDNTS_VALUE AS FLOAT64)
            AS y_coordinate,

        SAFE_CAST(RELM_AR AS FLOAT64)
            AS trade_area_size_m2

    FROM source
)

SELECT *
FROM renamed
