data "google_cloudfunctions2_function" "id-c3d-parse-api" {
  name = ("${var.prefix_env}-${var.c3d_parse_api_function_name}")
}

data "google_cloudfunctions2_function" "id-c3d-upload-api" {
  name = ("${var.prefix_env}-${var.c3d_upload_api_function_name}")
}

data "google_cloudfunctions2_function" "id-json-getter-api" {
  name = ("${var.prefix_env}-${var.json_getter_api_function_name}")
}

resource "google_project_service" "ciam" {
  service = "identitytoolkit.googleapis.com"
}

resource "google_identity_platform_config" "ciam-config-c3d-parse-api" {
  autodelete_anonymous_users = true
  blocking_functions {
    triggers {
      event_type = "beforeSignIn"
      function_uri = google_cloudfunctions2_function.id-c3d-parse-api.service_config[0].uri
    }
    forward_inbound_credentials {
      refresh_token = true
      access_token = true
      id_token = true
    }
  }
  authorized_domains = [
    "localhost",
    "moveshelf.com",
    "api.movshelf.com",
  ]
}

resource "google_identity_platform_config" "ciam-config-c3d-upload-api" {
  autodelete_anonymous_users = true
  blocking_functions {
    triggers {
      event_type = "beforeSignIn"
      function_uri = google_cloudfunctions2_function.id-c3d-upload-api.service_config[0].uri
    }
    forward_inbound_credentials {
      refresh_token = true
      access_token = true
      id_token = true
    }
  }
  authorized_domains = [
    "localhost",
    "moveshelf.com",
    "api.movshelf.com",
  ]
}

resource "google_identity_platform_config" "ciam-config-json-getter-api" {
  autodelete_anonymous_users = true
  blocking_functions {
    triggers {
      event_type = "beforeSignIn"
      function_uri = google_cloudfunctions2_function.id-json-getter-api.service_config[0].uri
    }
    forward_inbound_credentials {
      refresh_token = true
      access_token = true
      id_token = true
    }
  }
  authorized_domains = [
    "localhost",
    "moveshelf.com",
    "api.movshelf.com",
  ]
}

resource "google_api_gateway_api" "apigw" {
  provider = google-beta.api
  api_id   = ("${var.prefix}-${var.apigw_name}")
}

resource "google_api_gateway_api_config" "apigw-config" {
  provider      = google-beta.api
  api           = google_api_gateway_api.apigw.api_id
  api_config_id = ("${var.prefix}-${var.apigw_config_name}")

  openapi_documents {
    document {
      path     = "api_spec.yaml"
      contents = filebase64("api_spec.yaml")
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "apigw-gateway" {
  provider   = google-beta.api
  api_config = google_api_gateway_api_config.apigw.id
  gateway_id = ("${var.prefix}-${var.apigw_gateway_name}")
}