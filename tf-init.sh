set -x 
      export PATH=.:${PATH}
      terraform init \
        -backend-config "dynamodb_table=$TF_VAR_dynamodb_table" \
        -backend-config "key=$TF_VAR_s3_lock_object" \
        -backend-config "region=$TF_VAR_region" \
        -backend-config "bucket=$TF_VAR_bucket" 
