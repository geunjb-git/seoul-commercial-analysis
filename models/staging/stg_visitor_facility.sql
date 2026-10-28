WITH source AS (
    SELECT *
    FROM {{ source(
        'seoul_commercial_raw',
        'visitor_facility'
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

        SAFE_CAST(VIATR_FCLTY_CO AS FLOAT64)
            AS total_visitor_facility_count,

        COALESCE(
            SAFE_CAST(RLROAD_STATN_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(BUS_TRMINL_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(SUBWAY_STATN_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(BUS_STTN_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(ARPRT_CO AS FLOAT64),
            0
        ) AS transport_facility_count,

        COALESCE(
            SAFE_CAST(DRTS_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(SUPMK_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(THEAT_CO AS FLOAT64),
            0
        ) AS shopping_culture_facility_count,

        COALESCE(
            SAFE_CAST(GEHSPT_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(GNRL_HSPTL_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(PARMACY_CO AS FLOAT64),
            0
        ) AS medical_facility_count,

        COALESCE(
            SAFE_CAST(KNDRGR_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(ELESCH_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(MSKUL_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(HGSCHL_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(UNIV_CO AS FLOAT64),
            0
        ) AS education_facility_count,

        COALESCE(
            SAFE_CAST(PBLOFC_CO AS FLOAT64),
            0
        )
        + COALESCE(
            SAFE_CAST(BANK_CO AS FLOAT64),
            0
        ) AS public_finance_facility_count,

        SAFE_CAST(STAYNG_FCLTY_CO AS FLOAT64)
            AS accommodation_facility_count

    FROM source

    WHERE SAFE_CAST(STDR_YYQU_CD AS INT64)
        BETWEEN 20251 AND 20254
)

SELECT *
FROM renamed
