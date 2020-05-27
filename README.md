# workers-kv-values
Creates a JSON array of all key values stored in a Workers KV namespace

## Usage

```bash
Creates a JSON array of all key values stored in a Workers KV namespace, where the values are strings.

 FLAGS:
 	-h	Prints help information

 ARGS:
 	<namespace> [Required] 	Workers kv namespace
 	<environment>		Defaults to none (dev environment)

 Dependencies:
 	wrangler - https://github.com/cloudflare/wrangler
 	jq - https://stedolan.github.io/jq/
  ```

Run this script in the same directory as your `wrangler.toml` file.

```bash
curl -fsSL "https://raw.githubusercontent.com/bradyjoslin/workers-kv-values/master/get_kvs.sh" | sh -s -- <namespace> <environment>
```
