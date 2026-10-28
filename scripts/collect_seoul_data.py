import os
import requests
import pandas as pd

API_KEY = os.environ["SEOUL_OPEN_API_KEY"]
SERVICE = "VwsmTrdarStorQq"

quarters = ["20251", "20252", "20253", "20254"]

all_rows = []

for quarter in quarters:
    # 1. 해당 분기 전체 건수 확인
    url = (
        f"http://openapi.seoul.go.kr:8088/"
        f"{API_KEY}/json/{SERVICE}/1/1/{quarter}"
    )

    data = requests.get(url).json()
    total_count = data[SERVICE]["list_total_count"]

    print(f"{quarter}: {total_count}건")

    # 2. 1000건씩 수집
    for start in range(1, total_count + 1, 1000):
        end = min(start + 999, total_count)

        url = (
            f"http://openapi.seoul.go.kr:8088/"
            f"{API_KEY}/json/{SERVICE}/{start}/{end}/{quarter}"
        )

        data = requests.get(url).json()
        rows = data[SERVICE]["row"]

        all_rows.extend(rows)

        print(f"{quarter} | {start}~{end} 수집 완료")

df = pd.DataFrame(all_rows)

print(df["STDR_YYQU_CD"].value_counts().sort_index())
print("완전 중복:", df.duplicated().sum())

print(df.shape)

df.to_csv(
    "seoul_store_2025.csv",
    index=False,
    encoding="utf-8-sig"
)

print("CSV 저장 완료")

all_rows2 = []

SERVICE = "VwsmTrdarSelngQq"

quarters = ["20251", "20252", "20253", "20254"]

for quarter in quarters:

    url = (
        f"http://openapi.seoul.go.kr:8088/"
        f"{API_KEY}/json/{SERVICE}/1/1/{quarter}"
    )

    response = requests.get(url)
    data = response.json()

    total_count = data[SERVICE]["list_total_count"]

    print(quarter, ":", total_count, "건")

        # 2. 1000건씩 수집
    for start in range(1, total_count + 1, 1000):
        end = min(start + 999, total_count)

        url = (
            f"http://openapi.seoul.go.kr:8088/"
            f"{API_KEY}/json/{SERVICE}/{start}/{end}/{quarter}"
        )

        data = requests.get(url).json()
        rows = data[SERVICE]["row"]

        all_rows2.extend(rows)

        print(f"{quarter} | {start}~{end} 수집 완료")

df = pd.DataFrame(all_rows2)

print(df["STDR_YYQU_CD"].value_counts().sort_index())
print("완전 중복:", df.duplicated().sum())
df.drop_duplicates(inplace=True)

print(df.shape)

df.to_csv(
    "seoul_sales_2025.csv",
    index=False,
    encoding="utf-8-sig"
)

print("CSV 저장 완료")





all_rows3 = []

SERVICE = "VwsmTrdarFlpopQq"

quarters = ["20251", "20252", "20253", "20254"]

for quarter in quarters:

    url = (
        f"http://openapi.seoul.go.kr:8088/"
        f"{API_KEY}/json/{SERVICE}/1/1/{quarter}"
    )

    response = requests.get(url)
    data = response.json()

    total_count = data[SERVICE]["list_total_count"]

    print(quarter, ":", total_count, "건")

        # 2. 1000건씩 수집
    for start in range(1, total_count + 1, 1000):
        end = min(start + 999, total_count)

        url = (
            f"http://openapi.seoul.go.kr:8088/"
            f"{API_KEY}/json/{SERVICE}/{start}/{end}/{quarter}"
        )

        data = requests.get(url).json()
        rows = data[SERVICE]["row"]

        all_rows3.extend(rows)

        print(f"{quarter} | {start}~{end} 수집 완료")

df = pd.DataFrame(all_rows3)

print(df["STDR_YYQU_CD"].value_counts().sort_index())
print("완전 중복:", df.duplicated().sum())
df.drop_duplicates(inplace=True)

print(df.shape)


df.to_csv(
    "seoul_s_population_2025.csv",
    index=False,
    encoding="utf-8-sig"
)

print("CSV 저장 완료")

#---------------------------------------------------------------

SERVICE = "VwsmTrdarWrcPopltnQq"

