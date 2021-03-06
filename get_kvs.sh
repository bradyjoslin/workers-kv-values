#!/bin/bash

# Creates a JSON array of all key values stored in a Workers KV namespace, 
# where the values are strings.
#
# FLAGS:        
#               -h            Prints help information
# ARGS:         
#               <namespace>   [Required] Workers kv namespace
#               <environment> Defaults to none (dev environment)
# Dependencies: 
#               wrangler      https://github.com/cloudflare/wrangler
#               jq            https://stedolan.github.io/jq/

USAGE=$(cat <<-END
Creates a JSON array of all key values stored in a Workers KV namespace, 
where the values are strings.

FLAGS:
              -h    Prints help information
ARGS:
              <namespace>    [Required]    Workers kv namespace
              <environment>                Defaults to none (dev environment)
Dependencies:
              wrangler - https://github.com/cloudflare/wrangler
              jq - https://stedolan.github.io/jq/
END
)

if [ "${1}" = "-h" ]; then
  echo "${USAGE}"
  exit 0
fi

kv_namespace_in=${1}
kv_environment_in=${2}

if [ -z "${kv_namespace_in}" ]; then
    echo "Error! namespace argument required"
    echo ""
    echo "${USAGE}"
    exit 1
fi

if [ -z "${kv_environment_in}" ]; then
    env_arg=""
else
    env_arg="--env=${kv_environment_in}"
fi

for key in $(wrangler kv:key list --binding=${kv_namespace_in} $env_arg | jq -r '.[] | .name'); 
do
    value=$(wrangler kv:key get --binding=${kv_namespace_in} $env_arg ${key})
    kv_out=$kv_out{\"key\":\"${key}\",\"value\":\"${value}\"},
done;

echo "[${kv_out%?}]" | jq .;
