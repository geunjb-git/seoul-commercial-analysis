"""Upload local CSV files to a Google Cloud Storage raw-data prefix.

Example:
    python scripts/upload_to_gcs.py --source-dir ./data

Authentication uses Application Default Credentials. Run
`gcloud auth application-default login` before executing this script locally.
"""

from __future__ import annotations

import argparse
from pathlib import Path, PurePosixPath

from google.cloud import storage


DEFAULT_PROJECT_ID = "bonggeunj"
DEFAULT_BUCKET_NAME = "codeit-data15-practice-dion"
DEFAULT_GCS_PREFIX = "seoul_commercial/raw"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Upload every CSV in a local directory to GCS."
    )
    parser.add_argument(
        "--project",
        default=DEFAULT_PROJECT_ID,
        help=f"GCP project ID. Default: {DEFAULT_PROJECT_ID}",
    )
    parser.add_argument(
        "--bucket",
        default=DEFAULT_BUCKET_NAME,
        help=f"Destination GCS bucket name. Default: {DEFAULT_BUCKET_NAME}",
    )
    parser.add_argument(
        "--source-dir",
        required=True,
        type=Path,
        help="Directory containing the CSV files to upload.",
    )
    parser.add_argument(
        "--prefix",
        default=DEFAULT_GCS_PREFIX,
        help=f"GCS object prefix. Default: {DEFAULT_GCS_PREFIX}",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Overwrite an object when a file with the same name already exists.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    source_dir = args.source_dir.expanduser().resolve()

    if not source_dir.is_dir():
        raise NotADirectoryError(f"CSV directory not found: {source_dir}")

    csv_files = sorted(source_dir.glob("*.csv"))
    if not csv_files:
        raise FileNotFoundError(f"No CSV files found in: {source_dir}")

    client = storage.Client(project=args.project)
    bucket = client.bucket(args.bucket)
    prefix = args.prefix.strip("/")

    uploaded_count = 0
    skipped_count = 0

    for csv_path in csv_files:
        object_name = str(PurePosixPath(prefix, csv_path.name))
        blob = bucket.blob(object_name)

        if not args.overwrite and blob.exists(client=client):
            print(f"SKIP already exists: gs://{args.bucket}/{object_name}")
            skipped_count += 1
            continue

        blob.upload_from_filename(csv_path, content_type="text/csv")
        print(f"UPLOAD {csv_path} -> gs://{args.bucket}/{object_name}")
        uploaded_count += 1

    print(
        f"Completed: uploaded={uploaded_count}, skipped={skipped_count}, "
        f"total={len(csv_files)}"
    )


if __name__ == "__main__":
    main()
