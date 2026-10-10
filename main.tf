resource "aws_comprehend_document_classifier" "comprehend_document_classifiers" {
  for_each = var.comprehend_document_classifiers

  data_access_role_arn = each.value.data_access_role_arn
  language_code        = each.value.language_code
  name                 = each.value.name
  mode                 = each.value.mode
  model_kms_key_id     = each.value.model_kms_key_id
  region               = each.value.region
  tags                 = each.value.tags
  tags_all             = each.value.tags_all
  version_name         = each.value.version_name
  version_name_prefix  = each.value.version_name_prefix
  volume_kms_key_id    = each.value.volume_kms_key_id

  input_data_config {
    dynamic "augmented_manifests" {
      for_each = each.value.input_data_config.augmented_manifests != null ? each.value.input_data_config.augmented_manifests : []
      content {
        annotation_data_s3_uri  = augmented_manifests.value.annotation_data_s3_uri
        attribute_names         = augmented_manifests.value.attribute_names
        document_type           = augmented_manifests.value.document_type
        s3_uri                  = augmented_manifests.value.s3_uri
        source_documents_s3_uri = augmented_manifests.value.source_documents_s3_uri
        split                   = augmented_manifests.value.split
      }
    }
    data_format     = each.value.input_data_config.data_format
    label_delimiter = each.value.input_data_config.label_delimiter
    s3_uri          = each.value.input_data_config.s3_uri
    test_s3_uri     = each.value.input_data_config.test_s3_uri
  }

  dynamic "output_data_config" {
    for_each = each.value.output_data_config != null ? [each.value.output_data_config] : []
    content {
      kms_key_id = output_data_config.value.kms_key_id
      s3_uri     = output_data_config.value.s3_uri
    }
  }

  dynamic "vpc_config" {
    for_each = each.value.vpc_config != null ? [each.value.vpc_config] : []
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnets            = vpc_config.value.subnets
    }
  }
}

