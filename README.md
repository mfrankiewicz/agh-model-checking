# Checking specs
1. `read_model -i model.smv`
2. `flatten_hierarchy`
3. `encode_variables`
4. `build_model -f -m Threshold`
5. `check_ltlspec -p "$FORMULA"`
