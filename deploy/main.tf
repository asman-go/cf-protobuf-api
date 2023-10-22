terraform {
  cloud {}

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id  = "b1g2amdfmrmrjn7ci2rm"
  folder_id = "b1gr7b87128mt4levqg1"
  zone      = "ru-central1-a"
}

data "archive_file" "cf-archive" {
  type        = "zip"
  source_dir  = "${path.module}/../src"
  output_path = "${path.module}/../cf-bbprogram.zip"
}

resource "yandex_function" "cf-bbprogram" {
  name              = "cf-bbprogram"
  description       = "Upload bb program information"
  user_hash         = data.archive_file.cf-archive.output_base64sha256 # Должна меняться, иначе версия функции не создастся
  runtime           = "python311"
  entrypoint        = "main.event_handler"
  memory            = "128" # 128 MB
  execution_timeout = "10"  # 10 seconds

  content {
    zip_filename = data.archive_file.cf-archive.output_path
  }
}
