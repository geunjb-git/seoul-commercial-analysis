WITH sales_industry_keys AS (
    SELECT DISTINCT
        quarter_code,
        trade_area_code,
        industry_code

    FROM {{ ref('stg_sales') }}
),

sales_agg AS (
    SELECT
        quarter_code,
        trade_area_code,

        ANY_VALUE(trade_area_name)
            AS trade_area_name,

        ANY_VALUE(trade_area_type_code)
            AS trade_area_type_code,

        ANY_VALUE(trade_area_type_name)
            AS trade_area_type_name,

        SUM(sales_amount)
            AS total_sales,

        SUM(sales_count)
            AS total_sales_count,

        SUM(weekday_sales)
            AS weekday_sales,

        SUM(weekend_sales)
            AS weekend_sales,

        SUM(sales_00_06)
            AS sales_00_06,

        SUM(sales_06_11)
            AS sales_06_11,

        SUM(sales_11_14)
            AS sales_11_14,

        SUM(sales_14_17)
            AS sales_14_17,

        SUM(sales_17_21)
            AS sales_17_21,

        SUM(sales_21_24)
            AS sales_21_24,

        COUNT(DISTINCT industry_code)
            AS sales_industry_count

    FROM {{ ref('stg_sales') }}

    GROUP BY
        quarter_code,
        trade_area_code
),

store_agg AS (
    SELECT
        st.quarter_code,
        st.trade_area_code,

        SUM(st.total_store_count)
            AS total_store_count,

        SUM(st.non_franchise_store_count)
            AS non_franchise_store_count,

        SUM(st.franchise_store_count)
            AS franchise_store_count,

        SUM(st.open_store_count)
            AS open_store_count,

        SUM(st.close_store_count)
            AS close_store_count,

        COUNT(DISTINCT st.industry_code)
            AS store_industry_count

    FROM {{ ref('stg_store') }} AS st

    INNER JOIN sales_industry_keys AS sk
        ON st.quarter_code = sk.quarter_code
       AND st.trade_area_code = sk.trade_area_code
       AND st.industry_code = sk.industry_code

    GROUP BY
        st.quarter_code,
        st.trade_area_code
),

final AS (
    SELECT
        CONCAT(
            CAST(s.quarter_code AS STRING),
            '-',
            s.trade_area_code
        ) AS trade_area_quarter_key,

        s.quarter_code,
        s.trade_area_code,
        s.trade_area_name,
        s.trade_area_type_code,
        s.trade_area_type_name,

        info.district_code,
        info.district_name,
        info.administrative_dong_code,
        info.administrative_dong_name,
        info.x_coordinate,
        info.y_coordinate,
        info.trade_area_size_m2,

        s.total_sales,
        s.total_sales_count,
        s.weekday_sales,
        s.weekend_sales,
        s.sales_00_06,
        s.sales_06_11,
        s.sales_11_14,
        s.sales_14_17,
        s.sales_17_21,
        s.sales_21_24,
        s.sales_industry_count,

        st.total_store_count,
        st.non_franchise_store_count,
        st.franchise_store_count,
        st.open_store_count,
        st.close_store_count,
        st.store_industry_count,

        fp.total_floating_population,
        fp.weekday_floating_population,
        fp.weekend_floating_population,
        fp.flow_00_06,
        fp.flow_06_11,
        fp.flow_11_14,
        fp.flow_14_17,
        fp.flow_17_21,
        fp.flow_21_24,

        wp.total_worker_population,
        wp.male_worker_population,
        wp.female_worker_population,

        vf.total_visitor_facility_count,
        vf.transport_facility_count,
        vf.shopping_culture_facility_count,
        vf.medical_facility_count,
        vf.education_facility_count,
        vf.public_finance_facility_count,
        vf.accommodation_facility_count,

        rr.trade_area_change_index,
        rr.trade_area_change_name,
        rr.operating_month_average,
        rr.closing_month_average,
        rr.seoul_operating_month_average,
        rr.seoul_closing_month_average

    FROM sales_agg AS s

    LEFT JOIN store_agg AS st
        ON s.quarter_code = st.quarter_code
       AND s.trade_area_code = st.trade_area_code

    LEFT JOIN {{ ref('stg_street_population') }} AS fp
        ON s.quarter_code = fp.quarter_code
       AND s.trade_area_code = fp.trade_area_code

    LEFT JOIN {{ ref('stg_worker_population') }} AS wp
        ON s.quarter_code = wp.quarter_code
       AND s.trade_area_code = wp.trade_area_code

    LEFT JOIN {{ ref('stg_visitor_facility') }} AS vf
        ON s.quarter_code = vf.quarter_code
       AND s.trade_area_code = vf.trade_area_code

    LEFT JOIN {{ ref('stg_trade_area_info') }} AS info
        ON s.trade_area_code = info.trade_area_code

    LEFT JOIN {{ ref('stg_region_rate') }} AS rr
        ON s.quarter_code = rr.quarter_code
       AND info.district_code = rr.district_code
)

SELECT *
FROM final