all_rows4 = []

url = (
    f"http://openapi.seoul.go.kr:8088/"
    f"{API_KEY}/json/{SERVICE}/1/1"
)

data = requests.get(url).json()

total_count = data[SERVICE]["list_total_count"]

print("전체 데이터:", total_count)

for start in range(1, total_count + 1, 1000):

    end = min(start + 999, total_count)

    url = (
        f"http://openapi.seoul.go.kr:8088/"
        f"{API_KEY}/json/{SERVICE}/{start}/{end}"
    )

    data = requests.get(url).json()

    rows = data[SERVICE]["row"]

    all_rows4.extend(rows)

    print(f"{start} ~ {end} 수집 완료")

df = pd.DataFrame(all_rows4)

print(df.shape)


print(
    df["STDR_YYQU_CD"]
    .value_counts()
    .sort_index()
)

df.to_csv(
    "seoul_worker_population_raw.csv",
    index=False,
    encoding="utf-8-sig"
)

#-----------------------------------------------

SERVICE = "VwsmTrdarFcltyQq"

all_rows5 = []

url = (
    f"http://openapi.seoul.go.kr:8088/"
    f"{API_KEY}/json/{SERVICE}/1/1"
)

data = requests.get(url).json()

total_count = data[SERVICE]["list_total_count"]

print("전체 데이터:", total_count)

for start in range(1, total_count + 1, 1000):

    end = min(start + 999, total_count)

    url = (
        f"http://openapi.seoul.go.kr:8088/"
        f"{API_KEY}/json/{SERVICE}/{start}/{end}"
    )

    data = requests.get(url).json()

    rows = data[SERVICE]["row"]

    all_rows5.extend(rows)

    print(f"{start} ~ {end} 수집 완료")

df = pd.DataFrame(all_rows5)

print(df.shape)


print(
    df["STDR_YYQU_CD"]
    .value_counts()
    .sort_index()
)

df.to_csv(
    "seoul_viatr_raw.csv",
    index=False,
    encoding="utf-8-sig"
)


# http://openapi.seoul.go.kr:8088/(인증키)/xml/VwsmSignguIxQq/1/5/


SERVICE = "VwsmSignguIxQq"

all_rows6 = []

url = (
    f"http://openapi.seoul.go.kr:8088/"
    f"{API_KEY}/json/{SERVICE}/1/1"
)

data = requests.get(url).json()

total_count = data[SERVICE]["list_total_count"]

print("전체 데이터:", total_count)

for start in range(1, total_count + 1, 1000):

    end = min(start + 999, total_count)

    url = (
        f"http://openapi.seoul.go.kr:8088/"
        f"{API_KEY}/json/{SERVICE}/{start}/{end}"
    )

    data = requests.get(url).json()

    rows = data[SERVICE]["row"]

    all_rows6.extend(rows)

    print(f"{start} ~ {end} 수집 완료")

df = pd.DataFrame(all_rows6)

print(df.shape)


print(
    df["STDR_YYQU_CD"]
    .value_counts()
    .sort_index()
)

df.to_csv(
    "seoul_region_rate_raw.csv",
    index=False,
    encoding="utf-8-sig"
)

# http://openapi.seoul.go.kr:8088/(인증키)/xml/TbgisTrdarRelm/1/5/  seoul_store_info


SERVICE = "TbgisTrdarRelm"

all_rows7 = []

url = (
    f"http://openapi.seoul.go.kr:8088/"
    f"{API_KEY}/json/{SERVICE}/1/1"
)

data = requests.get(url).json()

total_count = data[SERVICE]["list_total_count"]

print("전체 데이터:", total_count)

for start in range(1, total_count + 1, 1000):

    end = min(start + 999, total_count)

    url = (
        f"http://openapi.seoul.go.kr:8088/"
        f"{API_KEY}/json/{SERVICE}/{start}/{end}"
    )

    data = requests.get(url).json()

    rows = data[SERVICE]["row"]

    all_rows7.extend(rows)

    print(f"{start} ~ {end} 수집 완료")

df = pd.DataFrame(all_rows7)

print(df.shape)

df.to_csv(
    "seoul_store_info.csv",
    index=False,
    encoding="utf-8-sig"
)
