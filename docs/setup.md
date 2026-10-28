# 실행 준비 안내

이 묶음은 기존 분석의 코드와 요약 문서를 공개용으로 정리한 사본입니다. 원본 클라우드 데이터나 개인 인증 정보를 포함하지 않으며, 별도의 환경에서 전체 파이프라인을 새로 실행한 결과를 보증하지 않습니다.

1. Python 가상환경을 만들고 코드의 import에 필요한 패키지를 설치합니다. 주요 구성은 pandas, NumPy, requests, matplotlib, seaborn, scikit-learn, google-cloud-bigquery, google-cloud-storage, dbt-bigquery와 Jupyter입니다.
2. 서울 공공데이터 API 키를 `SEOUL_OPEN_API_KEY` 환경변수로 설정합니다. `.env.example`은 항목 예시이며 이 파일만 복사해도 Python에서 자동 로드되는 것은 아닙니다.
3. 본인의 GCP 프로젝트·데이터셋과 인증을 준비하고 SQL 및 노트북의 프로젝트/데이터셋 참조를 자신의 환경에 맞춥니다.
4. `profiles.yml`은 개인 환경에서 생성하고 업로드하지 않습니다. 기본 프로젝트 프로필 이름은 `seoul_commercial_dbt`입니다.
5. 원본 7종 수집과 수동 GCS·BigQuery Raw 적재를 완료한 후, staging·mart와 데이터 검증을 수행합니다.
6. 전체 분석 노트북을 순서대로 실행합니다. 코드는 기존 분석 환경을 전제로 하므로 경로와 프로젝트 설정을 먼저 점검합니다.

수집 스크립트의 API 키는 환경변수 참조로 바꿨습니다. 노트북의 기존 출력과 실행 횟수는 공개용 사본에서 제거했으므로 결과 요약은 README 및 분석 상세 문서를 함께 확인하세요. 저장된 요약 수치 자체는 새로 실행한 결과가 아닙니다.
